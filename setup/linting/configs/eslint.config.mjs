import { createConfigForNuxt } from '@nuxt/eslint-config/flat'
import { join } from 'node:path'
import { fileURLToPath } from 'node:url'

const rootDir = fileURLToPath(new URL('../../..', import.meta.url))

export default createConfigForNuxt({
  features: {
    standalone: false,
    tooling: true,
    vue: true,
    stylistic: 'prettier'
  },
  typescript: {
    strict: false,
    tsconfigPath: join(rootDir, 'tsconfig.json')
  },
  overrides: {
    nuxt: {
      'nuxt/prefer-import-meta': 'error',
      'nuxt/no-env-in-hooks': 'warn'
    },
    vue: {
      'vue/multi-word-component-names': 'off',
      'vue/component-tags-order': ['error', {
        order: ['script', 'template', 'style']
      }]
    },
    typescript: {
      '@typescript-eslint/no-explicit-any': 'warn',
      '@typescript-eslint/no-unused-vars': ['error', {
        argsIgnorePattern: '^_',
        varsIgnorePattern: '^_'
      }]
    }
  }
})
