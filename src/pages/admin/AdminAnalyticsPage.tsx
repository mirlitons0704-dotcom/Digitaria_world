import { useEffect, useState } from 'react';
import { AdminLayout } from '../../components/AdminLayout';
import {
  getAnalyticsOverview,
  getChapterAnalytics,
  getButterflyDistribution,
  getDifficultyBreakdown,
  type AnalyticsOverview,
  type ChapterStats,
  type ButterflyDistribution,
  type DifficultyBreakdown,
} from '../../lib/adminApi';
import { Loader2, Users, Bug, Trophy, TrendingUp } from 'lucide-react';

const STAGE_COLORS: Record<string, { bg: string; label: string }> = {
  none: { bg: 'bg-gray-600', label: 'None' },
  light: { bg: 'bg-sky-400', label: 'Light' },
  egg: { bg: 'bg-lime-400', label: 'Egg' },
  larva: { bg: 'bg-yellow-400', label: 'Larva' },
  pupa: { bg: 'bg-orange-400', label: 'Pupa' },
  butterfly: { bg: 'bg-teal-400', label: 'Butterfly' },
};

const DIFFICULTY_LABELS: Record<number, { label: string; color: string }> = {
  1: { label: 'Easy', color: 'text-emerald-400' },
  2: { label: 'Medium', color: 'text-amber-400' },
  3: { label: 'Hard', color: 'text-red-400' },
};

function BarChart({
  value,
  max,
  color = 'bg-teal-500',
}: {
  value: number;
  max: number;
  color?: string;
}) {
  const width = max > 0 ? Math.round((value / max) * 100) : 0;
  return (
    <div className="w-full h-2 bg-gray-800 rounded-full overflow-hidden">
      <div
        className={`h-full ${color} rounded-full transition-all duration-700`}
        style={{ width: `${width}%` }}
      />
    </div>
  );
}

export function AdminAnalyticsPage() {
  const [overview, setOverview] = useState<AnalyticsOverview | null>(null);
  const [chapterStats, setChapterStats] = useState<ChapterStats[]>([]);
  const [butterflyDist, setButterflyDist] = useState<ButterflyDistribution[]>(
    [],
  );
  const [difficultyStats, setDifficultyStats] = useState<
    DifficultyBreakdown[]
  >([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function loadData() {
      try {
        const [ov, chapters, butterflies, difficulty] = await Promise.all([
          getAnalyticsOverview(),
          getChapterAnalytics(),
          getButterflyDistribution(),
          getDifficultyBreakdown(),
        ]);
        setOverview(ov);
        setChapterStats(chapters);
        setButterflyDist(butterflies);
        setDifficultyStats(difficulty);
      } catch (err) {
        console.error('Failed to load analytics:', err);
      } finally {
        setLoading(false);
      }
    }
    loadData();
  }, []);

  if (loading) {
    return (
      <AdminLayout>
        <div className="flex items-center justify-center min-h-[60vh]">
          <Loader2 className="w-8 h-8 animate-spin text-teal-400" />
        </div>
      </AdminLayout>
    );
  }

  const maxUsersStarted = Math.max(
    ...chapterStats.map((c) => c.users_started),
    1,
  );
  const totalButterflyRecords = butterflyDist.reduce(
    (sum, b) => sum + b.count,
    0,
  );

  return (
    <AdminLayout>
      <div className="space-y-8">
        <div>
          <h1 className="text-2xl font-semibold text-white mb-1">
            Analytics
          </h1>
          <p className="text-sm text-gray-500">
            Learning progress and engagement metrics
          </p>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
          {[
            {
              label: 'Total Users',
              value: overview?.totalUsers ?? 0,
              icon: Users,
              color: 'teal',
            },
            {
              label: 'Terms Mastered',
              value: overview?.totalTermsMastered ?? 0,
              icon: Bug,
              color: 'amber',
            },
            {
              label: 'Quizzes Taken',
              value: overview?.totalQuizzesTaken ?? 0,
              icon: Trophy,
              color: 'blue',
            },
            {
              label: 'Avg Butterflies',
              value: overview?.averageButterflies ?? 0,
              icon: TrendingUp,
              color: 'emerald',
            },
          ].map((stat) => {
            const colorMap: Record<
              string,
              { bg: string; text: string; border: string }
            > = {
              teal: {
                bg: 'bg-teal-500/10',
                text: 'text-teal-400',
                border: 'border-teal-500/20',
              },
              amber: {
                bg: 'bg-amber-500/10',
                text: 'text-amber-400',
                border: 'border-amber-500/20',
              },
              blue: {
                bg: 'bg-blue-500/10',
                text: 'text-blue-400',
                border: 'border-blue-500/20',
              },
              emerald: {
                bg: 'bg-emerald-500/10',
                text: 'text-emerald-400',
                border: 'border-emerald-500/20',
              },
            };
            const c = colorMap[stat.color];
            const Icon = stat.icon;
            return (
              <div
                key={stat.label}
                className={`bg-gray-900 border ${c.border} rounded-xl p-5`}
              >
                <div className="flex items-center gap-3 mb-3">
                  <div
                    className={`w-9 h-9 rounded-lg ${c.bg} flex items-center justify-center`}
                  >
                    <Icon size={18} className={c.text} />
                  </div>
                  <span className="text-xs text-gray-500">{stat.label}</span>
                </div>
                <p className="text-2xl font-semibold text-white">
                  {stat.value}
                </p>
              </div>
            );
          })}
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <div className="bg-gray-900 border border-gray-800 rounded-xl">
            <div className="p-6 border-b border-gray-800">
              <h2 className="text-sm font-semibold text-white">
                Butterfly Stage Distribution
              </h2>
              <p className="text-xs text-gray-500 mt-1">
                {totalButterflyRecords} total progress records
              </p>
            </div>
            <div className="p-6 space-y-4">
              {butterflyDist.map((item) => {
                const config = STAGE_COLORS[item.stage] || STAGE_COLORS.none;
                const pct =
                  totalButterflyRecords > 0
                    ? Math.round((item.count / totalButterflyRecords) * 100)
                    : 0;
                return (
                  <div key={item.stage}>
                    <div className="flex items-center justify-between mb-1.5">
                      <div className="flex items-center gap-2">
                        <div
                          className={`w-3 h-3 rounded-full ${config.bg}`}
                        />
                        <span className="text-sm text-gray-300">
                          {config.label}
                        </span>
                      </div>
                      <span className="text-xs text-gray-500">
                        {item.count} ({pct}%)
                      </span>
                    </div>
                    <BarChart
                      value={item.count}
                      max={totalButterflyRecords}
                      color={config.bg}
                    />
                  </div>
                );
              })}
            </div>
          </div>

          <div className="bg-gray-900 border border-gray-800 rounded-xl">
            <div className="p-6 border-b border-gray-800">
              <h2 className="text-sm font-semibold text-white">
                Mastery by Difficulty
              </h2>
              <p className="text-xs text-gray-500 mt-1">
                Terms mastered per difficulty level
              </p>
            </div>
            <div className="p-6 space-y-6">
              {difficultyStats.map((item) => {
                const config = DIFFICULTY_LABELS[item.difficulty];
                const pct =
                  item.total > 0
                    ? Math.round((item.mastered / item.total) * 100)
                    : 0;
                return (
                  <div key={item.difficulty}>
                    <div className="flex items-center justify-between mb-2">
                      <div className="flex items-center gap-2">
                        <span className={`text-sm font-medium ${config.color}`}>
                          {'*'.repeat(item.difficulty)}
                        </span>
                        <span className="text-sm text-gray-300">
                          {config.label}
                        </span>
                      </div>
                      <span className="text-xs text-gray-500">
                        {item.mastered} / {item.total} terms ({pct}%)
                      </span>
                    </div>
                    <BarChart
                      value={item.mastered}
                      max={item.total}
                      color={
                        item.difficulty === 1
                          ? 'bg-emerald-500'
                          : item.difficulty === 2
                            ? 'bg-amber-500'
                            : 'bg-red-500'
                      }
                    />
                  </div>
                );
              })}
            </div>
          </div>
        </div>

        <div className="bg-gray-900 border border-gray-800 rounded-xl">
          <div className="p-6 border-b border-gray-800">
            <h2 className="text-sm font-semibold text-white">
              Chapter Progress Overview
            </h2>
            <p className="text-xs text-gray-500 mt-1">
              User engagement per chapter
            </p>
          </div>
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead>
                <tr className="border-b border-gray-800">
                  <th className="text-left px-6 py-3 text-xs font-semibold text-gray-400 uppercase tracking-wider">
                    Chapter
                  </th>
                  <th className="text-left px-6 py-3 text-xs font-semibold text-gray-400 uppercase tracking-wider">
                    Terms
                  </th>
                  <th className="text-left px-6 py-3 text-xs font-semibold text-gray-400 uppercase tracking-wider">
                    Users Started
                  </th>
                  <th className="text-left px-6 py-3 text-xs font-semibold text-gray-400 uppercase tracking-wider">
                    Users Completed
                  </th>
                  <th className="text-left px-6 py-3 text-xs font-semibold text-gray-400 uppercase tracking-wider">
                    Avg Terms Mastered
                  </th>
                  <th className="text-left px-6 py-3 text-xs font-semibold text-gray-400 uppercase tracking-wider w-48">
                    Engagement
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-800/50">
                {chapterStats.map((ch) => (
                  <tr key={ch.chapter_id} className="hover:bg-gray-800/20">
                    <td className="px-6 py-3">
                      <div className="flex items-center gap-2">
                        <span className="text-xs text-gray-500 font-mono w-6">
                          {ch.chapter_id.toString().padStart(2, '0')}
                        </span>
                        <span className="text-sm text-gray-200 truncate max-w-[200px]">
                          {ch.title}
                        </span>
                      </div>
                    </td>
                    <td className="px-6 py-3 text-sm text-gray-400">
                      {ch.term_count}
                    </td>
                    <td className="px-6 py-3 text-sm text-gray-300">
                      {ch.users_started}
                    </td>
                    <td className="px-6 py-3 text-sm text-gray-300">
                      {ch.users_completed}
                    </td>
                    <td className="px-6 py-3 text-sm text-gray-300">
                      {ch.avg_terms_mastered}
                    </td>
                    <td className="px-6 py-3">
                      <BarChart
                        value={ch.users_started}
                        max={maxUsersStarted}
                        color="bg-teal-500"
                      />
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </AdminLayout>
  );
}
