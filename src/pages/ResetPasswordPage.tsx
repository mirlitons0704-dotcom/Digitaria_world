import { useState, useRef, useEffect, useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { Lock, Loader2, AlertCircle, CheckCircle2, Eye, EyeOff, Clock } from 'lucide-react';
import { translateAuthError, isRateLimitError } from '../lib/authErrors';

export function ResetPasswordPage() {
  const navigate = useNavigate();
  const { user, loading, updatePassword, clearRecovery } = useAuth();
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [success, setSuccess] = useState(false);
  const [cooldown, setCooldown] = useState(0);
  const cooldownRef = useRef<ReturnType<typeof setInterval> | null>(null);

  useEffect(() => {
    return () => {
      if (cooldownRef.current) clearInterval(cooldownRef.current);
    };
  }, []);

  const startCooldown = useCallback((seconds: number) => {
    if (cooldownRef.current) clearInterval(cooldownRef.current);
    setCooldown(seconds);
    cooldownRef.current = setInterval(() => {
      setCooldown((prev) => {
        if (prev <= 1) {
          if (cooldownRef.current) clearInterval(cooldownRef.current);
          cooldownRef.current = null;
          return 0;
        }
        return prev - 1;
      });
    }, 1000);
  }, []);

  useEffect(() => {
    if (!loading && !user) {
      navigate('/', { replace: true });
    }
  }, [loading, user, navigate]);

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (cooldown > 0) return;
    setError(null);

    if (newPassword.length < 6) {
      setError('パスワードは6文字以上で入力してください。');
      return;
    }

    if (newPassword !== confirmPassword) {
      setError('パスワードが一致しません。');
      return;
    }

    setSubmitting(true);
    try {
      const { error } = await updatePassword(newPassword);
      if (error) {
        const translated = translateAuthError(error.message);
        setError(translated);
        if (isRateLimitError(error.message)) {
          startCooldown(60);
        }
      } else {
        setSuccess(true);
      }
    } catch {
      setError('予期しないエラーが発生しました。');
    } finally {
      setSubmitting(false);
    }
  }

  function handleGoHome() {
    clearRecovery();
    navigate('/home', { replace: true });
  }

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-slate-300 via-gray-200 to-slate-400 flex items-center justify-center">
        <div className="animate-pulse text-gray-600 font-display">Loading...</div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-300 via-gray-200 to-slate-400 relative overflow-hidden flex items-center justify-center px-4">
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_top,_rgba(255,255,255,0.4)_0%,_transparent_50%)]" />
      <div className="absolute inset-0 bg-[radial-gradient(ellipse_at_bottom_right,_rgba(180,180,180,0.3)_0%,_transparent_50%)]" />

      <div
        className="relative bg-white/95 backdrop-blur-md rounded-2xl p-8 w-full max-w-md"
        style={{
          boxShadow: '0 25px 50px -12px rgba(0,0,0,0.25), 0 0 0 1px rgba(255,255,255,0.5)',
        }}
      >
        <h1
          className="text-2xl font-bold text-gray-800 text-center mb-2 font-display tracking-wide"
          style={{
            textShadow: '1px 1px 0 #BFCFFF, 2px 2px 0 #BFCFFF',
          }}
        >
          DIGITARIA
        </h1>
        <div className="w-24 h-px bg-gradient-to-r from-transparent via-gray-400 to-transparent mx-auto mb-6" />

        {success ? (
          <div className="space-y-6">
            <div className="flex items-center gap-3 p-4 rounded-lg bg-emerald-50 border border-emerald-200 text-emerald-700">
              <CheckCircle2 size={20} className="shrink-0" />
              <span className="text-sm">パスワードが正常に変更されました。</span>
            </div>
            <button
              onClick={handleGoHome}
              className="w-full py-2.5 px-4 rounded-lg font-medium text-white transition-all duration-300 flex items-center justify-center"
              style={{
                fontFamily: '"Raleway", sans-serif',
                backgroundColor: '#374151',
                boxShadow: '0 2px 8px rgba(0,0,0,0.2)',
              }}
            >
              ホームに戻る
            </button>
          </div>
        ) : (
          <>
            <h2
              className="text-lg font-semibold text-gray-700 text-center mb-6"
              style={{ fontFamily: '"Titillium Web", sans-serif' }}
            >
              新しいパスワードを設定
            </h2>

            <form onSubmit={handleSubmit} className="space-y-4">
              {error && (
                <div
                  role="alert"
                  className="flex items-center gap-2 p-3 rounded-lg bg-red-50 border border-red-200 text-red-700 text-sm"
                >
                  <AlertCircle size={16} className="shrink-0" />
                  <span>{error}</span>
                </div>
              )}

              <div className="space-y-1">
                <label
                  htmlFor="new-password"
                  className="block text-sm font-medium text-gray-700"
                  style={{ fontFamily: '"Raleway", sans-serif' }}
                >
                  新しいパスワード
                </label>
                <div className="relative">
                  <Lock
                    className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"
                    size={18}
                  />
                  <input
                    id="new-password"
                    type={showPassword ? 'text' : 'password'}
                    value={newPassword}
                    onChange={(e) => setNewPassword(e.target.value)}
                    required
                    minLength={6}
                    className="w-full pl-10 pr-12 py-2.5 rounded-lg border border-gray-300 bg-white/80 backdrop-blur-sm focus:border-gray-500 focus:ring-2 focus:ring-gray-200 outline-none transition-all"
                    style={{ fontFamily: '"Raleway", sans-serif' }}
                    placeholder="6文字以上"
                    autoFocus
                  />
                  <button
                    type="button"
                    onClick={() => setShowPassword(!showPassword)}
                    className="absolute right-3 top-1/2 -translate-y-1/2 text-gray-400 hover:text-gray-600 transition-colors"
                    aria-label={showPassword ? 'パスワードを隠す' : 'パスワードを表示'}
                  >
                    {showPassword ? <EyeOff size={18} /> : <Eye size={18} />}
                  </button>
                </div>
              </div>

              <div className="space-y-1">
                <label
                  htmlFor="confirm-password"
                  className="block text-sm font-medium text-gray-700"
                  style={{ fontFamily: '"Raleway", sans-serif' }}
                >
                  パスワードの確認
                </label>
                <div className="relative">
                  <Lock
                    className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400"
                    size={18}
                  />
                  <input
                    id="confirm-password"
                    type={showPassword ? 'text' : 'password'}
                    value={confirmPassword}
                    onChange={(e) => setConfirmPassword(e.target.value)}
                    required
                    minLength={6}
                    className="w-full pl-10 pr-4 py-2.5 rounded-lg border border-gray-300 bg-white/80 backdrop-blur-sm focus:border-gray-500 focus:ring-2 focus:ring-gray-200 outline-none transition-all"
                    style={{ fontFamily: '"Raleway", sans-serif' }}
                    placeholder="もう一度入力"
                  />
                </div>
              </div>

              <button
                type="submit"
                disabled={submitting || cooldown > 0}
                className="w-full py-2.5 px-4 rounded-lg font-medium text-white transition-all duration-300 disabled:opacity-50 disabled:cursor-not-allowed flex items-center justify-center gap-2"
                style={{
                  fontFamily: '"Raleway", sans-serif',
                  backgroundColor: '#374151',
                  boxShadow: '0 2px 8px rgba(0,0,0,0.2)',
                }}
              >
                {cooldown > 0 ? (
                  <>
                    <Clock size={18} />
                    <span>{cooldown}秒後に再試行できます</span>
                  </>
                ) : submitting ? (
                  <>
                    <Loader2 className="animate-spin" size={18} />
                    <span>変更中...</span>
                  </>
                ) : (
                  <span>パスワードを変更</span>
                )}
              </button>
            </form>
          </>
        )}
      </div>
    </div>
  );
}
