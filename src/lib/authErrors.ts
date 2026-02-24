const ERROR_MAP: Array<{ pattern: RegExp; message: string }> = [
  {
    pattern: /email rate limit exceeded/i,
    message: 'メール送信の上限に達しました。しばらく時間をおいてから再度お試しください。',
  },
  {
    pattern: /invalid login credentials/i,
    message: 'メールアドレスまたはパスワードが正しくありません。',
  },
  {
    pattern: /user already registered/i,
    message: 'このメールアドレスは既に登録されています。',
  },
  {
    pattern: /password should be at least/i,
    message: 'パスワードは6文字以上で入力してください。',
  },
  {
    pattern: /unable to validate email address/i,
    message: 'メールアドレスの形式が正しくありません。',
  },
  {
    pattern: /signup requires a valid password/i,
    message: '有効なパスワードを入力してください。',
  },
  {
    pattern: /email not confirmed/i,
    message: 'メールアドレスが確認されていません。メールをご確認ください。',
  },
  {
    pattern: /for security purposes.*request this after (\d+) seconds/i,
    message: 'セキュリティのため、しばらくお待ちいただいてから再度お試しください。',
  },
  {
    pattern: /over_(email|sms)_send_rate_limit/i,
    message: 'メール送信の上限に達しました。しばらく時間をおいてから再度お試しください。',
  },
  {
    pattern: /error sending recovery email/i,
    message: 'リカバリーメールの送信に失敗しました。しばらく時間をおいてから再度お試しください。',
  },
];

export function translateAuthError(message: string): string {
  for (const { pattern, message: translated } of ERROR_MAP) {
    if (pattern.test(message)) {
      return translated;
    }
  }
  return message;
}

export function isRateLimitError(message: string): boolean {
  return /rate limit/i.test(message) || /over_(email|sms)_send_rate_limit/i.test(message);
}
