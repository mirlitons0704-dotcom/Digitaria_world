import { useState, useEffect, useRef, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { AuthForm } from '../components/AuthForm';
import { ASSETS, TOTAL_TERMS } from '../lib/constants';
import { LogOut, User, Sparkles } from 'lucide-react';

export function LandingPage() {
  const navigate = useNavigate();
  const { user, profile, loading, signOut } = useAuth();
  const [authMode, setAuthMode] = useState<'login' | 'register'>('login');
  const [showAuthModal, setShowAuthModal] = useState(false);
  const [videoReady, setVideoReady] = useState(false);
  const modalRef = useRef<HTMLDivElement>(null);
  const triggerRef = useRef<HTMLElement | null>(null);

  const closeModal = useCallback(() => {
    setShowAuthModal(false);
    requestAnimationFrame(() => triggerRef.current?.focus());
  }, []);

  useEffect(() => {
    if (!showAuthModal || !modalRef.current) return;

    const modal = modalRef.current;

    // Focus the first input when modal opens
    requestAnimationFrame(() => {
      const firstInput = modal.querySelector('input');
      if (firstInput) (firstInput as HTMLElement).focus();
    });

    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        closeModal();
        return;
      }
      if (e.key !== 'Tab') return;
      const focusable = modal.querySelectorAll<HTMLElement>(
        'button, input, select, textarea, [href], [tabindex]:not([tabindex="-1"])'
      );
      if (focusable.length === 0) return;
      const first = focusable[0];
      const last = focusable[focusable.length - 1];
      if (e.shiftKey && document.activeElement === first) {
        e.preventDefault();
        last.focus();
      } else if (!e.shiftKey && document.activeElement === last) {
        e.preventDefault();
        first.focus();
      }
    };

    document.addEventListener('keydown', handleKeyDown);
    return () => document.removeEventListener('keydown', handleKeyDown);
  }, [showAuthModal, closeModal]);

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-slate-300 via-gray-200 to-slate-400 flex items-center justify-center">
        <div className="animate-pulse text-gray-600 font-display">Loading...</div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-300 via-gray-200 to-slate-400 relative overflow-hidden">
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_top,_rgba(255,255,255,0.4)_0%,_transparent_50%)]" />
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_bottom_right,_rgba(180,180,180,0.3)_0%,_transparent_50%)]" />

      <nav className="relative flex justify-end p-4">
        {user ? (
          <div className="flex items-center gap-3">
            <div className="flex items-center gap-2 px-4 py-2 rounded-full bg-white/50 backdrop-blur-sm font-display">
              <User size={16} className="text-gray-600" />
              <span className="text-gray-700 text-sm font-medium">
                {profile?.username || user.email}
              </span>
            </div>
            <button
              onClick={() => signOut()}
              className="flex items-center gap-2 px-4 py-2 rounded-full text-sm font-medium text-gray-300 hover:text-white transition-all duration-300 bg-gray-700"
              style={{
                boxShadow: 'inset 0 2px 4px rgba(0,0,0,0.3), 0 1px 2px rgba(255,255,255,0.1)',
              }}
            >
              <LogOut size={16} />
              <span>Logout</span>
            </button>
          </div>
        ) : (
          <div
            className="flex rounded-full p-1 bg-gray-700"
            style={{
              boxShadow: 'inset 0 2px 4px rgba(0,0,0,0.3), 0 1px 2px rgba(255,255,255,0.1)',
            }}
          >
            <button
              onClick={(e) => {
                triggerRef.current = e.currentTarget;
                setAuthMode('login');
                setShowAuthModal(true);
              }}
              className={`px-5 py-2 rounded-full text-sm font-medium transition-all duration-300 ${
                authMode === 'login' && showAuthModal
                  ? 'bg-gray-100 text-gray-800 shadow-md'
                  : 'text-gray-300 hover:text-white'
              }`}
            >
              Login
            </button>
            <button
              onClick={(e) => {
                triggerRef.current = e.currentTarget;
                setAuthMode('register');
                setShowAuthModal(true);
              }}
              className={`px-5 py-2 rounded-full text-sm font-medium transition-all duration-300 ${
                authMode === 'register' && showAuthModal
                  ? 'bg-gray-100 text-gray-800 shadow-md'
                  : 'text-gray-300 hover:text-white'
              }`}
            >
              Register
            </button>
          </div>
        )}
      </nav>

      <header className="relative flex flex-col items-center pb-6">
        <h1
          className="text-4xl md:text-5xl lg:text-6xl tracking-wider font-display font-bold text-gray-800"
          style={{
            textShadow: `
              1px 1px 0 #BFCFFF,
              2px 2px 0 #BFCFFF,
              3px 3px 0 #BFCFFF,
              4px 4px 0 #BFCFFF,
              5px 5px 0 #BFCFFF,
              6px 6px 10px rgba(0,0,0,0.15)
            `,
          }}
        >
          DIGITALIA
        </h1>
        <div className="w-48 h-px bg-gradient-to-r from-transparent via-gray-500 to-transparent mt-3 mb-4" />
        <p
          className="tracking-wide text-center px-4"
          style={{ color: '#605c5c', fontFamily: '"Titillium Web", sans-serif', fontWeight: 300 }}
        >
          The code journey through {TOTAL_TERMS} programming terms
        </p>
      </header>

      <main className="relative flex flex-col items-center px-4 pb-12">
        <div
          className={`mt-4 inline-block p-1.5 rounded-xl transition-opacity duration-500 ${videoReady ? 'opacity-100' : 'opacity-0'}`}
          style={{
            background: 'linear-gradient(135deg, #BFCFFF 0%, #8BA3E6 50%, #BFCFFF 100%)',
            boxShadow: `
              0 0 0 1px rgba(255,255,255,0.5),
              inset 0 1px 0 rgba(255,255,255,0.6),
              4px 4px 12px rgba(0,0,0,0.15),
              8px 8px 24px rgba(143,163,230,0.3)
            `,
          }}
        >
          <div
            className="p-0.5 rounded-lg"
            style={{
              background:
                'linear-gradient(180deg, rgba(255,255,255,0.8) 0%, rgba(191,207,255,0.4) 100%)',
            }}
          >
            <video
              className="block max-h-[50vh] w-auto rounded-lg"
              style={{ boxShadow: 'inset 0 0 0 1px rgba(0,0,0,0.1)' }}
              src={ASSETS.landingVideo}
              autoPlay
              loop
              muted
              playsInline
              preload="auto"
              onLoadedMetadata={() => setVideoReady(true)}
            />
          </div>
        </div>

        {user ? (
          <button
            onClick={() => navigate('/home')}
            className="gradient-btn mt-8 group min-w-[200px] px-9 py-4 rounded-[11px] font-bold text-lg shadow-lg hover:shadow-2xl transition-all duration-300 hover:-translate-y-0.5"
            style={{
              fontFamily: '"Titillium Web", sans-serif',
              boxShadow: '0 4px 20px rgba(37,99,235,0.35), 0 1px 3px rgba(0,0,0,0.1)',
            }}
          >
            <span className="relative z-10 flex items-center gap-3">
              <Sparkles size={20} className="group-hover:animate-pulse" />
              Start Your Journey
              <Sparkles size={20} className="group-hover:animate-pulse" />
            </span>
          </button>
        ) : (
          <p
            className="mt-8 text-gray-500 text-lg"
            style={{ fontFamily: '"Titillium Web", sans-serif', fontWeight: 600 }}
          >
            Sign in to start your adventure
          </p>
        )}
      </main>

      <footer className="relative py-6 border-t border-gray-400/30">
        <p className="text-center text-gray-500 text-sm font-display">
          &copy; 2026 DIGITALIA. All rights reserved.
        </p>
      </footer>

      {showAuthModal && !user && (
        <div
          className="fixed inset-0 z-50 flex items-center justify-center p-4"
          role="dialog"
          aria-modal="true"
          aria-label={authMode === 'login' ? 'ログイン' : 'アカウント作成'}
          onClick={(e) => {
            if (e.target === e.currentTarget) closeModal();
          }}
        >
          <div className="absolute inset-0 bg-black/40 backdrop-blur-sm" aria-hidden="true" />
          <div
            ref={modalRef}
            className="relative bg-white/95 backdrop-blur-md rounded-2xl p-8 w-full max-w-md shadow-2xl"
            style={{
              boxShadow: '0 25px 50px -12px rgba(0,0,0,0.25), 0 0 0 1px rgba(255,255,255,0.5)',
            }}
          >
            <button
              onClick={closeModal}
              className="absolute top-4 right-4 text-gray-400 hover:text-gray-600 transition-colors"
              aria-label="閉じる"
            >
              <svg
                xmlns="http://www.w3.org/2000/svg"
                width="24"
                height="24"
                viewBox="0 0 24 24"
                fill="none"
                stroke="currentColor"
                strokeWidth="2"
                strokeLinecap="round"
                strokeLinejoin="round"
              >
                <line x1="18" y1="6" x2="6" y2="18"></line>
                <line x1="6" y1="6" x2="18" y2="18"></line>
              </svg>
            </button>

            <div className="flex justify-center mb-6">
              <div
                className="flex rounded-full p-1 bg-gray-700"
                style={{ boxShadow: 'inset 0 2px 4px rgba(0,0,0,0.3)' }}
              >
                <button
                  onClick={() => setAuthMode('login')}
                  className={`px-5 py-2 rounded-full text-sm font-medium transition-all duration-300 ${
                    authMode === 'login'
                      ? 'bg-gray-100 text-gray-800 shadow-md'
                      : 'text-gray-300 hover:text-white'
                  }`}
                >
                  Login
                </button>
                <button
                  onClick={() => setAuthMode('register')}
                  className={`px-5 py-2 rounded-full text-sm font-medium transition-all duration-300 ${
                    authMode === 'register'
                      ? 'bg-gray-100 text-gray-800 shadow-md'
                      : 'text-gray-300 hover:text-white'
                  }`}
                >
                  Register
                </button>
              </div>
            </div>

            <h2 className="text-2xl font-semibold text-gray-800 text-center mb-6 font-display">
              {authMode === 'login' ? 'Welcome Back' : 'Create Account'}
            </h2>

            <AuthForm mode={authMode} onSuccess={closeModal} />
          </div>
        </div>
      )}
    </div>
  );
}
