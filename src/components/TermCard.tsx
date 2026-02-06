import { Term } from '../lib/database.types';
import { ChevronDown, Lightbulb, BookOpen, AlertTriangle, Cog } from 'lucide-react';

interface TermCardProps {
  term: Term;
  isExpanded: boolean;
  onToggle: () => void;
}

export function TermCard({ term, isExpanded, onToggle }: TermCardProps) {
  const difficultyStars = Array(3).fill(0).map((_, i) => i < term.difficulty);

  return (
    <div
      className={`
        bg-white/70 backdrop-blur-sm rounded-xl border transition-all duration-300
        ${isExpanded ? 'border-teal-200 shadow-lg' : 'border-gray-200/50 hover:border-gray-300'}
      `}
    >
      <button
        onClick={onToggle}
        className="w-full flex items-center justify-between p-4 text-left"
      >
        <div className="flex items-center gap-4">
          <div className="flex flex-col items-center">
            <span className="text-xs text-gray-400">#{term.order_index}</span>
            <div className="flex gap-0.5 mt-1">
              {difficultyStars.map((active, i) => (
                <span
                  key={i}
                  className={`text-xs ${active ? 'text-amber-400' : 'text-gray-200'}`}
                >
                  ★
                </span>
              ))}
            </div>
          </div>
          <div>
            <h3 className="font-semibold text-gray-800">{term.term}</h3>
            <p className="text-sm text-gray-500">{term.term_ja}</p>
          </div>
        </div>

        <div className="flex items-center gap-3">
          <p className="hidden sm:block text-sm text-gray-500 max-w-xs truncate">
            {term.one_liner}
          </p>
          <ChevronDown
            size={20}
            className={`text-gray-400 transition-transform ${isExpanded ? 'rotate-180' : ''}`}
          />
        </div>
      </button>

      {isExpanded && (
        <div className="px-4 pb-4 space-y-4 border-t border-gray-100 pt-4">
          <div>
            <p className="font-medium text-teal-700 mb-2">{term.one_liner}</p>
            <div className="flex items-start gap-2">
              <BookOpen size={16} className="text-gray-400 mt-1 shrink-0" />
              <p className="text-gray-600 text-sm">{term.definition}</p>
            </div>
          </div>

          {term.mechanism && (
            <div className="flex items-start gap-2 bg-gray-50 rounded-lg p-3">
              <Cog size={16} className="text-gray-400 mt-0.5 shrink-0" />
              <div>
                <p className="text-xs text-gray-500 font-medium mb-1">How it works</p>
                <p className="text-gray-600 text-sm">{term.mechanism}</p>
              </div>
            </div>
          )}

          {term.analogy && (
            <div className="flex items-start gap-2 bg-amber-50 rounded-lg p-3">
              <Lightbulb size={16} className="text-amber-500 mt-0.5 shrink-0" />
              <div>
                <p className="text-xs text-amber-600 font-medium mb-1">Analogy</p>
                <p className="text-gray-600 text-sm">{term.analogy}</p>
              </div>
            </div>
          )}

          {term.pitfall && (
            <div className="flex items-start gap-2 bg-rose-50 rounded-lg p-3">
              <AlertTriangle size={16} className="text-rose-500 mt-0.5 shrink-0" />
              <div>
                <p className="text-xs text-rose-600 font-medium mb-1">Common mistake</p>
                <p className="text-gray-600 text-sm">{term.pitfall}</p>
              </div>
            </div>
          )}

          {term.related_terms && term.related_terms.length > 0 && (
            <div>
              <p className="text-xs text-gray-500 mb-2">Related terms</p>
              <div className="flex flex-wrap gap-2">
                {term.related_terms.map((relatedId) => (
                  <span
                    key={relatedId}
                    className="text-xs px-3 py-1 bg-gray-100 rounded-full text-gray-600"
                  >
                    {relatedId}
                  </span>
                ))}
              </div>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
