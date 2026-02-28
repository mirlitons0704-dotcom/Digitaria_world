import { ReactNode } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { useOnlineStatus } from '../hooks/useOnlineStatus';
import { Home, Folder, Search, LogOut, User, Shield, WifiOff } from 'lucide-react';

interface LayoutProps {
  children: ReactNode;
}

export function Layout({ children }: LayoutProps) {
  const navigate = useNavigate();
  const location = useLocation();
  const { user, profile, isAdmin, signOut } = useAuth();
  const isOnline = useOnlineStatus();

  const navItems = [
    { path: '/home', icon: Home, label: 'Home' },
    { path: '/my-folder', icon: Folder, label: 'My Folder' },
    { path: '/search', icon: Search, label: 'Search' },
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-200 via-gray-100 to-slate-200">
      <nav
        className="sticky top-0 z-40 bg-white/80 backdrop-blur-md border-b border-gray-200/50"
        aria-label="Main navigation"
      >
        <div className="max-w-7xl mx-auto px-4">
          <div className="flex items-center justify-between h-16">
            <button
              onClick={() => navigate('/')}
              className="font-display font-bold text-xl text-gray-800 hover:text-teal-600 transition-colors"
              aria-label="DIGITALIA ホームへ"
            >
              DIGITALIA
            </button>

            <div className="hidden md:flex items-center gap-1">
              {navItems.map(({ path, icon: Icon, label }) => (
                <button
                  key={path}
                  onClick={() => navigate(path)}
                  className={`flex items-center gap-2 px-4 py-2 rounded-lg transition-all ${
                    location.pathname === path
                      ? 'bg-teal-50 text-teal-600'
                      : 'text-gray-600 hover:bg-gray-100'
                  }`}
                >
                  <Icon size={18} />
                  <span className="text-sm font-medium">{label}</span>
                </button>
              ))}
            </div>

            <div className="flex items-center gap-3">
              {user && (
                <>
                  {isAdmin && (
                    <button
                      onClick={() => navigate('/admin')}
                      className="hidden sm:flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-gray-900 text-gray-100 hover:bg-gray-800 transition-colors text-xs font-medium"
                    >
                      <Shield size={14} />
                      Admin
                    </button>
                  )}
                  <div className="hidden sm:flex items-center gap-2 px-3 py-1.5 rounded-full bg-gray-100">
                    <User size={14} className="text-gray-500" />
                    <span className="text-sm text-gray-600">{profile?.username || 'Traveler'}</span>
                  </div>
                  <button
                    onClick={() => signOut()}
                    className="p-2 text-gray-500 hover:text-gray-700 hover:bg-gray-100 rounded-lg transition-colors"
                    title="Sign out"
                    aria-label="サインアウト"
                  >
                    <LogOut size={18} />
                  </button>
                </>
              )}
            </div>
          </div>
        </div>

        <div
          className="md:hidden flex items-center justify-around py-2 border-t border-gray-100"
          role="navigation"
          aria-label="Mobile navigation"
        >
          {navItems.map(({ path, icon: Icon, label }) => (
            <button
              key={path}
              onClick={() => navigate(path)}
              className={`flex flex-col items-center gap-1 px-4 py-1 rounded-lg transition-all ${
                location.pathname === path ? 'text-teal-600' : 'text-gray-500'
              }`}
            >
              <Icon size={20} />
              <span className="text-xs">{label}</span>
            </button>
          ))}
          {isAdmin && (
            <button
              onClick={() => navigate('/admin')}
              className="flex flex-col items-center gap-1 px-4 py-1 rounded-lg text-gray-500 transition-all"
            >
              <Shield size={20} />
              <span className="text-xs">Admin</span>
            </button>
          )}
        </div>
      </nav>

      {!isOnline && (
        <div className="bg-amber-500 text-white text-center py-2 px-4 text-sm flex items-center justify-center gap-2">
          <WifiOff size={16} />
          <span>You are offline. Some features may not work.</span>
        </div>
      )}

      <main className="pb-8" role="main">
        {children}
      </main>

      <footer className="border-t border-gray-200/50 py-4 text-center">
        <div className="flex items-center justify-center gap-4 text-xs text-gray-500">
          <button
            onClick={() => navigate('/terms')}
            className="hover:text-gray-600 transition-colors"
          >
            利用規約
          </button>
          <span>|</span>
          <button
            onClick={() => navigate('/privacy')}
            className="hover:text-gray-600 transition-colors"
          >
            プライバシーポリシー
          </button>
        </div>
      </footer>
    </div>
  );
}
