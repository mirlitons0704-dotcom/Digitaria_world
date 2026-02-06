import { useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { useChapters } from '../hooks/useChapters';
import { ChapterCard } from '../components/ChapterCard';
import { Layout } from '../components/Layout';
import { Loader2, BookOpen, Folder, Search } from 'lucide-react';

export function HomePage() {
  const navigate = useNavigate();
  const { user } = useAuth();
  const { chapters, loading, error } = useChapters();

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
        <div className="flex items-center justify-center min-h-[60vh]">
          <p className="text-red-500">Failed to load chapters</p>
        </div>
      </Layout>
    );
  }

  const mainChapters = chapters.filter(c => c.id >= 1 && c.id <= 16);
  const epilogue = chapters.find(c => c.id === 17);

  return (
    <Layout>
      <div className="max-w-7xl mx-auto px-4 py-8">
        <header className="mb-12">
          <div className="flex items-center justify-center gap-6">
            <div className="hidden md:block w-28 flex-shrink-0">
              <video
                className="w-full h-auto"
                src="/c1_happy.mp4"
                autoPlay
                loop
                muted
                playsInline
              />
            </div>

            <div className="text-center">
              <h1 className="text-3xl md:text-4xl text-gray-800 font-display mb-2">
                Your Journey Awaits
              </h1>
              <p className="text-gray-600 font-titillium-light text-lg">
                Explore 520 programming terms across 17 chapters
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

            <div className="hidden md:block w-28 flex-shrink-0" />
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

            <div className="max-w-sm">
              <ChapterCard
                chapter={epilogue}
                onClick={() => navigate(`/chapter/${epilogue.id}`)}
                isSpecial
              />
            </div>
          </section>
        )}
      </div>
    </Layout>
  );
}
