import { BookOpen, Lightbulb, AlertTriangle, Cog, X, Check, Loader2, Sparkles, Link2 } from 'lucide-react';
import type { Term } from '../lib/database.types';

interface InlineTermCardProps {
  term: Term;
  isCollected?: boolean;
  saving?: boolean;
  onClose: () => void;
  onGotIt?: () => void;
}

export function InlineTermCard({ term, isCollected, saving, onClose, onGotIt }: InlineTermCardProps) {
  return (
    <div className="inline-term-card mt-3 mb-2 rounded-2xl bg-gradient-to-br from-emerald-50/80 to-teal-50/60 backdrop-blur-md border border-emerald-200/50 shadow-lg shadow-emerald-100/30 overflow-hidden">
      <div className="px-5 pt-4 pb-3">
        <div className="flex items-start justify-between mb-3">
          <div>
            <h4 className="text-lg font-bold text-gray-800">{term.term}</h4>
            <p className="text-sm text-teal-700 font-medium mt-1">{term.one_liner}</p>
          </div>
          <div className="flex items-center gap-2 shrink-0">
            <span className="text-xs text-gray-500">{term.term_ja}</span>
            <button
              onClick={(e) => { e.stopPropagation(); onClose(); }}
              className="p-1 rounded-full text-gray-400 hover:text-gray-600 hover:bg-white/60 transition-colors"
            >
              <X size={16} />
            </button>
          </div>
        </div>

        <div className="flex items-start gap-2 mb-4">
          <BookOpen size={15} className="text-gray-400 mt-0.5 shrink-0" />
          <p className="text-sm text-gray-600 leading-relaxed">{term.definition}</p>
        </div>

        <div className="space-y-3">
          {term.mechanism && (
            <div className="bg-white/50 rounded-xl p-3">
              <div className="flex items-start gap-2">
                <Cog size={15} className="text-gray-400 mt-0.5 shrink-0" />
                <div>
                  <p className="text-xs text-gray-500 font-medium mb-1">How it works</p>
                  <p className="text-sm text-gray-600 leading-relaxed">{term.mechanism}</p>
                </div>
              </div>
            </div>
          )}

          {term.analogy && (
            <div className="bg-white/50 rounded-xl p-3">
              <div className="flex items-start gap-2">
                <Lightbulb size={15} className="text-amber-500 mt-0.5 shrink-0" />
                <div>
                  <p className="text-xs text-amber-600 font-medium mb-1">Analogy</p>
                  <p className="text-sm text-gray-600 leading-relaxed">{term.analogy}</p>
                </div>
              </div>
            </div>
          )}

          {term.pitfall && (
            <div className="bg-white/50 rounded-xl p-3">
              <div className="flex items-start gap-2">
                <AlertTriangle size={15} className="text-rose-500 mt-0.5 shrink-0" />
                <div>
                  <p className="text-xs text-rose-600 font-medium mb-1">Watch out</p>
                  <p className="text-sm text-gray-600 leading-relaxed">{term.pitfall}</p>
                </div>
              </div>
            </div>
          )}

          {term.related_terms && term.related_terms.length > 0 && (
            <div className="flex items-start gap-2 pt-1">
              <Link2 size={15} className="text-gray-400 mt-0.5 shrink-0" />
              <div>
                <p className="text-xs text-gray-500 mb-1.5">Related</p>
                <div className="flex flex-wrap gap-1.5">
                  {term.related_terms.map((relatedId) => (
                    <span
                      key={relatedId}
                      className="text-xs px-2.5 py-0.5 bg-white/70 rounded-full text-gray-600 border border-gray-200/50"
                    >
                      {relatedId}
                    </span>
                  ))}
                </div>
              </div>
            </div>
          )}
        </div>
      </div>

      {onGotIt && (
        <div className="px-5 pb-4 pt-2 border-t border-emerald-100/50">
          {isCollected ? (
            <div className="flex items-center justify-center gap-1.5 py-1.5 text-emerald-600">
              <Sparkles size={13} />
              <span className="text-xs font-medium">My Folder に追加済み</span>
            </div>
          ) : (
            <button
              onClick={(e) => { e.stopPropagation(); onGotIt(); }}
              disabled={saving}
              className="w-full flex items-center justify-center gap-1.5 py-2.5 rounded-xl bg-gradient-to-r from-teal-500 to-emerald-500 text-white text-sm font-semibold hover:from-teal-600 hover:to-emerald-600 transition-all disabled:opacity-60 shadow-sm"
            >
              {saving ? (
                <Loader2 size={14} className="animate-spin" />
              ) : (
                <Check size={14} />
              )}
              {saving ? '保存中...' : '理解した！'}
            </button>
          )}
        </div>
      )}
    </div>
  );
}
