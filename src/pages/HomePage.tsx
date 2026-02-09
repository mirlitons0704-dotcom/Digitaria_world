import { useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { useChapters } from '../hooks/useChapters';
import { ChapterCard } from '../components/ChapterCard';
import { Layout } from '../components/Layout';
import { ASSETS, TOTAL_TERMS } from '../lib/constants';
import { Loader2, BookOpen, Folder, Search } from 'lucide-react';

export function HomePage() {
  const navigate = useNavigate();
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
          <p className="text-red-500">Failed to load chapters</p>
          <button
            onClick={retry}
            className="px-4 py-2 bg-teal-500 text-white rounded-lg hover:bg-teal-600 transition-colors text-sm"
          >
            Retry
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
                Your Journey Awaits
              </h1>
              <p className="text-gray-600 font-titillium-light text-sm md:text-lg">
                Explore {TOTAL_TERMS} programming terms across 17 chapters
              </p>

              <div className="flex flex-wrap justify-center gap-4 mt-6">
                <button
                  onClick={() => navigate('/my-folder')}
                  className="flex items-center gap-2 px-6 py-3 bg-white/70 backdrop-blur-sm rounded-xl shadow-md hover:shadow-lg transition-all hover:-translate-y-0.5"
                >
                  <Folder className="w-5 h-5 text-amber-500" />
                  <span className="font-titillium-semibold text-gray-700">My Folder</span>
                </button>
                <button
                  onClick={() => navigate('/search')}
                  className="flex items-center gap-2 px-6 py-3 bg-white/70 backdrop-blur-sm rounded-xl shadow-md hover:shadow-lg transition-all hover:-translate-y-0.5"
                >
                  <Search className="w-5 h-5 text-teal-500" />
                  <span className="font-titillium-semibold text-gray-700">Search Terms</span>
                </button>
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
                ビットくんとバイトさんが、あなたのプログラミング用語習得の旅を応援するよ!
                さあ、用語の理解で、世界が開けていく感覚を思いっきり味わって!!
              </span>
              <span className="text-teal-600 font-titillium-semibold text-sm mx-4">
                ビットくんとバイトさんが、あなたのプログラミング用語習得の旅を応援するよ!
                さあ、用語の理解で、世界が開けていく感覚を思いっきり味わって!!
              </span>
            </div>
          </div>
        </header>

        <section className="mb-12">
          <div className="flex items-center gap-3 mb-6">
            <BookOpen className="w-6 h-6 text-teal-600" />
            <h2 className="text-xl font-titillium-semibold text-gray-800">Main Story</h2>
            <span className="text-sm text-gray-500 font-titillium-light">16 Chapters</span>
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
              <h2 className="text-xl font-titillium-semibold text-gray-800">Epilogue</h2>
              <span className="text-sm text-gray-500 font-titillium-light">Memory Garden</span>
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
