import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, fireEvent, waitFor } from '../test/test-utils';
import { AuthForm } from './AuthForm';

// Mock AuthContext
const mockSignIn = vi.fn();
const mockSignUp = vi.fn();
const mockResetPassword = vi.fn();

vi.mock('../contexts/AuthContext', () => ({
  useAuth: () => ({
    signIn: mockSignIn,
    signUp: mockSignUp,
    resetPassword: mockResetPassword,
  }),
}));

vi.mock('../lib/supabase', () => ({
  supabase: {},
}));

describe('AuthForm', () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  describe('login mode', () => {
    it('renders email and password fields', () => {
      render(<AuthForm mode="login" />);

      expect(screen.getByLabelText('Email')).toBeInTheDocument();
      expect(screen.getByLabelText('Password')).toBeInTheDocument();
    });

    it('renders Sign In button', () => {
      render(<AuthForm mode="login" />);

      expect(screen.getByRole('button', { name: 'Sign In' })).toBeInTheDocument();
    });

    it('does not render username field', () => {
      render(<AuthForm mode="login" />);

      expect(screen.queryByLabelText('Username')).not.toBeInTheDocument();
    });

    it('shows forgot password link', () => {
      render(<AuthForm mode="login" />);

      expect(screen.getByText('パスワードをお忘れですか？')).toBeInTheDocument();
    });

    it('calls signIn on form submit', async () => {
      mockSignIn.mockResolvedValue({ error: null });
      const onSuccess = vi.fn();
      render(<AuthForm mode="login" onSuccess={onSuccess} />);

      fireEvent.change(screen.getByLabelText('Email'), {
        target: { value: 'test@example.com' },
      });
      fireEvent.change(screen.getByLabelText('Password'), {
        target: { value: 'password123' },
      });
      fireEvent.click(screen.getByRole('button', { name: 'Sign In' }));

      await waitFor(() => {
        expect(mockSignIn).toHaveBeenCalledWith('test@example.com', 'password123');
      });
    });

    it('calls onSuccess after successful login', async () => {
      mockSignIn.mockResolvedValue({ error: null });
      const onSuccess = vi.fn();
      render(<AuthForm mode="login" onSuccess={onSuccess} />);

      fireEvent.change(screen.getByLabelText('Email'), {
        target: { value: 'test@example.com' },
      });
      fireEvent.change(screen.getByLabelText('Password'), {
        target: { value: 'password123' },
      });
      fireEvent.click(screen.getByRole('button', { name: 'Sign In' }));

      await waitFor(() => {
        expect(onSuccess).toHaveBeenCalled();
      });
    });

    it('displays error on failed login', async () => {
      mockSignIn.mockResolvedValue({ error: { message: 'Invalid login credentials' } });
      render(<AuthForm mode="login" />);

      fireEvent.change(screen.getByLabelText('Email'), {
        target: { value: 'test@example.com' },
      });
      fireEvent.change(screen.getByLabelText('Password'), {
        target: { value: 'wrongpass' },
      });
      fireEvent.click(screen.getByRole('button', { name: 'Sign In' }));

      await waitFor(() => {
        expect(screen.getByRole('alert')).toBeInTheDocument();
      });
    });
  });

  describe('register mode', () => {
    it('renders email, username, and password fields', () => {
      render(<AuthForm mode="register" />);

      expect(screen.getByLabelText('Email')).toBeInTheDocument();
      expect(screen.getByLabelText('Username')).toBeInTheDocument();
      expect(screen.getByLabelText('Password')).toBeInTheDocument();
    });

    it('renders Create Account button', () => {
      render(<AuthForm mode="register" />);

      expect(screen.getByRole('button', { name: 'Create Account' })).toBeInTheDocument();
    });

    it('shows error when username is whitespace only', async () => {
      render(<AuthForm mode="register" />);

      fireEvent.change(screen.getByLabelText('Email'), {
        target: { value: 'test@example.com' },
      });
      fireEvent.change(screen.getByLabelText('Username'), {
        target: { value: '   ' },
      });
      fireEvent.change(screen.getByLabelText('Password'), {
        target: { value: 'password123' },
      });
      fireEvent.click(screen.getByRole('button', { name: 'Create Account' }));

      await waitFor(() => {
        expect(screen.getByText('ユーザー名を入力してください。')).toBeInTheDocument();
      });
    });

    it('calls signUp with email, password, and username', async () => {
      mockSignUp.mockResolvedValue({ error: null });
      render(<AuthForm mode="register" />);

      fireEvent.change(screen.getByLabelText('Email'), {
        target: { value: 'new@example.com' },
      });
      fireEvent.change(screen.getByLabelText('Username'), {
        target: { value: 'testuser' },
      });
      fireEvent.change(screen.getByLabelText('Password'), {
        target: { value: 'password123' },
      });
      fireEvent.click(screen.getByRole('button', { name: 'Create Account' }));

      await waitFor(() => {
        expect(mockSignUp).toHaveBeenCalledWith('new@example.com', 'password123', 'testuser');
      });
    });

    it('does not show forgot password link', () => {
      render(<AuthForm mode="register" />);

      expect(screen.queryByText('パスワードをお忘れですか？')).not.toBeInTheDocument();
    });
  });

  describe('password reset', () => {
    it('toggles to reset form when clicking forgot password', () => {
      render(<AuthForm mode="login" />);

      fireEvent.click(screen.getByText('パスワードをお忘れですか？'));

      expect(screen.getByRole('button', { name: 'Send Reset Email' })).toBeInTheDocument();
      expect(screen.queryByLabelText('Password')).not.toBeInTheDocument();
    });

    it('shows success message after reset email sent', async () => {
      mockResetPassword.mockResolvedValue({ error: null });
      render(<AuthForm mode="login" />);

      fireEvent.click(screen.getByText('パスワードをお忘れですか？'));
      fireEvent.change(screen.getByLabelText('Email'), {
        target: { value: 'reset@example.com' },
      });
      fireEvent.click(screen.getByRole('button', { name: 'Send Reset Email' }));

      await waitFor(() => {
        expect(screen.getByText(/パスワードリセットのメールを送信しました/)).toBeInTheDocument();
      });
    });

    it('returns to login form from reset success', async () => {
      mockResetPassword.mockResolvedValue({ error: null });
      render(<AuthForm mode="login" />);

      fireEvent.click(screen.getByText('パスワードをお忘れですか？'));
      fireEvent.change(screen.getByLabelText('Email'), {
        target: { value: 'reset@example.com' },
      });
      fireEvent.click(screen.getByRole('button', { name: 'Send Reset Email' }));

      await waitFor(() => {
        expect(screen.getByText('ログイン画面に戻る')).toBeInTheDocument();
      });

      fireEvent.click(screen.getByText('ログイン画面に戻る'));

      expect(screen.getByRole('button', { name: 'Sign In' })).toBeInTheDocument();
    });
  });
});
