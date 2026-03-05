import { describe, it, expect, vi, beforeEach } from 'vitest';
import { render, screen } from '../test/test-utils';
import { Layout } from './Layout';

vi.mock('../contexts/AuthContext', () => ({
  useAuth: vi.fn(() => ({
    user: { id: 'test-user', email: 'test@test.com' },
    profile: { username: 'tester' },
    loading: false,
    isAdmin: false,
    signOut: vi.fn(),
  })),
}));

vi.mock('../hooks/useOnlineStatus', () => ({
  useOnlineStatus: vi.fn(() => true),
}));

import { useAuth } from '../contexts/AuthContext';
import { useOnlineStatus } from '../hooks/useOnlineStatus';

const mockUseAuth = vi.mocked(useAuth);
const mockUseOnlineStatus = vi.mocked(useOnlineStatus);

describe('Layout', () => {
  beforeEach(() => {
    vi.clearAllMocks();
    mockUseOnlineStatus.mockReturnValue(true);
  });

  it('renders DIGITALIA branding', () => {
    render(
      <Layout>
        <div>Content</div>
      </Layout>
    );
    expect(screen.getByText('DIGITALIA')).toBeInTheDocument();
  });

  it('renders children content', () => {
    render(
      <Layout>
        <div>Test Content</div>
      </Layout>
    );
    expect(screen.getByText('Test Content')).toBeInTheDocument();
  });

  it('renders navigation items', () => {
    render(
      <Layout>
        <div>Content</div>
      </Layout>
    );
    expect(screen.getAllByText('Home').length).toBeGreaterThan(0);
    expect(screen.getAllByText('My Folder').length).toBeGreaterThan(0);
    expect(screen.getAllByText('Search').length).toBeGreaterThan(0);
  });

  it('shows username when user is logged in', () => {
    render(
      <Layout>
        <div>Content</div>
      </Layout>
    );
    expect(screen.getByText('tester')).toBeInTheDocument();
  });

  it('shows Admin button when user is admin', () => {
    mockUseAuth.mockReturnValue({
      user: { id: 'admin-user', email: 'admin@test.com' } as any,
      profile: { id: 'admin-user', username: 'admin', email: 'admin@test.com', is_admin: true },
      session: null,
      loading: false,
      isAdmin: true,
      isRecovery: false,
      signUp: vi.fn(),
      signIn: vi.fn(),
      signOut: vi.fn(),
      resetPassword: vi.fn(),
      updatePassword: vi.fn(),
      clearRecovery: vi.fn(),
    });

    render(
      <Layout>
        <div>Content</div>
      </Layout>
    );
    expect(screen.getAllByText('Admin').length).toBeGreaterThan(0);
  });

  it('shows offline banner when network is down', () => {
    mockUseOnlineStatus.mockReturnValue(false);

    render(
      <Layout>
        <div>Content</div>
      </Layout>
    );
    expect(screen.getByText('You are offline. Some features may not work.')).toBeInTheDocument();
  });

  it('does not show offline banner when online', () => {
    mockUseOnlineStatus.mockReturnValue(true);

    render(
      <Layout>
        <div>Content</div>
      </Layout>
    );
    expect(
      screen.queryByText('You are offline. Some features may not work.')
    ).not.toBeInTheDocument();
  });

  it('renders footer links', () => {
    render(
      <Layout>
        <div>Content</div>
      </Layout>
    );
    expect(screen.getByText('利用規約')).toBeInTheDocument();
    expect(screen.getByText('プライバシーポリシー')).toBeInTheDocument();
  });
});
