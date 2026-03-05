import { lazy, Suspense } from 'react';
import { BrowserRouter, Routes, Route, Navigate } from 'react-router-dom';
import { useAuth } from './contexts/AuthContext';
import { Loader2 } from 'lucide-react';

// Lazy-loaded pages
const LandingPage = lazy(() =>
  import('./pages/LandingPage').then((m) => ({ default: m.LandingPage }))
);
const HomePage = lazy(() => import('./pages/HomePage').then((m) => ({ default: m.HomePage })));
const ChapterPage = lazy(() =>
  import('./pages/ChapterPage').then((m) => ({ default: m.ChapterPage }))
);
const TermListPage = lazy(() =>
  import('./pages/TermListPage').then((m) => ({ default: m.TermListPage }))
);
const MyFolderPage = lazy(() =>
  import('./pages/MyFolderPage').then((m) => ({ default: m.MyFolderPage }))
);
const SearchPage = lazy(() =>
  import('./pages/SearchPage').then((m) => ({ default: m.SearchPage }))
);
const TermsPage = lazy(() => import('./pages/TermsPage').then((m) => ({ default: m.TermsPage })));
const PrivacyPage = lazy(() =>
  import('./pages/PrivacyPage').then((m) => ({ default: m.PrivacyPage }))
);
const ResetPasswordPage = lazy(() =>
  import('./pages/ResetPasswordPage').then((m) => ({ default: m.ResetPasswordPage }))
);
const AdminDashboardPage = lazy(() =>
  import('./pages/admin/AdminDashboardPage').then((m) => ({ default: m.AdminDashboardPage }))
);
const AdminUsersPage = lazy(() =>
  import('./pages/admin/AdminUsersPage').then((m) => ({ default: m.AdminUsersPage }))
);
const AdminUserDetailPage = lazy(() =>
  import('./pages/admin/AdminUserDetailPage').then((m) => ({ default: m.AdminUserDetailPage }))
);
const AdminAnalyticsPage = lazy(() =>
  import('./pages/admin/AdminAnalyticsPage').then((m) => ({ default: m.AdminAnalyticsPage }))
);
const AdminIllustrationsPage = lazy(() =>
  import('./pages/admin/AdminIllustrationsPage').then((m) => ({
    default: m.AdminIllustrationsPage,
  }))
);
const AdminStoryEditorPage = lazy(() =>
  import('./pages/admin/AdminStoryEditorPage').then((m) => ({
    default: m.AdminStoryEditorPage,
  }))
);

function RecoveryRedirect({ children }: { children: React.ReactNode }) {
  const { isRecovery, loading } = useAuth();

  if (!loading && isRecovery) {
    return <Navigate to="/reset-password" replace />;
  }

  return <>{children}</>;
}

function ProtectedRoute({ children }: { children: React.ReactNode }) {
  const { user, loading } = useAuth();

  if (loading) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-slate-300 via-gray-200 to-slate-400 flex items-center justify-center">
        <div className="animate-pulse text-gray-600">Loading...</div>
      </div>
    );
  }

  if (!user) {
    return <Navigate to="/" replace />;
  }

  return <>{children}</>;
}

function AdminRoute({ children }: { children: React.ReactNode }) {
  const { user, isAdmin, loading } = useAuth();

  if (loading) {
    return (
      <div className="min-h-screen bg-gray-950 flex items-center justify-center">
        <div className="animate-pulse text-gray-400">Loading...</div>
      </div>
    );
  }

  if (!user) {
    return <Navigate to="/" replace />;
  }

  if (!isAdmin) {
    return <Navigate to="/home" replace />;
  }

  return <>{children}</>;
}

function SuspenseFallback() {
  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-300 via-gray-200 to-slate-400 flex items-center justify-center">
      <Loader2 className="w-8 h-8 animate-spin text-teal-500" />
    </div>
  );
}

function App() {
  return (
    <BrowserRouter>
      <Suspense fallback={<SuspenseFallback />}>
        <Routes>
          <Route
            path="/"
            element={
              <RecoveryRedirect>
                <LandingPage />
              </RecoveryRedirect>
            }
          />
          <Route path="/reset-password" element={<ResetPasswordPage />} />
          <Route
            path="/home"
            element={
              <ProtectedRoute>
                <HomePage />
              </ProtectedRoute>
            }
          />
          <Route
            path="/chapter/:id"
            element={
              <ProtectedRoute>
                <ChapterPage />
              </ProtectedRoute>
            }
          />
          <Route
            path="/chapter/:id/terms"
            element={
              <ProtectedRoute>
                <TermListPage />
              </ProtectedRoute>
            }
          />
          <Route
            path="/my-folder"
            element={
              <ProtectedRoute>
                <MyFolderPage />
              </ProtectedRoute>
            }
          />
          <Route
            path="/search"
            element={
              <ProtectedRoute>
                <SearchPage />
              </ProtectedRoute>
            }
          />

          <Route
            path="/admin"
            element={
              <AdminRoute>
                <AdminDashboardPage />
              </AdminRoute>
            }
          />
          <Route
            path="/admin/users"
            element={
              <AdminRoute>
                <AdminUsersPage />
              </AdminRoute>
            }
          />
          <Route
            path="/admin/users/:userId"
            element={
              <AdminRoute>
                <AdminUserDetailPage />
              </AdminRoute>
            }
          />
          <Route
            path="/admin/analytics"
            element={
              <AdminRoute>
                <AdminAnalyticsPage />
              </AdminRoute>
            }
          />
          <Route
            path="/admin/illustrations"
            element={
              <AdminRoute>
                <AdminIllustrationsPage />
              </AdminRoute>
            }
          />
          <Route
            path="/admin/stories"
            element={
              <AdminRoute>
                <AdminStoryEditorPage />
              </AdminRoute>
            }
          />

          <Route path="/terms" element={<TermsPage />} />
          <Route path="/privacy" element={<PrivacyPage />} />

          <Route path="*" element={<Navigate to="/" replace />} />
        </Routes>
      </Suspense>
    </BrowserRouter>
  );
}

export default App;
