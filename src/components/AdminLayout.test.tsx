import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen, fireEvent } from '../test/test-utils';
import { AdminLayout } from './AdminLayout';

const mockNavigate = vi.fn();

vi.mock('react-router-dom', async () => {
  const actual = await vi.importActual('react-router-dom');
  return {
    ...actual,
    useNavigate: () => mockNavigate,
    useLocation: () => ({ pathname: '/admin' }),
  };
});

vi.mock('../contexts/AuthContext', () => ({
  useAuth: () => ({
    profile: { username: 'admin-user', is_admin: true },
    signOut: vi.fn(),
  }),
}));

vi.mock('../lib/supabase', () => ({
  supabase: {},
}));

describe('AdminLayout', () => {
  beforeEach(() => {
    mockNavigate.mockClear();
  });

  it('renders children content', () => {
    render(
      <AdminLayout>
        <div>Admin Content</div>
      </AdminLayout>
    );

    expect(screen.getByText('Admin Content')).toBeInTheDocument();
  });

  it('renders admin panel title', () => {
    render(
      <AdminLayout>
        <div>Content</div>
      </AdminLayout>
    );

    expect(screen.getAllByText('DIGITALIA').length).toBeGreaterThan(0);
    expect(screen.getAllByText('Admin Panel').length).toBeGreaterThan(0);
  });

  it('renders all navigation items in desktop sidebar', () => {
    render(
      <AdminLayout>
        <div>Content</div>
      </AdminLayout>
    );

    const dashboardButtons = screen.getAllByText('Dashboard');
    const usersButtons = screen.getAllByText('Users');
    const analyticsButtons = screen.getAllByText('Analytics');
    const illustrationsButtons = screen.getAllByText('Illustrations');
    const storiesButtons = screen.getAllByText('Stories');

    expect(dashboardButtons.length).toBeGreaterThan(0);
    expect(usersButtons.length).toBeGreaterThan(0);
    expect(analyticsButtons.length).toBeGreaterThan(0);
    expect(illustrationsButtons.length).toBeGreaterThan(0);
    expect(storiesButtons.length).toBeGreaterThan(0);
  });

  it('renders Back to App button', () => {
    render(
      <AdminLayout>
        <div>Content</div>
      </AdminLayout>
    );

    expect(screen.getAllByText('Back to App').length).toBeGreaterThan(0);
  });

  it('renders user profile name', () => {
    render(
      <AdminLayout>
        <div>Content</div>
      </AdminLayout>
    );

    expect(screen.getAllByText('admin-user').length).toBeGreaterThan(0);
  });

  it('navigates when clicking a nav item', () => {
    render(
      <AdminLayout>
        <div>Content</div>
      </AdminLayout>
    );

    // Click the first Users button (desktop sidebar)
    const usersButtons = screen.getAllByText('Users');
    fireEvent.click(usersButtons[0]);

    expect(mockNavigate).toHaveBeenCalledWith('/admin/users');
  });

  it('navigates to /home when clicking Back to App', () => {
    render(
      <AdminLayout>
        <div>Content</div>
      </AdminLayout>
    );

    const backButtons = screen.getAllByText('Back to App');
    fireEvent.click(backButtons[0]);

    expect(mockNavigate).toHaveBeenCalledWith('/home');
  });

  it('renders mobile menu button', () => {
    render(
      <AdminLayout>
        <div>Content</div>
      </AdminLayout>
    );

    expect(screen.getByLabelText('メニューを開く')).toBeInTheDocument();
  });

  it('opens mobile drawer when clicking menu button', () => {
    render(
      <AdminLayout>
        <div>Content</div>
      </AdminLayout>
    );

    fireEvent.click(screen.getByLabelText('メニューを開く'));

    expect(screen.getByLabelText('メニューを閉じる')).toBeInTheDocument();
  });

  it('closes mobile drawer when clicking close button', () => {
    render(
      <AdminLayout>
        <div>Content</div>
      </AdminLayout>
    );

    fireEvent.click(screen.getByLabelText('メニューを開く'));
    fireEvent.click(screen.getByLabelText('メニューを閉じる'));

    expect(screen.queryByLabelText('メニューを閉じる')).not.toBeInTheDocument();
  });

  it('renders sign out button', () => {
    render(
      <AdminLayout>
        <div>Content</div>
      </AdminLayout>
    );

    expect(screen.getAllByLabelText('サインアウト').length).toBeGreaterThan(0);
  });
});
