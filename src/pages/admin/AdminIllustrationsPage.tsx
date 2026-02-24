import { useEffect, useState, useCallback, useRef, type DragEvent, type ChangeEvent } from 'react';
import { AdminLayout } from '../../components/AdminLayout';
import {
  getIllustrationScenes,
  uploadIllustration,
  setSceneImageUrl,
  insertInlineImage,
  removeInlineImage,
  type IllustrationScene,
} from '../../lib/adminApi';
import {
  Loader2,
  ImagePlus,
  Trash2,
  X,
  Plus,
  Upload,
  Check,
  AlertCircle,
  ChevronDown,
} from 'lucide-react';

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------

interface UploadState {
  uploading: boolean;
  progress: string;
  error: string | null;
}

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

/** Generate a storage filename for an illustration. */
function makeFilename(scene: IllustrationScene, suffix = ''): string {
  const ts = Date.now();
  return `illustrations/ch${scene.chapter_id}_s${scene.scene_number}${suffix}_${ts}.png`;
}

/** Split content into paragraphs (non-media text blocks only) for display. */
function contentToParagraphs(content: string): string[] {
  return content.split(/\n\n/).filter((p) => p.trim().length > 0);
}

/** Check if a paragraph is a media marker. */
function isMediaMarker(paragraph: string): boolean {
  return /^\{\{(image|video):[^}]+\}\}$/.test(paragraph.trim());
}

/** Extract URL from a media marker paragraph. */
function extractMarkerUrl(paragraph: string): string | null {
  const m = paragraph.trim().match(/^\{\{(?:image|video):([^}]+)\}\}$/);
  return m ? m[1] : null;
}

// ---------------------------------------------------------------------------
// Background removal (lazy loaded)
// ---------------------------------------------------------------------------

let bgRemovalModule: typeof import('@imgly/background-removal') | null = null;

async function removeBackground(blob: Blob): Promise<Blob> {
  if (!bgRemovalModule) {
    bgRemovalModule = await import(/* @vite-ignore */ '@imgly/background-removal');
  }
  return bgRemovalModule.removeBackground(blob);
}

// ---------------------------------------------------------------------------
// Sub-components
// ---------------------------------------------------------------------------

function ProgressBar({ filled, total }: { filled: number; total: number }) {
  const pct = total === 0 ? 0 : Math.round((filled / total) * 100);
  return (
    <div className="flex items-center gap-3">
      <div className="flex-1 h-2 bg-gray-800 rounded-full overflow-hidden">
        <div
          className="h-full bg-teal-500 rounded-full transition-all"
          style={{ width: `${pct}%` }}
        />
      </div>
      <span className="text-xs text-gray-400 whitespace-nowrap">
        {filled}/{total} scenes ({pct}%)
      </span>
    </div>
  );
}

function SceneCard({ scene, onClick }: { scene: IllustrationScene; onClick: () => void }) {
  const hasImage = !!scene.image_url || scene.inline_image_count > 0;
  const imageCount = (scene.image_url ? 1 : 0) + scene.inline_image_count;

  return (
    <button
      onClick={onClick}
      className={`text-left bg-gray-900 border rounded-xl overflow-hidden transition-all hover:border-teal-500/40 ${
        hasImage ? 'border-teal-500/20' : 'border-gray-800'
      }`}
    >
      {/* Thumbnail */}
      <div className="aspect-video bg-gray-800 flex items-center justify-center overflow-hidden">
        {scene.image_url ? (
          <img
            src={scene.image_url}
            alt={scene.title ?? `Scene ${scene.scene_number}`}
            className="w-full h-full object-cover"
          />
        ) : (
          <ImagePlus size={24} className="text-gray-600" />
        )}
      </div>

      {/* Info */}
      <div className="p-3 space-y-1">
        <div className="flex items-center justify-between">
          <span className="text-xs text-gray-500">
            Ch{scene.chapter_id} / S{scene.scene_number}
          </span>
          {imageCount > 0 && (
            <span className="text-[10px] px-1.5 py-0.5 bg-teal-500/10 text-teal-400 rounded-full font-medium">
              {imageCount} img
            </span>
          )}
        </div>
        <p className="text-sm text-gray-200 font-medium truncate">
          {scene.title || `Scene ${scene.scene_number}`}
        </p>
      </div>
    </button>
  );
}

// ---------------------------------------------------------------------------
// Detail Modal
// ---------------------------------------------------------------------------

function SceneDetailModal({
  scene,
  onClose,
  onUpdated,
}: {
  scene: IllustrationScene;
  onClose: () => void;
  onUpdated: (updated: IllustrationScene) => void;
}) {
  const [removeBg, setRemoveBg] = useState(true);
  const [uploadState, setUploadState] = useState<UploadState>({
    uploading: false,
    progress: '',
    error: null,
  });
  const [dragOver, setDragOver] = useState(false);
  const fileInputRef = useRef<HTMLInputElement>(null);
  const inlineFileInputRef = useRef<HTMLInputElement>(null);
  const [inlineParagraphIdx, setInlineParagraphIdx] = useState<number | null>(null);
  const [inlineSize, setInlineSize] = useState<'sm' | 'md' | 'lg' | 'full'>('md');

  const paragraphs = contentToParagraphs(scene.content);

  // ---- Image processing pipeline ----
  const processAndUpload = useCallback(
    async (file: File, target: 'header' | 'inline', paragraphIndex?: number) => {
      setUploadState({ uploading: true, progress: 'Reading file…', error: null });

      try {
        let blob: Blob = file;

        if (removeBg) {
          setUploadState((s) => ({
            ...s,
            progress: 'Removing background… (first load may take ~30s)',
          }));
          blob = await removeBackground(blob);
        }

        setUploadState((s) => ({ ...s, progress: 'Uploading…' }));

        // Convert blob to base64
        const arrayBuf = await blob.arrayBuffer();
        const bytes = new Uint8Array(arrayBuf);
        let binary = '';
        for (let i = 0; i < bytes.length; i++) {
          binary += String.fromCharCode(bytes[i]);
        }
        const base64 = btoa(binary);

        const suffix = target === 'header' ? '_header' : `_inline${paragraphIndex ?? 0}`;
        const filename = makeFilename(scene, suffix);

        const { publicUrl } = await uploadIllustration(base64, filename);

        if (target === 'header') {
          await setSceneImageUrl(scene.id, publicUrl);
          onUpdated({ ...scene, image_url: publicUrl });
        } else if (paragraphIndex !== undefined) {
          const { content } = await insertInlineImage(
            scene.id,
            publicUrl,
            paragraphIndex,
            inlineSize
          );
          onUpdated({
            ...scene,
            content,
            inline_image_count: scene.inline_image_count + 1,
            inline_image_urls: [...scene.inline_image_urls, publicUrl],
          });
        }

        setUploadState({ uploading: false, progress: '', error: null });
      } catch (err) {
        setUploadState({
          uploading: false,
          progress: '',
          error: err instanceof Error ? err.message : String(err),
        });
      }
    },
    [removeBg, scene, onUpdated]
  );

  // ---- Drag & Drop for header image ----
  const handleDragOver = useCallback((e: DragEvent) => {
    e.preventDefault();
    setDragOver(true);
  }, []);

  const handleDragLeave = useCallback(() => setDragOver(false), []);

  const handleDrop = useCallback(
    (e: DragEvent) => {
      e.preventDefault();
      setDragOver(false);
      const file = e.dataTransfer.files?.[0];
      if (file && file.type.startsWith('image/')) {
        processAndUpload(file, 'header');
      }
    },
    [processAndUpload]
  );

  const handleFileChange = useCallback(
    (e: ChangeEvent<HTMLInputElement>) => {
      const file = e.target.files?.[0];
      if (file) processAndUpload(file, 'header');
      e.target.value = '';
    },
    [processAndUpload]
  );

  const handleInlineFileChange = useCallback(
    (e: ChangeEvent<HTMLInputElement>) => {
      const file = e.target.files?.[0];
      if (file && inlineParagraphIdx !== null) {
        processAndUpload(file, 'inline', inlineParagraphIdx);
      }
      e.target.value = '';
      setInlineParagraphIdx(null);
    },
    [processAndUpload, inlineParagraphIdx]
  );

  // ---- Remove header image ----
  const handleRemoveHeader = useCallback(async () => {
    try {
      await setSceneImageUrl(scene.id, null);
      onUpdated({ ...scene, image_url: null });
    } catch (err) {
      console.error('Failed to remove header image:', err);
    }
  }, [scene, onUpdated]);

  // ---- Remove inline image ----
  const handleRemoveInline = useCallback(
    async (imageUrl: string) => {
      try {
        const { content } = await removeInlineImage(scene.id, imageUrl);
        onUpdated({
          ...scene,
          content,
          inline_image_count: Math.max(0, scene.inline_image_count - 1),
          inline_image_urls: scene.inline_image_urls.filter((u) => u !== imageUrl),
        });
      } catch (err) {
        console.error('Failed to remove inline image:', err);
      }
    },
    [scene, onUpdated]
  );

  // ---- Click "+" to insert inline ----
  const handleInsertInlineClick = useCallback((paragraphIndex: number) => {
    setInlineParagraphIdx(paragraphIndex);
    inlineFileInputRef.current?.click();
  }, []);

  return (
    <div className="fixed inset-0 z-50 flex items-start justify-center overflow-y-auto bg-black/70 p-4 md:p-8">
      <div className="relative w-full max-w-3xl bg-gray-900 border border-gray-800 rounded-2xl shadow-2xl my-8">
        {/* Header */}
        <div className="flex items-center justify-between p-6 border-b border-gray-800">
          <div>
            <h2 className="text-lg font-semibold text-white">
              Ch{scene.chapter_id} / Scene {scene.scene_number}
            </h2>
            <p className="text-sm text-gray-400">{scene.title}</p>
          </div>
          <button
            onClick={onClose}
            className="p-2 text-gray-400 hover:text-gray-200 transition-colors"
            aria-label="Close"
          >
            <X size={20} />
          </button>
        </div>

        <div className="p-6 space-y-6 max-h-[75vh] overflow-y-auto">
          {/* Upload status */}
          {uploadState.uploading && (
            <div className="flex items-center gap-3 p-4 bg-teal-500/5 border border-teal-500/20 rounded-xl">
              <Loader2 size={18} className="animate-spin text-teal-400" />
              <span className="text-sm text-teal-300">{uploadState.progress}</span>
            </div>
          )}
          {uploadState.error && (
            <div className="flex items-center gap-3 p-4 bg-red-500/5 border border-red-500/20 rounded-xl">
              <AlertCircle size={18} className="text-red-400" />
              <span className="text-sm text-red-300">{uploadState.error}</span>
            </div>
          )}

          {/* Background removal toggle */}
          <label className="flex items-center gap-3 cursor-pointer">
            <div
              onClick={() => setRemoveBg((v) => !v)}
              className={`relative w-10 h-5 rounded-full transition-colors ${
                removeBg ? 'bg-teal-500' : 'bg-gray-700'
              }`}
            >
              <div
                className={`absolute top-0.5 left-0.5 w-4 h-4 rounded-full bg-white transition-transform ${
                  removeBg ? 'translate-x-5' : ''
                }`}
              />
            </div>
            <span className="text-sm text-gray-300">Remove background on upload</span>
          </label>

          {/* Header image section */}
          <div className="space-y-2">
            <h3 className="text-sm font-semibold text-gray-300">Header Image</h3>
            {scene.image_url ? (
              <div className="relative group rounded-xl overflow-hidden border border-gray-800">
                <img
                  src={scene.image_url}
                  alt="Header"
                  className="w-full max-h-64 object-contain bg-gray-950"
                />
                <div className="absolute top-2 right-2 flex gap-2 opacity-0 group-hover:opacity-100 transition-opacity">
                  <button
                    onClick={() => fileInputRef.current?.click()}
                    className="p-2 bg-gray-900/90 rounded-lg text-gray-300 hover:text-white transition-colors"
                    title="Replace"
                    disabled={uploadState.uploading}
                  >
                    <Upload size={16} />
                  </button>
                  <button
                    onClick={handleRemoveHeader}
                    className="p-2 bg-gray-900/90 rounded-lg text-red-400 hover:text-red-300 transition-colors"
                    title="Remove"
                    disabled={uploadState.uploading}
                  >
                    <Trash2 size={16} />
                  </button>
                </div>
              </div>
            ) : (
              <div
                onDragOver={handleDragOver}
                onDragLeave={handleDragLeave}
                onDrop={handleDrop}
                onClick={() => !uploadState.uploading && fileInputRef.current?.click()}
                className={`border-2 border-dashed rounded-xl p-8 flex flex-col items-center gap-3 cursor-pointer transition-all ${
                  dragOver
                    ? 'border-teal-500 bg-teal-500/5'
                    : 'border-gray-700 hover:border-gray-600'
                }`}
              >
                <Upload size={28} className="text-gray-500" />
                <p className="text-sm text-gray-400">
                  Drop an image here or <span className="text-teal-400 underline">browse</span>
                </p>
              </div>
            )}
            <input
              ref={fileInputRef}
              type="file"
              accept="image/*"
              className="hidden"
              onChange={handleFileChange}
            />
          </div>

          {/* Content & inline images */}
          <div className="space-y-2">
            <h3 className="text-sm font-semibold text-gray-300">Content & Inline Images</h3>
            <div className="space-y-1">
              {paragraphs.map((p, idx) => {
                const markerUrl = extractMarkerUrl(p);
                if (markerUrl) {
                  return (
                    <div
                      key={idx}
                      className="relative group rounded-lg overflow-hidden border border-gray-800 my-2"
                    >
                      <img
                        src={markerUrl}
                        alt={`Inline ${idx}`}
                        className="w-full max-h-48 object-contain bg-gray-950"
                      />
                      <button
                        onClick={() => handleRemoveInline(markerUrl)}
                        className="absolute top-2 right-2 p-1.5 bg-gray-900/90 rounded-lg text-red-400 hover:text-red-300 opacity-0 group-hover:opacity-100 transition-opacity"
                        title="Remove inline image"
                        disabled={uploadState.uploading}
                      >
                        <Trash2 size={14} />
                      </button>
                    </div>
                  );
                }

                return (
                  <div key={idx}>
                    {isMediaMarker(p) ? null : (
                      <p className="text-sm text-gray-400 leading-relaxed py-1 whitespace-pre-wrap">
                        {p.length > 200 ? p.slice(0, 200) + '…' : p}
                      </p>
                    )}
                    {/* "+" button to insert inline image after this paragraph */}
                    <div className="flex justify-center items-center gap-2 py-0.5">
                      <button
                        onClick={() => handleInsertInlineClick(idx)}
                        className="flex items-center gap-1 px-2 py-0.5 text-[10px] text-gray-600 hover:text-teal-400 hover:bg-teal-500/5 rounded-full transition-all"
                        title="Insert image after this paragraph"
                        disabled={uploadState.uploading}
                      >
                        <Plus size={12} />
                        <span>image</span>
                      </button>
                      <select
                        value={inlineSize}
                        onChange={(e) =>
                          setInlineSize(e.target.value as 'sm' | 'md' | 'lg' | 'full')
                        }
                        className="text-[10px] bg-gray-800 border border-gray-700 text-gray-400 rounded px-1 py-0.5 focus:outline-none focus:border-teal-500"
                        title="Image size"
                      >
                        <option value="sm">sm (35%)</option>
                        <option value="md">md (50%)</option>
                        <option value="lg">lg (75%)</option>
                        <option value="full">full (100%)</option>
                      </select>
                    </div>
                  </div>
                );
              })}
            </div>
            <input
              ref={inlineFileInputRef}
              type="file"
              accept="image/*"
              className="hidden"
              onChange={handleInlineFileChange}
            />
          </div>
        </div>

        {/* Footer */}
        <div className="p-4 border-t border-gray-800 flex justify-end">
          <button
            onClick={onClose}
            className="px-4 py-2 text-sm text-gray-400 hover:text-gray-200 transition-colors"
          >
            Close
          </button>
        </div>
      </div>
    </div>
  );
}

// ---------------------------------------------------------------------------
// Main page
// ---------------------------------------------------------------------------

export function AdminIllustrationsPage() {
  const [scenes, setScenes] = useState<IllustrationScene[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [chapterFilter, setChapterFilter] = useState<number | undefined>(undefined);
  const [selectedScene, setSelectedScene] = useState<IllustrationScene | null>(null);

  // Derive unique chapter IDs
  const chapterIds = [...new Set(scenes.map((s) => s.chapter_id))].sort((a, b) => a - b);

  // Filtered scenes
  const filtered = chapterFilter ? scenes.filter((s) => s.chapter_id === chapterFilter) : scenes;

  // Progress stats
  const scenesWithImages = scenes.filter((s) => s.image_url || s.inline_image_count > 0).length;

  // Load data
  const loadScenes = useCallback(async () => {
    setLoading(true);
    setError(null);
    try {
      const data = await getIllustrationScenes();
      setScenes(data);
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err));
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    loadScenes();
  }, [loadScenes]);

  // When detail modal updates a scene, reflect in list
  const handleSceneUpdated = useCallback((updated: IllustrationScene) => {
    setScenes((prev) => prev.map((s) => (s.id === updated.id ? updated : s)));
    setSelectedScene(updated);
  }, []);

  // Group by chapter
  const groupedByChapter = filtered.reduce<Record<number, IllustrationScene[]>>((acc, s) => {
    (acc[s.chapter_id] ||= []).push(s);
    return acc;
  }, {});

  if (loading) {
    return (
      <AdminLayout>
        <div className="flex items-center justify-center min-h-[60vh]">
          <Loader2 className="w-8 h-8 animate-spin text-teal-400" />
        </div>
      </AdminLayout>
    );
  }

  if (error) {
    return (
      <AdminLayout>
        <div className="flex flex-col items-center justify-center min-h-[60vh] gap-4">
          <AlertCircle size={32} className="text-red-400" />
          <p className="text-sm text-red-300">{error}</p>
          <button
            onClick={loadScenes}
            className="px-4 py-2 text-sm bg-gray-800 text-gray-200 rounded-lg hover:bg-gray-700 transition-colors"
          >
            Retry
          </button>
        </div>
      </AdminLayout>
    );
  }

  return (
    <AdminLayout>
      <div className="space-y-6">
        {/* Header */}
        <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
          <div>
            <h1 className="text-2xl font-semibold text-white mb-1">Illustrations</h1>
            <p className="text-sm text-gray-400">Manage story scene illustrations</p>
          </div>

          {/* Chapter filter */}
          <div className="relative">
            <select
              value={chapterFilter ?? ''}
              onChange={(e) =>
                setChapterFilter(e.target.value ? Number(e.target.value) : undefined)
              }
              className="appearance-none bg-gray-800 border border-gray-700 text-sm text-gray-200 rounded-lg pl-4 pr-10 py-2 focus:outline-none focus:border-teal-500 transition-colors"
            >
              <option value="">All Chapters</option>
              {chapterIds.map((id) => (
                <option key={id} value={id}>
                  Chapter {id}
                </option>
              ))}
            </select>
            <ChevronDown
              size={16}
              className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-500 pointer-events-none"
            />
          </div>
        </div>

        {/* Progress bar */}
        <ProgressBar filled={scenesWithImages} total={scenes.length} />

        {/* Scene grid, grouped by chapter */}
        {Object.keys(groupedByChapter).length === 0 ? (
          <div className="flex flex-col items-center justify-center py-20 text-gray-500 gap-2">
            <Check size={32} />
            <p className="text-sm">No scenes found</p>
          </div>
        ) : (
          Object.entries(groupedByChapter)
            .sort(([a], [b]) => Number(a) - Number(b))
            .map(([chId, chScenes]) => (
              <div key={chId} className="space-y-3">
                <h2 className="text-sm font-semibold text-gray-400 uppercase tracking-wider">
                  Chapter {chId}
                </h2>
                <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 xl:grid-cols-5 gap-3">
                  {chScenes.map((s) => (
                    <SceneCard key={s.id} scene={s} onClick={() => setSelectedScene(s)} />
                  ))}
                </div>
              </div>
            ))
        )}
      </div>

      {/* Detail modal */}
      {selectedScene && (
        <SceneDetailModal
          scene={selectedScene}
          onClose={() => setSelectedScene(null)}
          onUpdated={handleSceneUpdated}
        />
      )}
    </AdminLayout>
  );
}
