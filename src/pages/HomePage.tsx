import { useNavigate } from 'react-router-dom';
import { useTranslation } from 'react-i18next';
import { useAuth } from '../contexts/AuthContext';
import { useChapters } from '../hooks/useChapters';
import { ChapterCard } from '../components/ChapterCard';
import { Layout } from '../components/Layout';
import { ASSETS, TOTAL_TERMS } from '../lib/constants';
import { Loader2, BookOpen, Folder, Search } from 'lucide-react';

export function HomePage() {
  const navigate = useNavigate();
  const { t, i18n } = useTranslation();
  const { user } = useAuth();
  const { chapters, loading, error, retry } = useChapters();

  if (!user) {
    navigate('/');
    return null;
  }

  if (loading) {
    return (
      <Layout>
        <div className="flex items-center justify-center min-h-[60vh]">
          <Loader2 className="w-8 h-8 animate-spin text-teal-500" />
        </div>
      </Layout>
    );
  }

  if (error) {
    return (
      <Layout>
        <div className="flex flex-col items-center justify-center min-h-[60vh] gap-4">
          <p className="text-red-500">{t('home.loadError')}</p>
          <button
            onClick={retry}
            className="px-4 py-2 bg-teal-500 text-white rounded-lg hover:bg-teal-600 transition-colors text-sm"
          >
            {t('common.retry')}
          </button>
        </div>
      </Layout>
    );
  }

  const mainChapters = chapters.filter((c) => c.id >= 1 && c.id <= 16);
  const epilogue = chapters.find((c) => c.id === 17);

  return (
    <Layout>
      <div className="max-w-7xl mx-auto px-4 py-8">
        <header className="mb-12">
          <div className="flex items-center justify-center gap-4 md:gap-6">
            <div className="w-20 md:w-28 flex-shrink-0">
              <video
                className="w-full h-auto rounded-lg"
                src={ASSETS.bitKunHappy}
                autoPlay
                loop
                muted
                playsInline
              />
            </div>

            <div className="text-center flex-1">
              <h1 className="text-2xl md:text-4xl text-gray-800 font-display mb-2">
                {t('home.title')}
              </h1>
              <p className="text-gray-600 font-titillium-light text-sm md:text-lg">
                {t('home.subtitle', { count: TOTAL_TERMS })}
              </p>

              <div className="flex flex-wrap justify-center gap-4 mt-6">
                <button
                  onClick={() => navigate('/my-folder')}
                  className="flex items-center gap-2 px-6 py-3 bg-white/70 backdrop-blur-sm rounded-xl shadow-md hover:shadow-lg transition-all hover:-translate-y-0.5"
                >
                  <Folder className="w-5 h-5 text-amber-500" />
                  <span className="font-titillium-semibold text-gray-700">
                    {t('home.myFolder')}
                  </span>
                </button>
                <button
                  onClick={() => navigate('/search')}
                  className="flex items-center gap-2 px-6 py-3 bg-white/70 backdrop-blur-sm rounded-xl shadow-md hover:shadow-lg transition-all hover:-translate-y-0.5"
                >
                  <Search className="w-5 h-5 text-teal-500" />
                  <span className="font-titillium-semibold text-gray-700">
                    {t('home.searchTerms')}
                  </span>
                </button>
              </div>

              {/* Language toggle */}
              <div className="mt-4 flex justify-center">
                <div className="inline-flex rounded-full bg-white/60 backdrop-blur-sm border border-gray-200/50 p-1 text-xs">
                  <button
                    onClick={() => i18n.changeLanguage('ja')}
                    className={`px-3 py-1 rounded-full transition-all ${
                      i18n.language === 'ja'
                        ? 'bg-teal-500 text-white shadow-sm'
                        : 'text-gray-500 hover:text-gray-700'
                    }`}
                  >
                    🇯🇵 日本語
                  </button>
                  <button
                    onClick={() => i18n.changeLanguage('en')}
                    className={`px-3 py-1 rounded-full transition-all ${
                      i18n.language === 'en'
                        ? 'bg-teal-500 text-white shadow-sm'
                        : 'text-gray-500 hover:text-gray-700'
                    }`}
                  >
                    🇬🇧 English
                  </button>
                </div>
              </div>
            </div>

            <div className="w-20 md:w-28 flex-shrink-0">
              <video
                className="w-full h-auto rounded-lg"
                src={ASSETS.byteSanEncourage}
                autoPlay
                loop
                muted
                playsInline
              />
            </div>
          </div>

          {/* Scrolling marquee */}
          <div className="mt-6 overflow-hidden">
            <div className="animate-marquee whitespace-nowrap">
              <span className="text-teal-600 font-titillium-semibold text-sm mx-4">
                {t('home.marquee')}
              </span>
              <span className="text-teal-600 font-titillium-semibold text-sm mx-4">
                {t('home.marquee')}
              </span>
            </div>
          </div>
        </header>

        <section className="mb-12">
          <div className="flex items-center gap-3 mb-6">
            <BookOpen className="w-6 h-6 text-teal-600" />
            <h2 className="text-xl font-titillium-semibold text-gray-800">{t('home.mainStory')}</h2>
            <span className="text-sm text-gray-500 font-titillium-light">
              {t('home.chapters', { count: 16 })}
            </span>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
            {mainChapters.map((chapter) => (
              <ChapterCard
                key={chapter.id}
                chapter={chapter}
                chapterIndex={chapter.id}
                onClick={() => navigate(`/chapter/${chapter.id}`)}
              />
            ))}
          </div>
        </section>

        {epilogue && (
          <section>
            <div className="flex items-center gap-3 mb-6">
              <span className="text-2xl">🦋</span>
              <h2 className="text-xl font-titillium-semibold text-gray-800">
                {t('home.epilogue')}
              </h2>
              <span className="text-sm text-gray-500 font-titillium-light">
                {t('home.memoryGarden')}
              </span>
            </div>

            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4 gap-6">
              <div className="sm:col-span-2 lg:col-span-3 xl:col-span-4">
                <ChapterCard
                  chapter={epilogue}
                  onClick={() => navigate(`/chapter/${epilogue.id}`)}
                  isSpecial
                />
              </div>
            </div>
          </section>
        )}
      </div>
    </Layout>
  );
}
