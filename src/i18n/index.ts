import i18n from 'i18next';
import { initReactI18next } from 'react-i18next';
import ja from './ja.json';
import en from './en.json';

const STORAGE_KEY = 'digitaria-lang';

i18n.use(initReactI18next).init({
  resources: { ja: { translation: ja }, en: { translation: en } },
  lng: localStorage.getItem(STORAGE_KEY) || 'ja',
  fallbackLng: 'ja',
  interpolation: { escapeValue: false },
});

/** Persist language choice to localStorage whenever it changes. */
i18n.on('languageChanged', (lng) => {
  localStorage.setItem(STORAGE_KEY, lng);
  document.documentElement.lang = lng;
});

// Set initial lang attribute
document.documentElement.lang = i18n.language;

export default i18n;
