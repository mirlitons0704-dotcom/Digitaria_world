import { ReactNode, useState } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import {
  LayoutDashboard,
  Users,
  BarChart3,
  Image,
  ArrowLeft,
  LogOut,
  Shield,
  Menu,
  X,
} from 'lucide-react';

const adminNavItems = [
  { path: '/admin', icon: LayoutDashboard, label: 'Dashboard' },
  { path: '/admin/users', icon: Users, label: 'Users' },
  { path: '/admin/analytics', icon: BarChart3, label: 'Analytics' },
  { path: '/admin/illustrations', icon: Image, label: 'Illustrations' },
];

function SidebarContent({ onNavigate }: { onNavigate: (path: string) => void }) {
  const location = useLocation();
  const { profile, signOut } = useAuth();

  return (
    <>
      <div className="p-6 border-b border-gray-800">
        <div className="flex items-center gap-3">
          <div className="w-9 h-9 rounded-lg bg-teal-500/10 flex items-center justify-center">
            <Shield size={18} className="text-teal-400" />
          </div>
          <div>
            <h1 className="text-sm font-semibold text-white tracking-wide">DIGITARIA</h1>
            <p className="text-xs text-gray-400">Admin Panel</p>
          </div>
        </div>
      </div>

      <nav className="flex-1 p-4 space-y-1">
        {adminNavItems.map(({ path, icon: Icon, label }) => {
          const isActive =
            path === '/admin' ? location.pathname === '/admin' : location.pathname.startsWith(path);

          return (
            <button
              key={path}
              onClick={() => onNavigate(path)}
              className={`w-full flex items-center gap-3 px-4 py-2.5 rounded-lg text-sm transition-all ${
                isActive
                  ? 'bg-teal-500/10 text-teal-400'
                  : 'text-gray-400 hover:bg-gray-800 hover:text-gray-200'
              }`}
            >
              <Icon size={18} />
              <span className="font-medium">{label}</span>
            </button>
          );
        })}
      </nav>

      <div className="p-4 border-t border-gray-800 space-y-2">
        <button
          onClick={() => onNavigate('/home')}
          className="w-full flex items-center gap-3 px-4 py-2.5 rounded-lg text-sm text-gray-400 hover:bg-gray-800 hover:text-gray-200 transition-all"
        >
          <ArrowLeft size={18} />
          <span className="font-medium">Back to App</span>
        </button>

        <div className="flex items-center justify-between px-4 py-2">
          <span className="text-xs text-gray-400 truncate max-w-[140px]">{profile?.username}</span>
          <button
            onClick={() => signOut()}
            className="p-1.5 text-gray-400 hover:text-gray-300 transition-colors"
            title="Sign out"
            aria-label="サインアウト"
          >
            <LogOut size={14} />
          </button>
        </div>
      </div>
    </>
  );
}

export function AdminLayout({ children }: { children: ReactNode }) {
  const navigate = useNavigate();
  const [drawerOpen, setDrawerOpen] = useState(false);

  const handleNavigate = (path: string) => {
    navigate(path);
    setDrawerOpen(false);
  };

  return (
    <div className="min-h-screen bg-gray-950 md:flex">
      {/* Desktop sidebar */}
      <aside
        className="hidden md:flex w-64 bg-gray-900 border-r border-gray-800 flex-shrink-0 flex-col"
        aria-label="Admin navigation"
      >
        <SidebarContent onNavigate={handleNavigate} />
      </aside>

      {/* Mobile header */}
      <div className="md:hidden flex items-center justify-between px-4 py-3 bg-gray-900 border-b border-gray-800">
        <div className="flex items-center gap-2">
          <Shield size={16} className="text-teal-400" />
          <span className="text-sm font-semibold text-white">Admin</span>
        </div>
        <button
          onClick={() => setDrawerOpen(true)}
          className="p-2 text-gray-400 hover:text-gray-200 transition-colors"
          aria-label="メニューを開く"
        >
          <Menu size={22} />
        </button>
      </div>

      {/* Mobile drawer overlay */}
      {drawerOpen && (
        <div className="fixed inset-0 z-50 md:hidden">
          <div
            className="absolute inset-0 bg-black/60"
            onClick={() => setDrawerOpen(false)}
            aria-hidden="true"
          />
          <aside
            className="absolute left-0 top-0 bottom-0 w-64 bg-gray-900 flex flex-col shadow-2xl"
            aria-label="Admin navigation"
          >
            <div className="flex justify-end p-2">
              <button
                onClick={() => setDrawerOpen(false)}
                className="p-2 text-gray-400 hover:text-gray-200 transition-colors"
                aria-label="メニューを閉じる"
              >
                <X size={20} />
              </button>
            </div>
            <SidebarContent onNavigate={handleNavigate} />
          </aside>
        </div>
      )}

      <main className="flex-1 overflow-auto">
        <div className="max-w-7xl mx-auto p-4 md:p-8">{children}</div>
      </main>
    </div>
  );
}
