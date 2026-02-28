import { useNavigate } from 'react-router-dom';
import { ArrowLeft } from 'lucide-react';

export function TermsPage() {
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

        <h1 className="text-3xl font-bold text-gray-800 mb-8">利用規約 / Terms of Service</h1>

        <div className="prose prose-gray max-w-none space-y-6 text-gray-600 text-sm leading-relaxed">
          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">1. サービスの概要</h2>
            <p>
              DIGITALIA（以下「本サービス」）は、プログラミング用語の学習を目的とした
              Webアプリケーションです。本サービスは教育目的で提供されており、
              利用者は本規約に同意の上ご利用ください。
            </p>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">2. アカウント</h2>
            <p>
              本サービスの利用にはアカウント登録が必要です。
              登録されたメールアドレスとパスワードの管理は利用者の責任となります。
              不正利用が発覚した場合、アカウントを停止する場合があります。
            </p>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">3. 禁止事項</h2>
            <ul className="list-disc pl-5 space-y-1">
              <li>本サービスの不正利用やシステムへの攻撃</li>
              <li>他のユーザーへの迷惑行為</li>
              <li>コンテンツの無断転載・複製</li>
              <li>法令に違反する行為</li>
            </ul>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">4. 免責事項</h2>
            <p>
              本サービスは「現状のまま」で提供されます。
              コンテンツの正確性や完全性について保証するものではありません。
              本サービスの利用により生じた損害について、運営者は責任を負いません。
            </p>
          </section>

          <section>
            <h2 className="text-lg font-semibold text-gray-800 mb-2">5. 規約の変更</h2>
            <p>
              本規約は予告なく変更される場合があります。
              変更後の規約は本ページに掲載された時点で効力を生じます。
            </p>
          </section>

          <p className="text-xs text-gray-400 mt-8">最終更新日: 2026年2月8日</p>
        </div>
      </div>
    </div>
  );
}
