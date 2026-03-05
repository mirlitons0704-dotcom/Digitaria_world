import { BookOpen, Cog, Lightbulb, AlertTriangle, X } from 'lucide-react';
import type { Term } from '../lib/database.types';

// ---------------------------------------------------------------------------
// Types
// ---------------------------------------------------------------------------

export interface CollectedTerm extends Term {
  collected_at: string;
}

// ---------------------------------------------------------------------------
// Difficulty badge colours
// ---------------------------------------------------------------------------

const DIFF_COLORS: Record<number, { bg: string; border: string; text: string }> = {
  1: {
    bg: 'from-emerald-50 to-teal-50',
    border: 'border-emerald-200/60',
    text: 'text-emerald-600',
  },
  2: { bg: 'from-blue-50 to-sky-50', border: 'border-blue-200/60', text: 'text-blue-600' },
  3: { bg: 'from-violet-50 to-purple-50', border: 'border-violet-200/60', text: 'text-violet-600' },
};

export function diffColor(d: number) {
  return DIFF_COLORS[d] || DIFF_COLORS[1];
}

// ---------------------------------------------------------------------------
// Sub-components
// ---------------------------------------------------------------------------

/** Expanded term detail panel (mini version of InlineTermCard) */
export function TermDetail({ term, onClose }: { term: Term; onClose: () => void }) {
  return (
    <div className="mt-2 rounded-xl bg-white/90 backdrop-blur-sm border border-gray-200/60 shadow-sm overflow-hidden animate-[inline-term-card-enter_0.2s_ease-out]">
      <div className="px-4 pt-3 pb-2">
        <div className="flex items-start justify-between mb-2">
          <div>
            <h4 className="font-bold text-gray-800">{term.term}</h4>
            <p className="text-xs text-teal-600 font-medium">{term.one_liner}</p>
          </div>
          <button
            onClick={onClose}
            className="p-1 rounded-full text-gray-400 hover:text-gray-600 hover:bg-gray-100 transition-colors"
          >
            <X size={14} />
          </button>
        </div>

        <div className="flex items-start gap-2 mb-3">
          <BookOpen size={13} className="text-gray-400 mt-0.5 shrink-0" />
          <p className="text-sm text-gray-600 leading-relaxed">{term.definition}</p>
        </div>

        <div className="space-y-2">
          {term.mechanism && (
            <div className="bg-gray-50 rounded-lg p-2.5">
              <div className="flex items-start gap-2">
                <Cog size={13} className="text-gray-400 mt-0.5 shrink-0" />
                <div>
                  <p className="text-[10px] text-gray-500 font-medium mb-0.5">How it works</p>
                  <p className="text-xs text-gray-600 leading-relaxed">{term.mechanism}</p>
                </div>
              </div>
            </div>
          )}
          {term.analogy && (
            <div className="bg-gray-50 rounded-lg p-2.5">
              <div className="flex items-start gap-2">
                <Lightbulb size={13} className="text-amber-500 mt-0.5 shrink-0" />
                <div>
                  <p className="text-[10px] text-amber-600 font-medium mb-0.5">Analogy</p>
                  <p className="text-xs text-gray-600 leading-relaxed">{term.analogy}</p>
                </div>
              </div>
            </div>
          )}
          {term.pitfall && (
            <div className="bg-gray-50 rounded-lg p-2.5">
              <div className="flex items-start gap-2">
                <AlertTriangle size={13} className="text-rose-500 mt-0.5 shrink-0" />
                <div>
                  <p className="text-[10px] text-rose-600 font-medium mb-0.5">Watch out</p>
                  <p className="text-xs text-gray-600 leading-relaxed">{term.pitfall}</p>
                </div>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

/** Butterfly card (grid mode) */
export function ButterflyCard({
  term,
  isExpanded,
  onToggle,
}: {
  term: CollectedTerm;
  isExpanded: boolean;
  onToggle: () => void;
}) {
  const dc = diffColor(term.difficulty);
  return (
    <div>
      <button
        onClick={onToggle}
        className={`w-full text-left bg-gradient-to-br ${dc.bg} rounded-xl p-3 border ${dc.border} hover:shadow-md transition-all ${
          isExpanded ? 'ring-2 ring-teal-400/40' : ''
        }`}
      >
        <div className="flex items-center justify-between mb-1">
          <span className="text-lg">🦋</span>
          <span className={`text-[10px] font-medium ${dc.text}`}>
            {'★'.repeat(term.difficulty)}
          </span>
        </div>
        <p className="font-medium text-gray-800 text-sm truncate">{term.term}</p>
        <p className="text-xs text-gray-500 truncate">{term.term_ja}</p>
      </button>
      {isExpanded && <TermDetail term={term} onClose={onToggle} />}
    </div>
  );
}

/** Butterfly row (list mode) */
export function ButterflyRow({
  term,
  isExpanded,
  onToggle,
}: {
  term: CollectedTerm;
  isExpanded: boolean;
  onToggle: () => void;
}) {
  const dc = diffColor(term.difficulty);
  return (
    <div>
      <button
        onClick={onToggle}
        className={`w-full flex items-center gap-3 p-3 rounded-xl transition-all hover:bg-gray-50 ${
          isExpanded ? 'bg-gray-50 ring-1 ring-teal-400/30' : ''
        }`}
      >
        <span className="text-xl shrink-0">🦋</span>
        <div className="flex-1 min-w-0 text-left">
          <p className="font-medium text-gray-800 truncate">{term.term}</p>
          <p className="text-sm text-gray-500 truncate">{term.one_liner}</p>
        </div>
        <span className={`text-xs font-medium ${dc.text} shrink-0`}>
          {'★'.repeat(term.difficulty)}
        </span>
      </button>
      {isExpanded && <TermDetail term={term} onClose={onToggle} />}
    </div>
  );
}
