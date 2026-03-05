import { useEffect, useState, useCallback } from 'react';
import { AdminLayout } from '../../components/AdminLayout';
import { getStoryScenes } from '../../lib/api';
import { getChapters } from '../../lib/api';
import { updateSceneContent } from '../../lib/adminApi';
import type { StoryScene, Chapter } from '../../lib/database.types';
import {
  Loader2,
  Save,
  ChevronDown,
  ChevronRight,
  AlertTriangle,
  Check,
  Copy,
  BookOpen,
} from 'lucide-react';

// ─── Voice mapping reference ─────────────────────────────────────────────────

const VOICE_REFERENCE = [
  { name: 'ビットくん', voice: 'Puck' },
  { name: 'バイトさん', voice: 'Kore' },
  { name: 'ファイラ', voice: 'Aoede' },
  { name: 'ストラクト博士', voice: 'Enceladus' },
  { name: 'ループちゃん', voice: 'Leda' },
  { name: 'HTMLくん', voice: 'Sadachbia' },
  { name: 'CSSちゃん', voice: 'Umbriel' },
  { name: 'ルーター船長', voice: 'Fenrir' },
  { name: 'JSマスター', voice: 'Gacrux' },
  { name: 'リアクト先生', voice: 'Schedar' },
  { name: 'UIデザイナー・ミア', voice: 'Callirrhoe' },
  { name: 'テイル職人', voice: 'Algieba' },
  { name: 'ターミナルじいさん', voice: 'Rasalgethi' },
  { name: 'パッケージ配達員', voice: 'Achird' },
  { name: 'ギット管理人', voice: 'Iapetus' },
  { name: 'サーバー守護者', voice: 'Charon' },
  { name: 'API大使', voice: 'Vindemiatrix' },
  { name: 'コードバタフライたち', voice: 'Despina' },
  { name: 'ナレーション（デフォルト）', voice: 'Kore' },
];

// ─── Helpers ─────────────────────────────────────────────────────────────────

function countSpeakerTags(content: string): { total: number; unknown: number } {
  const matches = content.match(/\{\{speaker:[^}]+\}\}/g) || [];
  const unknown = matches.filter((m) => m.includes('???')).length;
  return { total: matches.length, unknown };
}

// ─── Scene Editor ────────────────────────────────────────────────────────────

function SceneEditor({
  scene,
  onSaved,
}: {
  scene: StoryScene;
  onSaved: (id: string, content: string) => void;
}) {
  const [content, setContent] = useState(scene.content);
  const [saving, setSaving] = useState(false);
  const [saveStatus, setSaveStatus] = useState<'idle' | 'saved' | 'error'>('idle');
  const [expanded, setExpanded] = useState(false);

  const isDirty = content !== scene.content;
  const { total, unknown } = countSpeakerTags(content);

  const handleSave = async () => {
    setSaving(true);
    setSaveStatus('idle');
    try {
      await updateSceneContent(scene.id, content);
      setSaveStatus('saved');
      onSaved(scene.id, content);
      setTimeout(() => setSaveStatus('idle'), 2000);
    } catch {
      setSaveStatus('error');
    } finally {
      setSaving(false);
    }
  };

  // Highlight content for preview
  const highlightedPreview = content
    .replace(
      /\{\{speaker:\?\?\?\}\}/g,
      '<span class="bg-red-500/30 text-red-300 px-1 rounded">{{speaker:???}}</span>'
    )
    .replace(
      /\{\{speaker:([^?}]+)\}\}/g,
      '<span class="bg-teal-500/20 text-teal-300 px-1 rounded">{{speaker:$1}}</span>'
    );

  return (
    <div className="border border-gray-800 rounded-lg overflow-hidden">
      <button
        onClick={() => setExpanded(!expanded)}
        className="w-full flex items-center justify-between px-4 py-3 bg-gray-900 hover:bg-gray-800/80 transition-colors"
      >
        <div className="flex items-center gap-3">
          {expanded ? (
            <ChevronDown size={16} className="text-gray-400" />
          ) : (
            <ChevronRight size={16} className="text-gray-400" />
          )}
          <span className="text-sm font-medium text-gray-200">
            Scene {scene.scene_number}: {scene.title || '(untitled)'}
          </span>
        </div>
        <div className="flex items-center gap-2">
          {unknown > 0 && (
            <span className="flex items-center gap-1 text-xs text-red-400">
              <AlertTriangle size={12} />
              {unknown} unknown
            </span>
          )}
          {total > 0 && unknown === 0 && (
            <span className="flex items-center gap-1 text-xs text-teal-400">
              <Check size={12} />
              {total} tagged
            </span>
          )}
          {total === 0 && <span className="text-xs text-gray-500">no tags</span>}
          {isDirty && <span className="text-xs text-amber-400 font-medium">unsaved</span>}
        </div>
      </button>

      {expanded && (
        <div className="p-4 space-y-4 bg-gray-950">
          {/* Preview */}
          <div>
            <label className="block text-xs text-gray-400 mb-1">
              Preview (speaker tags highlighted)
            </label>
            <div
              className="text-sm text-gray-300 whitespace-pre-line leading-relaxed max-h-48 overflow-y-auto bg-gray-900 rounded-lg p-3 border border-gray-800"
              dangerouslySetInnerHTML={{ __html: highlightedPreview }}
            />
          </div>

          {/* Editor */}
          <div>
            <label className="block text-xs text-gray-400 mb-1">Edit content</label>
            <textarea
              value={content}
              onChange={(e) => setContent(e.target.value)}
              rows={16}
              className="w-full bg-gray-900 border border-gray-700 rounded-lg p-3 text-sm text-gray-200 font-mono leading-relaxed focus:outline-none focus:border-teal-500 resize-y"
              spellCheck={false}
            />
          </div>

          {/* Actions */}
          <div className="flex items-center gap-3">
            <button
              onClick={handleSave}
              disabled={saving || !isDirty}
              className="flex items-center gap-2 px-4 py-2 bg-teal-600 text-white text-sm font-medium rounded-lg hover:bg-teal-500 disabled:opacity-40 disabled:cursor-not-allowed transition-colors"
            >
              {saving ? <Loader2 size={14} className="animate-spin" /> : <Save size={14} />}
              Save
            </button>
            {saveStatus === 'saved' && (
              <span className="text-xs text-emerald-400 flex items-center gap-1">
                <Check size={12} /> Saved
              </span>
            )}
            {saveStatus === 'error' && <span className="text-xs text-red-400">Failed to save</span>}
            {isDirty && (
              <button
                onClick={() => setContent(scene.content)}
                className="text-xs text-gray-400 hover:text-gray-200 transition-colors"
              >
                Reset
              </button>
            )}
          </div>
        </div>
      )}
    </div>
  );
}

// ─── Voice Reference Panel ───────────────────────────────────────────────────

function VoiceReferencePanel() {
  const [copiedVoice, setCopiedVoice] = useState<string | null>(null);

  const handleCopy = (voice: string) => {
    navigator.clipboard.writeText(`{{speaker:${voice}}}`);
    setCopiedVoice(voice);
    setTimeout(() => setCopiedVoice(null), 1500);
  };

  return (
    <div className="bg-gray-900 border border-gray-800 rounded-xl p-4">
      <h3 className="text-xs font-semibold text-gray-400 uppercase tracking-wider mb-3">
        Voice Reference
      </h3>
      <p className="text-[11px] text-gray-500 mb-3">Click to copy the speaker tag</p>
      <div className="space-y-1">
        {VOICE_REFERENCE.map(({ name, voice }) => (
          <button
            key={`${name}-${voice}`}
            onClick={() => handleCopy(voice)}
            className="w-full flex items-center justify-between px-2 py-1.5 rounded text-xs hover:bg-gray-800 transition-colors group"
          >
            <span className="text-gray-300">{name}</span>
            <span className="flex items-center gap-1">
              <code className="text-teal-400 font-mono">{voice}</code>
              {copiedVoice === voice ? (
                <Check size={10} className="text-emerald-400" />
              ) : (
                <Copy size={10} className="text-gray-600 group-hover:text-gray-400" />
              )}
            </span>
          </button>
        ))}
      </div>
    </div>
  );
}

// ─── Main Page ───────────────────────────────────────────────────────────────

export function AdminStoryEditorPage() {
  const [chapters, setChapters] = useState<Chapter[]>([]);
  const [selectedChapter, setSelectedChapter] = useState<number | null>(null);
  const [scenes, setScenes] = useState<StoryScene[]>([]);
  const [loading, setLoading] = useState(true);
  const [scenesLoading, setScenesLoading] = useState(false);

  useEffect(() => {
    getChapters()
      .then((data) => {
        setChapters(data);
        if (data.length > 0) setSelectedChapter(data[0].id);
      })
      .catch(console.error)
      .finally(() => setLoading(false));
  }, []);

  useEffect(() => {
    if (selectedChapter === null) return;
    setScenesLoading(true);
    getStoryScenes(selectedChapter)
      .then(setScenes)
      .catch(console.error)
      .finally(() => setScenesLoading(false));
  }, [selectedChapter]);

  const handleSaved = useCallback((sceneId: string, newContent: string) => {
    setScenes((prev) => prev.map((s) => (s.id === sceneId ? { ...s, content: newContent } : s)));
  }, []);

  // Summary stats
  const totalUnknown = scenes.reduce((sum, s) => sum + countSpeakerTags(s.content).unknown, 0);
  const totalTags = scenes.reduce((sum, s) => sum + countSpeakerTags(s.content).total, 0);

  if (loading) {
    return (
      <AdminLayout>
        <div className="flex items-center justify-center min-h-[60vh]">
          <Loader2 className="w-8 h-8 animate-spin text-teal-400" />
        </div>
      </AdminLayout>
    );
  }

  return (
    <AdminLayout>
      <div className="space-y-6">
        <div>
          <h1 className="text-2xl font-semibold text-white mb-1 flex items-center gap-2">
            <BookOpen size={22} />
            Story Editor
          </h1>
          <p className="text-sm text-gray-400">Review and edit speaker tags in story content</p>
        </div>

        <div className="flex flex-col lg:flex-row gap-6">
          {/* Main content */}
          <div className="flex-1 space-y-4">
            {/* Chapter selector */}
            <div className="flex items-center gap-4">
              <select
                value={selectedChapter ?? ''}
                onChange={(e) => setSelectedChapter(Number(e.target.value))}
                className="bg-gray-900 border border-gray-700 rounded-lg px-4 py-2 text-sm text-gray-200 focus:outline-none focus:border-teal-500"
              >
                {chapters.map((ch) => (
                  <option key={ch.id} value={ch.id}>
                    Ch{ch.id}: {ch.title}
                  </option>
                ))}
              </select>

              {/* Stats */}
              {!scenesLoading && scenes.length > 0 && (
                <div className="flex items-center gap-4 text-xs">
                  <span className="text-gray-400">{scenes.length} scenes</span>
                  <span className="text-teal-400">{totalTags} tags</span>
                  {totalUnknown > 0 && (
                    <span className="text-red-400 flex items-center gap-1">
                      <AlertTriangle size={12} />
                      {totalUnknown} unknown
                    </span>
                  )}
                </div>
              )}
            </div>

            {/* Scenes */}
            {scenesLoading ? (
              <div className="flex items-center justify-center py-12">
                <Loader2 className="w-6 h-6 animate-spin text-teal-400" />
              </div>
            ) : scenes.length === 0 ? (
              <p className="text-sm text-gray-400 py-8 text-center">
                No scenes found for this chapter
              </p>
            ) : (
              <div className="space-y-2">
                {scenes.map((scene) => (
                  <SceneEditor key={scene.id} scene={scene} onSaved={handleSaved} />
                ))}
              </div>
            )}
          </div>

          {/* Sidebar */}
          <div className="lg:w-64 flex-shrink-0">
            <div className="lg:sticky lg:top-8 space-y-4">
              <VoiceReferencePanel />

              <div className="bg-gray-900 border border-gray-800 rounded-xl p-4">
                <h3 className="text-xs font-semibold text-gray-400 uppercase tracking-wider mb-2">
                  Tag Format
                </h3>
                <code className="text-xs text-teal-400 font-mono block mb-2">
                  {'{{speaker:VoiceName}}'}
                </code>
                <p className="text-[11px] text-gray-500 leading-relaxed">
                  Place before a dialogue line (「」). Plain text without tags defaults to{' '}
                  <strong className="text-gray-400">Kore</strong> (narrator).
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </AdminLayout>
  );
}
