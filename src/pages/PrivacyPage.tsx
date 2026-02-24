import { useNavigate } from 'react-router-dom';
import { ArrowLeft } from 'lucide-react';

export function PrivacyPage() {
  const navigate = useNavigate();

  return (
    <div className="min-h-screen bg-gradient-to-br from-slate-200 via-gray-100 to-slate-200">
      <div className="max-w-3xl mx-auto px-4 py-12">
        <button
          onClick={() => navigate(-1)}
          className="flex items-center gap-2 text-gray-500 hover:text-gray-700 mb-8 transition-colors"
        >
          <ArrowLeft size={18} />
          <span className="text-sm">Back</span>
        </button>

        <h1 className="text-3xl font-bold text-gray-800 mb-8">
          プライバシーポリシー / Privacy Policy
        </h1>

        <div className="prose prose-gray max-w-none space-y-6 text-gray-600 text-sm leading-relaxed">
          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">1. 収集する情報</h2>
            <p>本サービスでは、以下の情報を収集します：</p>
            <ul className="list-disc pl-5 space-y-1">
              <li>メールアドレス（アカウント認証のため）</li>
              <li>ユーザー名（表示名として使用）</li>
              <li>学習進捗データ（用語の習得状況、クイズ結果）</li>
            </ul>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">2. 情報の利用目的</h2>
            <p>収集した情報は以下の目的で利用します：</p>
            <ul className="list-disc pl-5 space-y-1">
              <li>アカウントの認証と管理</li>
              <li>学習進捗の記録と表示</li>
              <li>サービスの改善</li>
            </ul>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">3. 情報の管理</h2>
            <p>
              ユーザー情報はSupabaseのセキュアなデータベースに保存され、 Row Level Security (RLS)
              により他のユーザーからアクセスできないよう
              保護されています。パスワードはハッシュ化して保存されます。
            </p>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">4. 第三者への提供</h2>
            <p>法令に基づく場合を除き、ユーザーの個人情報を第三者に提供することはありません。</p>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">5. Cookieの使用</h2>
            <p>
              本サービスは認証セッション管理のためにブラウザのローカルストレージを使用します。
              トラッキング目的のCookieは使用しません。
            </p>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">6. お問い合わせ</h2>
            <p>プライバシーに関するご質問は、サービス管理者までお問い合わせください。</p>
          </section>

          <p className="text-xs text-gray-400 mt-8">最終更新日: 2026年2月8日</p>
        </div>
      </div>
    </div>
  );
}
