import { Term } from '../lib/database.types';
import { Lightbulb, BookOpen, AlertTriangle, Link2 } from 'lucide-react';

interface FlashCardProps {
  term: Term;
  isFlipped: boolean;
  onFlip: () => void;
}

export function FlashCard({ term, isFlipped, onFlip }: FlashCardProps) {
  const difficultyStars = Array(3).fill(0).map((_, i) => i < term.difficulty);

  return (
    <div
      className="relative w-full aspect-[4/3] cursor-pointer perspective-1000"
      onClick={onFlip}
    >
      <div
        className={`
          relative w-full h-full transition-transform duration-500 transform-style-3d
          ${isFlipped ? 'rotate-y-180' : ''}
        `}
        style={{
          transformStyle: 'preserve-3d',
          transform: isFlipped ? 'rotateY(180deg)' : 'rotateY(0deg)',
        }}
      >
        <div
          className="absolute inset-0 bg-gradient-to-br from-white to-gray-50 rounded-3xl p-6 flex flex-col shadow-xl border border-gray-100"
          style={{ backfaceVisibility: 'hidden' }}
        >
          <div className="flex items-center justify-between mb-4">
            <div className="flex items-center gap-1">
              {difficultyStars.map((active, i) => (
                <span
                  key={i}
                  className={`text-sm ${active ? 'text-amber-400' : 'text-gray-200'}`}
                >
                  ★
                </span>
              ))}
            </div>
            <span className="text-xs text-gray-400 px-2 py-1 bg-gray-100 rounded-full">
              #{term.order_index}
            </span>
          </div>

          <div className="flex-1 flex flex-col items-center justify-center text-center">
            <h2 className="text-3xl md:text-4xl font-bold text-gray-800 mb-3">
              {term.term}
            </h2>
            <p className="text-xl text-gray-600">{term.term_ja}</p>
          </div>

          <p className="text-sm text-gray-400 text-center mt-auto">
            Tap to see definition
          </p>
        </div>

        <div
          className="absolute inset-0 bg-gradient-to-br from-teal-50 to-emerald-50 rounded-3xl p-5 shadow-xl border border-teal-100 overflow-y-auto"
          style={{
            backfaceVisibility: 'hidden',
            transform: 'rotateY(180deg)',
          }}
        >
          <div className="flex items-center justify-between mb-3">
            <h3 className="font-semibold text-gray-800">{term.term}</h3>
            <span className="text-xs text-gray-500">{term.term_ja}</span>
          </div>

          <div className="space-y-4 text-sm">
            <div>
              <p className="font-medium text-teal-700 mb-1">{term.one_liner}</p>
            </div>

            <div className="flex items-start gap-2">
              <BookOpen size={16} className="text-gray-400 mt-0.5 shrink-0" />
              <p className="text-gray-600">{term.definition}</p>
            </div>

            {term.analogy && (
              <div className="flex items-start gap-2 bg-white/60 rounded-xl p-3">
                <Lightbulb size={16} className="text-amber-500 mt-0.5 shrink-0" />
                <div>
                  <p className="text-xs text-amber-600 font-medium mb-1">Analogy</p>
                  <p className="text-gray-600">{term.analogy}</p>
                </div>
              </div>
            )}

            {term.pitfall && (
              <div className="flex items-start gap-2 bg-white/60 rounded-xl p-3">
                <AlertTriangle size={16} className="text-rose-500 mt-0.5 shrink-0" />
                <div>
                  <p className="text-xs text-rose-600 font-medium mb-1">Watch out</p>
                  <p className="text-gray-600">{term.pitfall}</p>
                </div>
              </div>
            )}

            {term.related_terms && term.related_terms.length > 0 && (
              <div className="flex items-start gap-2">
                <Link2 size={16} className="text-gray-400 mt-0.5 shrink-0" />
                <div>
                  <p className="text-xs text-gray-500 mb-1">Related</p>
                  <div className="flex flex-wrap gap-1">
                    {term.related_terms.map((relatedId) => (
                      <span
                        key={relatedId}
                        className="text-xs px-2 py-0.5 bg-white/80 rounded-full text-gray-600"
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
      </div>
    </div>
  );
}
