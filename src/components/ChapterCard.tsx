import { Chapter } from '../lib/database.types';
import { BookOpen, Cpu, FileCode, Database, Globe, Code2, Palette, Terminal, Package, GitBranch, Server, Plug, Sparkles, Lock } from 'lucide-react';

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

const categoryColors: Record<string, { bg: string; border: string; icon: string }> = {
  basics: { bg: 'from-sky-50 to-sky-100', border: 'border-sky-200', icon: 'text-sky-500' },
  fileTypes: { bg: 'from-amber-50 to-amber-100', border: 'border-amber-200', icon: 'text-amber-500' },
  dataTypes: { bg: 'from-emerald-50 to-emerald-100', border: 'border-emerald-200', icon: 'text-emerald-500' },
  programming: { bg: 'from-rose-50 to-rose-100', border: 'border-rose-200', icon: 'text-rose-500' },
  htmlCss: { bg: 'from-orange-50 to-orange-100', border: 'border-orange-200', icon: 'text-orange-500' },
  networking: { bg: 'from-blue-50 to-blue-100', border: 'border-blue-200', icon: 'text-blue-500' },
  javascript: { bg: 'from-yellow-50 to-yellow-100', border: 'border-yellow-300', icon: 'text-yellow-600' },
  react: { bg: 'from-cyan-50 to-cyan-100', border: 'border-cyan-200', icon: 'text-cyan-500' },
  uiComponents: { bg: 'from-pink-50 to-pink-100', border: 'border-pink-200', icon: 'text-pink-500' },
  uiux: { bg: 'from-fuchsia-50 to-fuchsia-100', border: 'border-fuchsia-200', icon: 'text-fuchsia-500' },
  cssFrameworks: { bg: 'from-teal-50 to-teal-100', border: 'border-teal-200', icon: 'text-teal-500' },
  devTools: { bg: 'from-slate-100 to-slate-200', border: 'border-slate-300', icon: 'text-slate-600' },
  packageManagement: { bg: 'from-green-50 to-green-100', border: 'border-green-200', icon: 'text-green-600' },
  git: { bg: 'from-orange-50 to-orange-100', border: 'border-orange-200', icon: 'text-orange-600' },
  backend: { bg: 'from-lime-50 to-lime-100', border: 'border-lime-200', icon: 'text-lime-600' },
  api: { bg: 'from-violet-50 to-violet-100', border: 'border-violet-200', icon: 'text-violet-500' },
  epilogue: { bg: 'from-amber-100 to-yellow-100', border: 'border-amber-300', icon: 'text-amber-600' },
};

export function ChapterCard({ chapter, onClick, isSpecial, isLocked, progress = 0 }: ChapterCardProps) {
  const Icon = categoryIcons[chapter.category_icon] || BookOpen;
  const colors = categoryColors[chapter.category] || categoryColors.basics;

  return (
    <button
      onClick={onClick}
      disabled={isLocked}
      className={`
        relative w-full text-left rounded-2xl p-5 transition-all duration-300
        bg-gradient-to-br ${colors.bg} border ${colors.border}
        ${isLocked
          ? 'opacity-60 cursor-not-allowed'
          : 'hover:shadow-lg hover:-translate-y-1 cursor-pointer'
        }
        ${isSpecial ? 'ring-2 ring-amber-300 ring-offset-2' : ''}
      `}
    >
      {isLocked && (
        <div className="absolute top-3 right-3">
          <Lock size={18} className="text-gray-400" />
        </div>
      )}

      <div className="flex items-start gap-3 mb-3">
        <div className={`p-2 rounded-xl bg-white/60 ${colors.icon}`}>
          <Icon size={24} />
        </div>
        <div className="flex-1 min-w-0">
          <div className="flex items-center gap-2">
            <span className="text-xs font-medium text-gray-500">
              {chapter.id === 17 ? 'Epilogue' : `Chapter ${chapter.id}`}
            </span>
            <span className="text-xs text-gray-400">
              {chapter.term_count} terms
            </span>
          </div>
          <h3 className="font-semibold text-gray-800 truncate mt-0.5">
            {chapter.title}
          </h3>
        </div>
      </div>

      {chapter.subtitle && (
        <p className="text-sm text-gray-600 mb-3 line-clamp-2">
          {chapter.subtitle}
        </p>
      )}

      <div className="flex items-center gap-2">
        <div className="flex-1 h-1.5 bg-white/50 rounded-full overflow-hidden">
          <div
            className="h-full bg-gradient-to-r from-teal-400 to-teal-500 rounded-full transition-all duration-500"
            style={{ width: `${progress}%` }}
          />
        </div>
        <span className="text-xs text-gray-500 font-medium">
          {progress}%
        </span>
      </div>

      <div className="mt-3 flex items-center gap-2">
        <span className={`text-xs px-2 py-0.5 rounded-full bg-white/60 ${colors.icon}`}>
          {chapter.category_name}
        </span>
      </div>
    </button>
  );
}
