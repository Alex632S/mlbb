import { defineConfig } from "vite";
import { fileURLToPath, URL } from "url";
import vue from "@vitejs/plugin-vue";
import tsconfigPaths from "vite-tsconfig-paths";
import { quasar, transformAssetUrls } from "@quasar/vite-plugin";

// https://vitejs.dev/config/

export default defineConfig({
  resolve: {
    alias: {
      // @ts-ignore
      "@": fileURLToPath(new URL("./src", import.meta.url)), // Alias for src folder
    },
  },
  css: {
    preprocessorOptions: {
      scss: {
        additionalData: `
          @import "./assets/fonts.scss";
        `
      }
    }
  },
  plugins: [
    vue({
      template: { transformAssetUrls },
    }),
    tsconfigPaths(),

    // @quasar/plugin-vite options list:
    // https://github.com/quasarframework/quasar/blob/dev/vite-plugin/index.d.ts
    quasar({
      sassVariables: fileURLToPath(
        // @ts-ignore
        new URL("./src/quasar-variables.sass", import.meta.url),
      ),
    }),
  ],
});
