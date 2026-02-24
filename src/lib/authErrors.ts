import i18n from '../i18n';

const ERROR_MAP: Array<{ pattern: RegExp; key: string }> = [
  { pattern: /email rate limit exceeded/i, key: 'authErrors.emailRateLimit' },
  { pattern: /invalid login credentials/i, key: 'authErrors.invalidCredentials' },
  { pattern: /user already registered/i, key: 'authErrors.userAlreadyRegistered' },
  { pattern: /password should be at least/i, key: 'authErrors.passwordTooShort' },
  { pattern: /unable to validate email address/i, key: 'authErrors.invalidEmail' },
  { pattern: /signup requires a valid password/i, key: 'authErrors.invalidPassword' },
  { pattern: /email not confirmed/i, key: 'authErrors.emailNotConfirmed' },
  {
    pattern: /for security purposes.*request this after (\d+) seconds/i,
    key: 'authErrors.securityWait',
  },
  { pattern: /over_(email|sms)_send_rate_limit/i, key: 'authErrors.sendRateLimit' },
  { pattern: /error sending recovery email/i, key: 'authErrors.recoveryEmailFailed' },
];

export function translateAuthError(message: string): string {
  for (const { pattern, key } of ERROR_MAP) {
    if (pattern.test(message)) {
      return i18n.t(key);
    }
  }
  return message;
}

export function isRateLimitError(message: string): boolean {
  return /rate limit/i.test(message) || /over_(email|sms)_send_rate_limit/i.test(message);
}
