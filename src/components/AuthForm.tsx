import { useState, useEffect, useRef, useCallback } from 'react';
import { useAuth } from '../contexts/AuthContext';
import { Mail, User, Lock, Loader2, AlertCircle, CheckCircle2, Clock } from 'lucide-react';
import { translateAuthError, isRateLimitError } from '../lib/authErrors';

interface AuthFormProps {
  mode: 'login' | 'register';
  onSuccess?: () => void;
}

export function AuthForm({ mode, onSuccess }: AuthFormProps) {
  const { signIn, signUp, resetPassword } = useAuth();
  const [email, setEmail] = useState('');
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [resetSent, setResetSent] = useState(false);
  const [showResetForm, setShowResetForm] = useState(false);
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

  function handleError(msg: string) {
    const translated = translateAuthError(msg);
    setError(translated);
    if (isRateLimitError(msg)) {
      startCooldown(60);
    }
  }

  async function handleSubmit(e: React.FormEvent) {
    e.preventDefault();
    if (cooldown > 0) return;
    setLoading(true);
    setError(null);

    try {
      if (showResetForm) {
        const { error } = await resetPassword(email);
        if (error) {
          handleError(error.message);
        } else {
          setResetSent(true);
        }
        return;
      }

      if (mode === 'register') {
        if (!username.trim()) {
          setError('ユーザー名を入力してください。');
          setLoading(false);
          return;
        }
        const { error } = await signUp(email, password, username);
        if (error) {
          handleError(error.message);
        } else {
          onSuccess?.();
        }
      } else {
        const { error } = await signIn(email, password);
        if (error) {
          handleError(error.message);
        } else {
          onSuccess?.();
        }
      }
    } catch (_err) {
      setError('予期しないエラーが発生しました。');
    } finally {
      setLoading(false);
    }
  }

  if (resetSent) {
    return (
      <div className="w-full max-w-sm space-y-4 text-center">
        <div className="flex items-center justify-center gap-2 p-4 rounded-lg bg-emerald-50 border border-emerald-200 text-emerald-700">
          <CheckCircle2 size={20} />
          <span className="text-sm">
            パスワードリセットのメールを送信しました。メールをご確認ください。
          </span>
        </div>
        <button
          onClick={() => {
            setResetSent(false);
            setShowResetForm(false);
            setError(null);
          }}
          className="text-sm text-gray-500 hover:text-gray-700 underline transition-colors"
        >
          ログイン画面に戻る
        </button>
      </div>
    );
  }

  return (
    <form onSubmit={handleSubmit} className="space-y-4 w-full max-w-sm">
      {error && (
        <div
          role="alert"
          className="flex items-center gap-2 p-3 rounded-lg bg-red-50 border border-red-200 text-red-700 text-sm"
        >
          <AlertCircle size={16} />
          <span>{error}</span>
        </div>
      )}

      <div className="space-y-1">
        <label
          htmlFor="email"
          className="block text-sm font-medium text-gray-700"
          style={{ fontFamily: '"Raleway", sans-serif' }}
        >
          Email
        </label>
        <div className="relative">
          <Mail className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" size={18} />
          <input
            id="email"
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            required
            className="w-full pl-10 pr-4 py-2.5 rounded-lg border border-gray-300 bg-white/80 backdrop-blur-sm focus:border-gray-500 focus:ring-2 focus:ring-gray-200 outline-none transition-all"
            style={{ fontFamily: '"Raleway", sans-serif' }}
            placeholder="your@email.com"
          />
        </div>
      </div>

      {!showResetForm && mode === 'register' && (
        <div className="space-y-1">
          <label
            htmlFor="username"
            className="block text-sm font-medium text-gray-700"
            style={{ fontFamily: '"Raleway", sans-serif' }}
          >
            Username
          </label>
          <div className="relative">
            <User className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" size={18} />
            <input
              id="username"
              type="text"
              value={username}
              onChange={(e) => setUsername(e.target.value)}
              required
              className="w-full pl-10 pr-4 py-2.5 rounded-lg border border-gray-300 bg-white/80 backdrop-blur-sm focus:border-gray-500 focus:ring-2 focus:ring-gray-200 outline-none transition-all"
              style={{ fontFamily: '"Raleway", sans-serif' }}
              placeholder="username"
            />
          </div>
        </div>
      )}

      {!showResetForm && (
        <div className="space-y-1">
          <label
            htmlFor="password"
            className="block text-sm font-medium text-gray-700"
            style={{ fontFamily: '"Raleway", sans-serif' }}
          >
            Password
          </label>
          <div className="relative">
            <Lock className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" size={18} />
            <input
              id="password"
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              required
              minLength={6}
              className="w-full pl-10 pr-4 py-2.5 rounded-lg border border-gray-300 bg-white/80 backdrop-blur-sm focus:border-gray-500 focus:ring-2 focus:ring-gray-200 outline-none transition-all"
              style={{ fontFamily: '"Raleway", sans-serif' }}
              placeholder="••••••••"
            />
          </div>
        </div>
      )}

      <button
        type="submit"
        disabled={loading || cooldown > 0}
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
        ) : loading ? (
          <>
            <Loader2 className="animate-spin" size={18} />
            <span>
              {showResetForm
                ? 'Sending...'
                : mode === 'register'
                  ? 'Creating account...'
                  : 'Signing in...'}
            </span>
          </>
        ) : (
          <span>
            {showResetForm
              ? 'Send Reset Email'
              : mode === 'register'
                ? 'Create Account'
                : 'Sign In'}
          </span>
        )}
      </button>

      {mode === 'login' && (
        <div className="text-center">
          <button
            type="button"
            onClick={() => {
              setShowResetForm(!showResetForm);
              setError(null);
            }}
            className="text-sm text-gray-500 hover:text-gray-700 underline transition-colors"
          >
            {showResetForm ? 'ログインに戻る' : 'パスワードをお忘れですか？'}
          </button>
        </div>
      )}
    </form>
  );
}
