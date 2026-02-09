import { Chapter } from '../lib/database.types';
import {
  BookOpen,
  Cpu,
  FileCode,
  Database,
  Globe,
  Code2,
  Palette,
  Terminal,
  Package,
  GitBranch,
  Server,
  Plug,
  Sparkles,
  Lock,
} from 'lucide-react';

interface ChapterCardProps {
  chapter: Chapter;
  onClick: () => void;
  isSpecial?: boolean;
  isLocked?: boolean;
  progress?: number;
}

const categoryIcons: Record<string, typeof BookOpen> = {
  cpu: Cpu,
  file: FileCode,
  database: Database,
  globe: Globe,
  code: Code2,
  palette: Palette,
  terminal: Terminal,
  package: Package,
  git: GitBranch,
  server: Server,
  plug: Plug,
  book: BookOpen,
  sparkles: Sparkles,
};

const categoryIconColors: Record<string, string> = {
  basics: 'text-sky-500',
  fileTypes: 'text-amber-500',
  dataTypes: 'text-emerald-500',
  programming: 'text-rose-500',
  htmlCss: 'text-orange-500',
  networking: 'text-blue-500',
  javascript: 'text-yellow-600',
  react: 'text-cyan-500',
  uiComponents: 'text-pink-500',
  uiux: 'text-fuchsia-500',
  cssFrameworks: 'text-teal-500',
  devTools: 'text-slate-600',
  packageManagement: 'text-green-600',
  git: 'text-orange-600',
  backend: 'text-lime-600',
  api: 'text-blue-500',
  epilogue: 'text-amber-600',
};

export function ChapterCard({
  chapter,
  onClick,
  isSpecial,
  isLocked,
  progress = 0,
}: ChapterCardProps) {
  const Icon = categoryIcons[chapter.category_icon] || BookOpen;
  const iconColor = categoryIconColors[chapter.category] || 'text-slate-500';

  return (
    <button
      onClick={onClick}
      disabled={isLocked}
      aria-disabled={isLocked || undefined}
      className={`
        relative w-full text-left rounded-2xl p-5 transition-all duration-300
        ${
          isSpecial
            ? 'overflow-hidden bg-amber-50 border border-amber-200/60'
            : 'bg-gradient-to-br from-slate-50 via-blue-50/50 to-slate-100 border border-slate-200/60'
        }
        ${isLocked ? 'opacity-60 cursor-not-allowed' : 'hover:-translate-y-1.5 cursor-pointer'}
        ${isSpecial ? 'ring-1 ring-amber-300/50 hover:ring-amber-400/60' : 'hover:border-slate-300/80'}
      `}
      style={{
        boxShadow: isSpecial
          ? '0 4px 12px rgba(251,191,36,0.15), 0 1px 3px rgba(0,0,0,0.06), inset 0 1px 0 rgba(255,255,255,0.6)'
          : '0 4px 12px rgba(100,116,139,0.12), 0 1px 3px rgba(0,0,0,0.06), inset 0 1px 0 rgba(255,255,255,0.7)',
        ...(isSpecial
          ? {
              backgroundImage: 'url(/memorygarden.png)',
              backgroundSize: 'cover',
              backgroundPosition: 'center',
            }
          : {}),
      }}
      onMouseEnter={(e) => {
        if (!isLocked) {
          e.currentTarget.style.boxShadow = isSpecial
            ? '0 12px 28px rgba(251,191,36,0.25), 0 4px 10px rgba(0,0,0,0.08), inset 0 1px 0 rgba(255,255,255,0.6)'
            : '0 12px 28px rgba(100,116,139,0.2), 0 4px 10px rgba(0,0,0,0.08), inset 0 1px 0 rgba(255,255,255,0.7)';
        }
      }}
      onMouseLeave={(e) => {
        e.currentTarget.style.boxShadow = isSpecial
          ? '0 4px 12px rgba(251,191,36,0.15), 0 1px 3px rgba(0,0,0,0.06), inset 0 1px 0 rgba(255,255,255,0.6)'
          : '0 4px 12px rgba(100,116,139,0.12), 0 1px 3px rgba(0,0,0,0.06), inset 0 1px 0 rgba(255,255,255,0.7)';
      }}
    >
      {isSpecial && (
        <div className="absolute inset-0 bg-white/40 pointer-events-none" />
      )}
      <div
        className="absolute inset-0 rounded-2xl opacity-30 pointer-events-none"
        style={{
          background: isSpecial
            ? 'linear-gradient(45deg, transparent 40%, rgba(251,191,36,0.15) 50%, transparent 60%)'
            : 'linear-gradient(45deg, transparent 40%, rgba(148,163,184,0.2) 50%, transparent 60%)',
        }}
      />

      {isLocked && (
        <div className="absolute top-3 right-3">
          <Lock size={18} className="text-gray-500" />
        </div>
      )}

      <div className="relative flex items-start gap-3 mb-3">
        <div
          className={`p-2 rounded-xl ${isSpecial ? 'bg-white/80' : 'bg-white/70'} backdrop-blur-sm ${iconColor}`}
        >
          <Icon size={24} />
        </div>
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2">
            <span
              className={`text-xs font-medium ${isSpecial ? 'text-amber-700' : 'text-slate-500'}`}
            >
              {chapter.id === 17 ? 'Epilogue' : `Chapter ${chapter.id}`}
            </span>
            <span className={`text-xs ${isSpecial ? 'text-amber-500' : 'text-slate-500'}`}>
              {chapter.term_count} terms
            </span>
          </div>
          <h3
            className={`font-semibold truncate mt-0.5 ${isSpecial ? 'text-amber-900' : 'text-slate-800'}`}
          >
            {chapter.title}
          </h3>
        </div>
      </div>

      {chapter.subtitle && (
        <p
          className={`relative text-sm mb-3 line-clamp-2 ${isSpecial ? 'text-amber-700' : 'text-slate-600'}`}
        >
          {chapter.subtitle}
        </p>
      )}

      <div className="relative flex items-center gap-2">
        <div
          className={`flex-1 h-1.5 rounded-full overflow-hidden ${isSpecial ? 'bg-amber-200/50' : 'bg-slate-200/60'}`}
        >
          <div
            className={`h-full rounded-full transition-all duration-500 ${isSpecial ? 'bg-gradient-to-r from-amber-400 to-yellow-500' : 'bg-gradient-to-r from-blue-400 to-teal-400'}`}
            style={{ width: `${progress}%` }}
          />
        </div>
        <span className={`text-xs font-medium ${isSpecial ? 'text-amber-600' : 'text-slate-500'}`}>
          {progress}%
        </span>
      </div>

      <div className="relative mt-3 flex items-center gap-2">
        <span
          className={`
          text-xs px-2.5 py-0.5 rounded-full backdrop-blur-sm
          ${
            isSpecial
              ? 'bg-gradient-to-r from-amber-100/80 to-yellow-100/80 text-amber-700 border border-amber-200/50'
              : 'bg-gradient-to-r from-slate-100/80 to-blue-50/80 text-slate-600 border border-slate-200/50'
          }
        `}
        >
          {chapter.category_name}
        </span>
      </div>
    </button>
  );
}
