import { ReactNode } from 'react';
import { useNavigate, useLocation } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { Home, Folder, Search, LogOut, User } from 'lucide-react';

interface LayoutProps {
  children: ReactNode;
}

export function Layout({ children }: LayoutProps) {
  const navigate = useNavigate();
  const location = useLocation();
  const { user, profile, signOut } = useAuth();

  const navItems = [
    { path: '/home', icon: Home, label: 'Home' },
    { path: '/my-folder', icon: Folder, label: 'My Folder' },
    { path: '/search', icon: Search, label: 'Search' },
  ];

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-200 via-gray-100 to-slate-200">
      <nav className="sticky top-0 z-40 bg-white/80 backdrop-blur-md border-b border-gray-200/50">
        <div className="max-w-7xl mx-auto px-4">
          <div className="flex items-center justify-between h-16">
            <button
              onClick={() => navigate('/')}
              className="font-display font-bold text-xl text-gray-800 hover:text-teal-600 transition-colors"
            >
              DIGITARIA
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
                  <div className="hidden sm:flex items-center gap-2 px-3 py-1.5 rounded-full bg-gray-100">
                    <User size={14} className="text-gray-500" />
                    <span className="text-sm text-gray-600">
                      {profile?.username || 'Traveler'}
                    </span>
                  </div>
                  <button
                    onClick={() => signOut()}
                    className="p-2 text-gray-500 hover:text-gray-700 hover:bg-gray-100 rounded-lg transition-colors"
                    title="Sign out"
                  >
                    <LogOut size={18} />
                  </button>
                </>
              )}
            </div>
          </div>
        </div>

        <div className="md:hidden flex items-center justify-around py-2 border-t border-gray-100">
          {navItems.map(({ path, icon: Icon, label }) => (
            <button
              key={path}
              onClick={() => navigate(path)}
              className={`flex flex-col items-center gap-1 px-4 py-1 rounded-lg transition-all ${
                location.pathname === path
                  ? 'text-teal-600'
                  : 'text-gray-500'
              }`}
            >
              <Icon size={20} />
              <span className="text-xs">{label}</span>
            </button>
          ))}
        </div>
      </nav>

      <main className="pb-8">
        {children}
      </main>
    </div>
  );
}
