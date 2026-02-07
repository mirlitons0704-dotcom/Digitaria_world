import { useEffect, useState, useMemo } from 'react';
import { useNavigate } from 'react-router-dom';
import { AdminLayout } from '../../components/AdminLayout';
import { getAdminUsers, type AdminUser } from '../../lib/adminApi';
import {
  Loader2,
  Search,
  ChevronUp,
  ChevronDown,
  Shield,
  ArrowUpDown,
} from 'lucide-react';

type SortField = 'username' | 'created_at' | 'total_butterflies' | 'current_chapter';
type SortDirection = 'asc' | 'desc';

export function AdminUsersPage() {
  const navigate = useNavigate();
  const [users, setUsers] = useState<AdminUser[]>([]);
  const [loading, setLoading] = useState(true);
  const [searchQuery, setSearchQuery] = useState('');
  const [sortField, setSortField] = useState<SortField>('created_at');
  const [sortDirection, setSortDirection] = useState<SortDirection>('desc');

  useEffect(() => {
    async function loadUsers() {
      try {
        const data = await getAdminUsers();
        setUsers(data);
      } catch (err) {
        console.error('Failed to load users:', err);
      } finally {
        setLoading(false);
      }
    }
    loadUsers();
  }, []);

  const filteredAndSorted = useMemo(() => {
    let result = users;

    if (searchQuery.trim()) {
      const q = searchQuery.toLowerCase();
      result = result.filter(
        (u) =>
          u.username.toLowerCase().includes(q) ||
          u.email.toLowerCase().includes(q),
      );
    }

    result.sort((a, b) => {
      let comparison = 0;
      switch (sortField) {
        case 'username':
          comparison = a.username.localeCompare(b.username);
          break;
        case 'created_at':
          comparison =
            new Date(a.created_at).getTime() -
            new Date(b.created_at).getTime();
          break;
        case 'total_butterflies':
          comparison = a.total_butterflies - b.total_butterflies;
          break;
        case 'current_chapter':
          comparison = a.current_chapter - b.current_chapter;
          break;
      }
      return sortDirection === 'asc' ? comparison : -comparison;
    });

    return result;
  }, [users, searchQuery, sortField, sortDirection]);

  function handleSort(field: SortField) {
    if (sortField === field) {
      setSortDirection((d) => (d === 'asc' ? 'desc' : 'asc'));
    } else {
      setSortField(field);
      setSortDirection('desc');
    }
  }

  function SortIcon({ field }: { field: SortField }) {
    if (sortField !== field) {
      return <ArrowUpDown size={14} className="text-gray-600" />;
    }
    return sortDirection === 'asc' ? (
      <ChevronUp size={14} className="text-teal-400" />
    ) : (
      <ChevronDown size={14} className="text-teal-400" />
    );
  }

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
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div>
            <h1 className="text-2xl font-semibold text-white mb-1">Users</h1>
            <p className="text-sm text-gray-500">
              {users.length} registered users
            </p>
          </div>
        </div>

        <div className="relative">
          <Search
            size={18}
            className="absolute left-4 top-1/2 -translate-y-1/2 text-gray-500"
          />
          <input
            type="text"
            placeholder="Search by username or email..."
            value={searchQuery}
            onChange={(e) => setSearchQuery(e.target.value)}
            className="w-full pl-11 pr-4 py-3 bg-gray-900 border border-gray-800 rounded-xl text-sm text-gray-200 placeholder-gray-600 focus:outline-none focus:border-teal-500/50 transition-colors"
          />
        </div>

        <div className="bg-gray-900 border border-gray-800 rounded-xl overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead>
                <tr className="border-b border-gray-800">
                  <th className="text-left px-6 py-4">
                    <button
                      onClick={() => handleSort('username')}
                      className="flex items-center gap-2 text-xs font-semibold text-gray-400 uppercase tracking-wider hover:text-gray-200 transition-colors"
                    >
                      User <SortIcon field="username" />
                    </button>
                  </th>
                  <th className="text-left px-6 py-4">
                    <span className="text-xs font-semibold text-gray-400 uppercase tracking-wider">
                      Role
                    </span>
                  </th>
                  <th className="text-left px-6 py-4">
                    <button
                      onClick={() => handleSort('total_butterflies')}
                      className="flex items-center gap-2 text-xs font-semibold text-gray-400 uppercase tracking-wider hover:text-gray-200 transition-colors"
                    >
                      Butterflies <SortIcon field="total_butterflies" />
                    </button>
                  </th>
                  <th className="text-left px-6 py-4">
                    <button
                      onClick={() => handleSort('current_chapter')}
                      className="flex items-center gap-2 text-xs font-semibold text-gray-400 uppercase tracking-wider hover:text-gray-200 transition-colors"
                    >
                      Chapter <SortIcon field="current_chapter" />
                    </button>
                  </th>
                  <th className="text-left px-6 py-4">
                    <button
                      onClick={() => handleSort('created_at')}
                      className="flex items-center gap-2 text-xs font-semibold text-gray-400 uppercase tracking-wider hover:text-gray-200 transition-colors"
                    >
                      Joined <SortIcon field="created_at" />
                    </button>
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-800/50">
                {filteredAndSorted.length === 0 ? (
                  <tr>
                    <td
                      colSpan={5}
                      className="px-6 py-12 text-center text-sm text-gray-500"
                    >
                      {searchQuery
                        ? 'No users match your search'
                        : 'No users found'}
                    </td>
                  </tr>
                ) : (
                  filteredAndSorted.map((user) => (
                    <tr
                      key={user.id}
                      className="hover:bg-gray-800/30 transition-colors cursor-pointer"
                      onClick={() => navigate(`/admin/users/${user.id}`)}
                    >
                      <td className="px-6 py-4">
                        <div>
                          <p className="text-sm font-medium text-gray-200">
                            {user.username}
                          </p>
                          <p className="text-xs text-gray-500">{user.email}</p>
                        </div>
                      </td>
                      <td className="px-6 py-4">
                        {user.is_admin ? (
                          <span className="inline-flex items-center gap-1.5 px-2.5 py-1 bg-teal-500/10 text-teal-400 text-xs font-medium rounded-full">
                            <Shield size={12} />
                            Admin
                          </span>
                        ) : (
                          <span className="text-xs text-gray-500">User</span>
                        )}
                      </td>
                      <td className="px-6 py-4">
                        <span className="text-sm text-gray-300">
                          {user.total_butterflies}
                        </span>
                      </td>
                      <td className="px-6 py-4">
                        <span className="text-sm text-gray-300">
                          Ch. {user.current_chapter}
                        </span>
                      </td>
                      <td className="px-6 py-4">
                        <span className="text-sm text-gray-400">
                          {new Date(user.created_at).toLocaleDateString(
                            'ja-JP',
                          )}
                        </span>
                      </td>
                    </tr>
                  ))
                )}
              </tbody>
            </table>
          </div>
        </div>
      </div>
    </AdminLayout>
  );
}
