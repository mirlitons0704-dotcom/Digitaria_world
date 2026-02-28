import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminLayout } from '../../components/AdminLayout';
import {
  getAnalyticsOverview,
  getRecentSignups,
  getTopLearners,
  type AnalyticsOverview,
} from '../../lib/adminApi';
import { Users, Bug, Trophy, TrendingUp, Loader2, ChevronRight } from 'lucide-react';

function StatCard({
  label,
  value,
  icon: Icon,
  color,
}: {
  label: string;
  value: string | number;
  icon: React.ElementType;
  color: string;
}) {
  const colorMap: Record<string, { bg: string; text: string; border: string }> = {
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
  const c = colorMap[color] || colorMap.teal;

  return (
    <div
      className={`bg-gray-900 border ${c.border} rounded-xl p-6 transition-all hover:border-opacity-50`}
    >
      <div className="flex items-center justify-between mb-4">
        <div className={`w-10 h-10 rounded-lg ${c.bg} flex items-center justify-center`}>
          <Icon size={20} className={c.text} />
        </div>
      </div>
      <p className="text-2xl font-semibold text-white mb-1">{value}</p>
      <p className="text-sm text-gray-400">{label}</p>
    </div>
  );
}

export function AdminDashboardPage() {
  const navigate = useNavigate();
  const [overview, setOverview] = useState<AnalyticsOverview | null>(null);
  const [recentUsers, setRecentUsers] = useState<
    { id: string; username: string; email: string; created_at: string }[]
  >([]);
  const [topLearners, setTopLearners] = useState<
    { id: string; display_name: string | null; total_butterflies: number }[]
  >([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    async function loadData() {
      try {
        const [overviewData, recent, top] = await Promise.all([
          getAnalyticsOverview(),
          getRecentSignups(5),
          getTopLearners(5),
        ]);
        setOverview(overviewData);
        setRecentUsers(recent);
        setTopLearners(top);
      } catch (err) {
        console.error('Failed to load admin dashboard:', err);
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

  return (
    <AdminLayout>
      <div className="space-y-8">
        <div>
          <h1 className="text-2xl font-semibold text-white mb-1">Dashboard</h1>
          <p className="text-sm text-gray-400">DIGITALIA overview and key metrics</p>
        </div>

        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-4">
          <StatCard
            label="Total Users"
            value={overview?.totalUsers ?? 0}
            icon={Users}
            color="teal"
          />
          <StatCard
            label="Terms Mastered"
            value={overview?.totalTermsMastered ?? 0}
            icon={Bug}
            color="amber"
          />
          <StatCard
            label="Quizzes Taken"
            value={overview?.totalQuizzesTaken ?? 0}
            icon={Trophy}
            color="blue"
          />
          <StatCard
            label="Avg Butterflies"
            value={overview?.averageButterflies ?? 0}
            icon={TrendingUp}
            color="emerald"
          />
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <div className="bg-gray-900 border border-gray-800 rounded-xl">
            <div className="flex items-center justify-between p-6 border-b border-gray-800">
              <h2 className="text-sm font-semibold text-white">Recent Signups</h2>
              <button
                onClick={() => navigate('/admin/users')}
                className="flex items-center gap-1 text-xs text-teal-400 hover:text-teal-300 transition-colors"
              >
                View all <ChevronRight size={14} />
              </button>
            </div>
            <div className="divide-y divide-gray-800">
              {recentUsers.length === 0 ? (
                <p className="p-6 text-sm text-gray-400">No users yet</p>
              ) : (
                recentUsers.map((user) => (
                  <div
                    key={user.id}
                    className="flex items-center justify-between px-6 py-4 hover:bg-gray-800/50 transition-colors cursor-pointer"
                    onClick={() => navigate(`/admin/users/${user.id}`)}
                  >
                    <div>
                      <p className="text-sm font-medium text-gray-200">{user.username}</p>
                      <p className="text-xs text-gray-400">{user.email}</p>
                    </div>
                    <span className="text-xs text-gray-600">
                      {new Date(user.created_at).toLocaleDateString('ja-JP')}
                    </span>
                  </div>
                ))
              )}
            </div>
          </div>

          <div className="bg-gray-900 border border-gray-800 rounded-xl">
            <div className="p-6 border-b border-gray-800">
              <h2 className="text-sm font-semibold text-white">Top Learners</h2>
            </div>
            <div className="divide-y divide-gray-800">
              {topLearners.length === 0 ? (
                <p className="p-6 text-sm text-gray-400">No learners yet</p>
              ) : (
                topLearners.map((learner, index) => (
                  <div key={learner.id} className="flex items-center justify-between px-6 py-4">
                    <div className="flex items-center gap-3">
                      <span
                        className={`w-6 h-6 rounded-full flex items-center justify-center text-xs font-bold ${
                          index === 0
                            ? 'bg-amber-500/20 text-amber-400'
                            : index === 1
                              ? 'bg-gray-400/20 text-gray-300'
                              : index === 2
                                ? 'bg-orange-500/20 text-orange-400'
                                : 'bg-gray-800 text-gray-400'
                        }`}
                      >
                        {index + 1}
                      </span>
                      <p className="text-sm text-gray-200">{learner.display_name || 'Traveler'}</p>
                    </div>
                    <div className="flex items-center gap-1.5">
                      <span className="text-sm font-semibold text-teal-400">
                        {learner.total_butterflies}
                      </span>
                      <span className="text-xs text-gray-400">butterflies</span>
                    </div>
                  </div>
                ))
              )}
            </div>
          </div>
        </div>
      </div>
    </AdminLayout>
  );
}
