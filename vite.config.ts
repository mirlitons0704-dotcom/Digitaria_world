import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';
import { execSync } from 'child_process';
import path from 'path';

function copyAssetsPlugin() {
  return {
    name: 'copy-assets',
    closeBundle() {
      const src = path.resolve(__dirname, 'assets');
      const dest = path.resolve(__dirname, 'dist');
      try {
        execSync(`cp -r "${src}/." "${dest}/"`);
      } catch {
        // ignore
      }
    },
  };
}

export default defineConfig({
  plugins: [react(), copyAssetsPlugin()],
  publicDir: 'assets',
  optimizeDeps: {
    exclude: ['lucide-react'],
  },
  build: {
    copyPublicDir: false,
  },
});
