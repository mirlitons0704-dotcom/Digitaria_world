import 'jsr:@supabase/functions-js/edge-runtime.d.ts';
import { createClient } from 'npm:@supabase/supabase-js@2.57.4';

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, Authorization, X-Client-Info, Apikey',
};

function jsonResponse(data: unknown, status = 200) {
  return new Response(JSON.stringify(data), {
    status,
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
  });
}

function errorResponse(message: string, status = 400) {
  return jsonResponse({ error: message }, status);
}

/** Count {{image:...}} and {{video:...}} markers inside content text. */
function countMediaMarkers(content: string): number {
  const re = /\{\{(image|video):[^}]+\}\}/g;
  return (content.match(re) || []).length;
}

/** Extract all {{image:...}} / {{video:...}} URLs from content. */
function extractMediaUrls(content: string): string[] {
  const re = /\{\{(?:image|video):([^}]+)\}\}/g;
  const urls: string[] = [];
  let m;
  while ((m = re.exec(content)) !== null) {
    urls.push(m[1]);
  }
  return urls;
}

Deno.serve(async (req: Request) => {
  if (req.method === 'OPTIONS') {
    return new Response(null, { status: 200, headers: corsHeaders });
  }

  try {
    // ---------- Auth: verify the caller is an admin ----------
    const authHeader = req.headers.get('Authorization') ?? '';
    const supabaseUrl = Deno.env.get('SUPABASE_URL')!;
    const serviceRoleKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!;

    // Client with service role (bypasses RLS)
    const supabase = createClient(supabaseUrl, serviceRoleKey);

    // Verify token belongs to an admin user
    const token = authHeader.replace(/^Bearer\s+/i, '');
    if (!token) return errorResponse('Authentication required', 401);

    const {
      data: { user },
      error: authError,
    } = await supabase.auth.getUser(token);
    if (authError || !user) return errorResponse('Invalid token', 401);

    // Check admin flag in profiles table
    const { data: profile } = await supabase
      .from('profiles')
      .select('is_admin')
      .eq('id', user.id)
      .maybeSingle();

    if (!profile?.is_admin) return errorResponse('Admin access required', 403);

    // ---------- Parse request ----------
    const body = await req.json();
    const { action } = body;

    // ==================== LIST ====================
    if (action === 'list') {
      const { chapterId } = body;
      let query = supabase
        .from('story_scenes')
        .select('id, chapter_id, scene_number, title, content, image_url')
        .order('chapter_id')
        .order('scene_number');

      if (chapterId) {
        query = query.eq('chapter_id', chapterId);
      }

      const { data: scenes, error } = await query;
      if (error) return errorResponse(error.message, 500);

      const result = (scenes || []).map((s) => ({
        id: s.id,
        chapter_id: s.chapter_id,
        scene_number: s.scene_number,
        title: s.title,
        image_url: s.image_url,
        inline_image_count: countMediaMarkers(s.content),
        inline_image_urls: extractMediaUrls(s.content),
        content: s.content,
      }));

      return jsonResponse({ scenes: result });
    }

    // ==================== UPLOAD ====================
    if (action === 'upload') {
      const { base64, filename, contentType } = body;
      if (!base64 || !filename) {
        return errorResponse('base64 and filename are required');
      }

      const binaryString = atob(base64);
      const bytes = new Uint8Array(binaryString.length);
      for (let i = 0; i < binaryString.length; i++) {
        bytes[i] = binaryString.charCodeAt(i);
      }

      const { data, error } = await supabase.storage.from('assets').upload(filename, bytes, {
        contentType: contentType || 'image/png',
        upsert: true,
      });

      if (error) return errorResponse(error.message, 500);

      const publicUrl = `${supabaseUrl}/storage/v1/object/public/assets/${data.path}`;
      return jsonResponse({ success: true, path: data.path, publicUrl });
    }

    // ==================== SET-IMAGE-URL ====================
    if (action === 'set-image-url') {
      const { sceneId, url } = body;
      if (!sceneId) return errorResponse('sceneId is required');

      const { error } = await supabase
        .from('story_scenes')
        .update({ image_url: url || null })
        .eq('id', sceneId);

      if (error) return errorResponse(error.message, 500);
      return jsonResponse({ success: true });
    }

    // ==================== INSERT-INLINE ====================
    if (action === 'insert-inline') {
      const { sceneId, url, paragraphIndex, size } = body;
      if (!sceneId || !url || paragraphIndex === undefined) {
        return errorResponse('sceneId, url, and paragraphIndex are required');
      }

      // Fetch current content
      const { data: scene, error: fetchError } = await supabase
        .from('story_scenes')
        .select('content')
        .eq('id', sceneId)
        .maybeSingle();

      if (fetchError) return errorResponse(fetchError.message, 500);
      if (!scene) return errorResponse('Scene not found', 404);

      // Split by double-newline (paragraph boundary)
      const paragraphs = scene.content.split(/\n\n/);
      const validSizes = ['sm', 'md', 'lg', 'full'];
      const sizeSuffix = size && validSizes.includes(size) ? `|size=${size}` : '';
      const marker = `{{image:${url}${sizeSuffix}}}`;

      // Insert after the specified paragraph index
      const insertIdx = Math.min(paragraphIndex + 1, paragraphs.length);
      paragraphs.splice(insertIdx, 0, marker);

      const newContent = paragraphs.join('\n\n');

      const { error: updateError } = await supabase
        .from('story_scenes')
        .update({ content: newContent })
        .eq('id', sceneId);

      if (updateError) return errorResponse(updateError.message, 500);
      return jsonResponse({ success: true, content: newContent });
    }

    // ==================== UPDATE-INLINE-SIZE ====================
    if (action === 'update-inline-size') {
      const { sceneId, imageUrl, newSize } = body;
      if (!sceneId || !imageUrl) {
        return errorResponse('sceneId and imageUrl are required');
      }

      const validSizes = ['sm', 'md', 'lg', 'full'];
      if (newSize && !validSizes.includes(newSize)) {
        return errorResponse(`Invalid size: ${newSize}. Must be one of: ${validSizes.join(', ')}`);
      }

      const { data: scene, error: fetchError } = await supabase
        .from('story_scenes')
        .select('content')
        .eq('id', sceneId)
        .maybeSingle();

      if (fetchError) return errorResponse(fetchError.message, 500);
      if (!scene) return errorResponse('Scene not found', 404);

      // Match the marker for this specific image URL (with or without existing size)
      const escaped = imageUrl.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
      const markerRe = new RegExp(`\\{\\{(image|video):${escaped}(\\|size=\\w+)?\\}\\}`);

      const match = scene.content.match(markerRe);
      if (!match) return errorResponse('Image marker not found in content', 404);

      const type = match[1];
      const sizeSuffix = newSize && newSize !== 'md' ? `|size=${newSize}` : '';
      const newMarker = `{{${type}:${imageUrl}${sizeSuffix}}}`;
      const newContent = scene.content.replace(markerRe, newMarker);

      const { error: updateError } = await supabase
        .from('story_scenes')
        .update({ content: newContent })
        .eq('id', sceneId);

      if (updateError) return errorResponse(updateError.message, 500);
      return jsonResponse({ success: true, content: newContent });
    }

    // ==================== REMOVE-IMAGE ====================
    if (action === 'remove-image') {
      const { sceneId, imageUrl, target } = body;
      if (!sceneId) return errorResponse('sceneId is required');

      if (target === 'image_url') {
        // Clear the image_url column
        const { error } = await supabase
          .from('story_scenes')
          .update({ image_url: null })
          .eq('id', sceneId);

        if (error) return errorResponse(error.message, 500);
        return jsonResponse({ success: true });
      }

      // Remove a specific inline marker from content
      if (!imageUrl) {
        return errorResponse('imageUrl is required for inline removal');
      }

      const { data: scene, error: fetchError } = await supabase
        .from('story_scenes')
        .select('content')
        .eq('id', sceneId)
        .maybeSingle();

      if (fetchError) return errorResponse(fetchError.message, 500);
      if (!scene) return errorResponse('Scene not found', 404);

      // Build marker patterns to remove (with or without |size=...)
      const imageMarkerRe = new RegExp(
        `\\{\\{image:${imageUrl.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}(\\|size=\\w+)?\\}\\}`,
        'g'
      );
      const videoMarkerRe = new RegExp(
        `\\{\\{video:${imageUrl.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')}(\\|size=\\w+)?\\}\\}`,
        'g'
      );
      let newContent = scene.content.replace(imageMarkerRe, '');
      newContent = newContent.replace(videoMarkerRe, '');
      // Clean up leftover triple+ newlines
      newContent = newContent.replace(/\n{3,}/g, '\n\n');

      const { error: updateError } = await supabase
        .from('story_scenes')
        .update({ content: newContent })
        .eq('id', sceneId);

      if (updateError) return errorResponse(updateError.message, 500);
      return jsonResponse({ success: true, content: newContent });
    }

    return errorResponse(`Unknown action: ${action}`);
  } catch (err) {
    return errorResponse(String(err), 500);
  }
});
