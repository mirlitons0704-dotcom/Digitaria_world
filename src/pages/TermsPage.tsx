import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { ArrowLeft } from 'lucide-react';

export function TermsPage() {
  const navigate = useNavigate();
  const { t } = useTranslation();

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-200 via-gray-100 to-slate-200">
      <div className="max-w-3xl mx-auto px-4 py-12">
        <button
          onClick={() => navigate(-1)}
          className="flex items-center gap-2 text-gray-500 hover:text-gray-700 mb-8 transition-colors"
        >
          <ArrowLeft size={18} />
          <span className="text-sm">{t('common.back')}</span>
        </button>

        <h1 className="text-3xl font-bold text-gray-800 mb-8">{t('terms.title')}</h1>

        <div className="prose prose-gray max-w-none space-y-6 text-gray-600 text-sm leading-relaxed">
          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">{t('terms.section1Title')}</h2>
            <p>{t('terms.section1Text')}</p>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">{t('terms.section2Title')}</h2>
            <p>{t('terms.section2Text')}</p>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">{t('terms.section3Title')}</h2>
            <ul className="list-disc pl-5 space-y-1">
              {(t('terms.section3Items', { returnObjects: true }) as string[]).map((item, i) => (
                <li key={i}>{item}</li>
              ))}
            </ul>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">{t('terms.section4Title')}</h2>
            <p>{t('terms.section4Text')}</p>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">{t('terms.section5Title')}</h2>
            <p>{t('terms.section5Text')}</p>
          </section>

          <p className="text-xs text-gray-400 mt-8">{t('terms.lastUpdated')}</p>
        </div>
      </div>
    </div>
  );
}
