import { useEffect, useState } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import { AdminLayout } from '../../components/AdminLayout';
import { getAdminUserDetail, type UserDetail } from '../../lib/adminApi';
import {
  Loader2,
  ArrowLeft,
  Mail,
  Calendar,
  BookOpen,
  Trophy,
  Bug,
  Clock,
  Shield,
} from 'lucide-react';

function DetailItem({
  icon: Icon,
  label,
  value,
}: {
  icon: React.ElementType;
  label: string;
  value: string | number;
}) {
  return (
    <div className="flex items-start gap-3 p-4 bg-gray-800/30 rounded-lg">
      <div className="w-8 h-8 rounded-lg bg-gray-800 flex items-center justify-center flex-shrink-0">
        <Icon size={16} className="text-gray-400" />
      </div>
      <div>
        <p className="text-xs text-gray-500 mb-0.5">{label}</p>
        <p className="text-sm font-medium text-gray-200">{value}</p>
      </div>
    </div>
  );
}

export function AdminUserDetailPage() {
  const { userId } = useParams<{ userId: string }>();
  const navigate = useNavigate();
  const [user, setUser] = useState<UserDetail | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    if (!userId) return;
    async function loadUser() {
      try {
        const data = await getAdminUserDetail(userId!);
        setUser(data);
      } catch (err) {
        console.error('Failed to load user detail:', err);
      } finally {
        setLoading(false);
      }
    }
    loadUser();
  }, [userId]);

  if (loading) {
    return (
      <AdminLayout>
        <div className="flex items-center justify-center min-h-[60vh]">
          <Loader2 className="w-8 h-8 animate-spin text-teal-400" />
        </div>
      </AdminLayout>
    );
  }

  if (!user) {
    return (
      <AdminLayout>
        <div className="text-center py-20">
          <p className="text-gray-500 mb-4">User not found</p>
          <button
            onClick={() => navigate('/admin/users')}
            className="text-sm text-teal-400 hover:text-teal-300 transition-colors"
          >
            Back to Users
          </button>
        </div>
      </AdminLayout>
    );
  }

  const progressPercent =
    user.terms_mastered > 0
      ? Math.round((user.terms_mastered / 520) * 100)
      : 0;

  return (
    <AdminLayout>
      <div className="space-y-6">
        <button
          onClick={() => navigate('/admin/users')}
          className="flex items-center gap-2 text-sm text-gray-400 hover:text-gray-200 transition-colors"
        >
          <ArrowLeft size={16} />
          Back to Users
        </button>

        <div className="bg-gray-900 border border-gray-800 rounded-xl p-6">
          <div className="flex items-start justify-between mb-6">
            <div>
              <div className="flex items-center gap-3 mb-2">
                <h1 className="text-xl font-semibold text-white">
                  {user.display_name || user.username}
                </h1>
                {user.is_admin && (
                  <span className="inline-flex items-center gap-1.5 px-2.5 py-1 bg-teal-500/10 text-teal-400 text-xs font-medium rounded-full">
                    <Shield size={12} />
                    Admin
                  </span>
                )}
              </div>
              <p className="text-sm text-gray-500">@{user.username}</p>
            </div>
          </div>

          <div className="mb-6">
            <div className="flex items-center justify-between mb-2">
              <span className="text-xs text-gray-500">
                Overall Progress
              </span>
              <span className="text-xs font-medium text-teal-400">
                {user.terms_mastered} / 520 terms ({progressPercent}%)
              </span>
            </div>
            <div className="w-full h-2 bg-gray-800 rounded-full overflow-hidden">
              <div
                className="h-full bg-gradient-to-r from-teal-500 to-emerald-400 rounded-full transition-all duration-500"
                style={{ width: `${progressPercent}%` }}
              />
            </div>
          </div>

          <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-3">
            <DetailItem
              icon={Mail}
              label="Email"
              value={user.email}
            />
            <DetailItem
              icon={Calendar}
              label="Joined"
              value={new Date(user.created_at).toLocaleDateString('ja-JP', {
                year: 'numeric',
                month: 'long',
                day: 'numeric',
              })}
            />
            <DetailItem
              icon={BookOpen}
              label="Current Chapter"
              value={`Chapter ${user.current_chapter}`}
            />
            <DetailItem
              icon={Bug}
              label="Butterflies Collected"
              value={user.total_butterflies}
            />
            <DetailItem
              icon={Trophy}
              label="Chapters Completed"
              value={`${user.chapters_completed} / 17`}
            />
            <DetailItem
              icon={Trophy}
              label="Quizzes Taken"
              value={user.quiz_count}
            />
            <DetailItem
              icon={Clock}
              label="Last Activity"
              value={
                user.last_activity
                  ? new Date(user.last_activity).toLocaleDateString('ja-JP', {
                      year: 'numeric',
                      month: 'short',
                      day: 'numeric',
                      hour: '2-digit',
                      minute: '2-digit',
                    })
                  : 'No activity yet'
              }
            />
          </div>
        </div>
      </div>
    </AdminLayout>
  );
}
