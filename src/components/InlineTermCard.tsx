import { useState } from 'react';
import { BookOpen, Lightbulb, AlertTriangle, Cog, X, Check, Loader2, Sparkles } from 'lucide-react';
import type { Term } from '../lib/database.types';

interface InlineTermCardProps {
  term: Term;
  isCollected?: boolean;
  saving?: boolean;
  onClose: () => void;
  onGotIt?: () => void;
}

export function InlineTermCard({ term, isCollected, saving, onClose, onGotIt }: InlineTermCardProps) {
  const [activeTab, setActiveTab] = useState<'definition' | 'mechanism' | 'analogy' | 'pitfall'>('definition');

  const tabs = [
    { key: 'definition' as const, label: 'Definition', icon: BookOpen, content: term.definition, color: 'teal' },
    ...(term.mechanism ? [{ key: 'mechanism' as const, label: 'How', icon: Cog, content: term.mechanism, color: 'gray' }] : []),
    ...(term.analogy ? [{ key: 'analogy' as const, label: 'Analogy', icon: Lightbulb, content: term.analogy, color: 'amber' }] : []),
    ...(term.pitfall ? [{ key: 'pitfall' as const, label: 'Pitfall', icon: AlertTriangle, content: term.pitfall, color: 'rose' }] : []),
  ];

  const currentTab = tabs.find(t => t.key === activeTab) || tabs[0];

  return (
    <div className="inline-term-card mt-3 mb-2 rounded-xl bg-white/95 backdrop-blur-md border border-emerald-200/60 shadow-lg shadow-emerald-100/40 overflow-hidden">
      <div className="flex items-center justify-between px-4 py-3 bg-gradient-to-r from-emerald-50 to-teal-50 border-b border-emerald-100/50">
        <div className="flex items-center gap-3 min-w-0">
          <div className="flex items-center gap-1.5">
            <span className="text-[10px] text-emerald-500 font-medium">#{term.order_index}</span>
            <div className="flex gap-0.5">
              {Array(3).fill(0).map((_, i) => (
                <span key={i} className={`text-[10px] ${i < term.difficulty ? 'text-amber-400' : 'text-gray-200'}`}>
                  *
                </span>
              ))}
            </div>
          </div>
          <div className="min-w-0">
            <h4 className="text-sm font-bold text-gray-800 truncate">{term.term}</h4>
            <p className="text-[11px] text-gray-500 truncate">{term.term_ja}</p>
          </div>
        </div>
        <button
          onClick={(e) => { e.stopPropagation(); onClose(); }}
          className="p-1 rounded-full text-gray-400 hover:text-gray-600 hover:bg-gray-100 transition-colors shrink-0"
        >
          <X size={14} />
        </button>
      </div>

      <div className="px-4 py-2.5">
        <p className="text-xs font-medium text-emerald-700 leading-relaxed">{term.one_liner}</p>
      </div>

      {tabs.length > 1 && (
        <div className="flex gap-1 px-3 pb-2">
          {tabs.map((tab) => {
            const Icon = tab.icon;
            const isActive = tab.key === currentTab.key;
            return (
              <button
                key={tab.key}
                onClick={(e) => { e.stopPropagation(); setActiveTab(tab.key); }}
                className={`flex items-center gap-1 px-2 py-1 rounded-md text-[10px] font-medium transition-all ${
                  isActive
                    ? 'bg-emerald-100 text-emerald-700'
                    : 'text-gray-400 hover:text-gray-600 hover:bg-gray-50'
                }`}
              >
                <Icon size={10} />
                {tab.label}
              </button>
            );
          })}
        </div>
      )}

      <div className="px-4 pb-3">
        <p className="text-xs text-gray-600 leading-relaxed">{currentTab.content}</p>
      </div>

      {onGotIt && (
        <div className="px-4 pb-4 pt-1 border-t border-emerald-100/50">
          {isCollected ? (
            <div className="flex items-center justify-center gap-1.5 py-1.5 text-emerald-600">
              <Sparkles size={13} />
              <span className="text-xs font-medium">My Folder に追加済み</span>
            </div>
          ) : (
            <button
              onClick={(e) => { e.stopPropagation(); onGotIt(); }}
              disabled={saving}
              className="w-full flex items-center justify-center gap-1.5 py-2 rounded-lg bg-gradient-to-r from-teal-500 to-emerald-500 text-white text-xs font-semibold hover:from-teal-600 hover:to-emerald-600 transition-all disabled:opacity-60 shadow-sm"
            >
              {saving ? (
                <Loader2 size={13} className="animate-spin" />
              ) : (
                <Check size={13} />
              )}
              {saving ? '保存中...' : '理解した！'}
            </button>
          )}
        </div>
      )}
    </div>
  );
}
