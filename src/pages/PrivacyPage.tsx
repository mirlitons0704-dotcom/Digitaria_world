import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { ArrowLeft } from 'lucide-react';

export function PrivacyPage() {
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

        <h1 className="text-3xl font-bold text-gray-800 mb-8">{t('privacy.title')}</h1>

        <div className="prose prose-gray max-w-none space-y-6 text-gray-600 text-sm leading-relaxed">
          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">
              {t('privacy.section1Title')}
            </h2>
            <p>{t('privacy.section1Intro')}</p>
            <ul className="list-disc pl-5 space-y-1">
              {(t('privacy.section1Items', { returnObjects: true }) as string[]).map((item, i) => (
                <li key={i}>{item}</li>
              ))}
            </ul>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">
              {t('privacy.section2Title')}
            </h2>
            <p>{t('privacy.section2Intro')}</p>
            <ul className="list-disc pl-5 space-y-1">
              {(t('privacy.section2Items', { returnObjects: true }) as string[]).map((item, i) => (
                <li key={i}>{item}</li>
              ))}
            </ul>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">
              {t('privacy.section3Title')}
            </h2>
            <p>{t('privacy.section3Text')}</p>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">
              {t('privacy.section4Title')}
            </h2>
            <p>{t('privacy.section4Text')}</p>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">
              {t('privacy.section5Title')}
            </h2>
            <p>{t('privacy.section5Text')}</p>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">
              {t('privacy.section6Title')}
            </h2>
            <p>{t('privacy.section6Text')}</p>
          </section>

          <p className="text-xs text-gray-400 mt-8">{t('privacy.lastUpdated')}</p>
        </div>
      </div>
    </div>
  );
}
