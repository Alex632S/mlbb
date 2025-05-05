#!/bin/bash
# setup/linting/setup-linting.sh

CONFIG_DIR="$(dirname "$(realpath "$0")")/configs"
mkdir -p "$CONFIG_DIR"

# 1. Установка зависимостей через yarn
echo "📦 Устанавливаем зависимости через yarn..."
yarn add --dev \
  @nuxt/eslint-config \
  @nuxt/eslint \
  @typescript-eslint/eslint-plugin \
  @typescript-eslint/parser \
  eslint-plugin-vue \
  eslint-config-prettier \
  eslint-plugin-prettier \
  prettier \
  husky \
  lint-staged

# 2. Создаем ESLint конфиг
cat > "$CONFIG_DIR/eslint.config.mjs" << 'EOL'
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
EOL

# 3. Создаем Prettier конфиг
cat > "$CONFIG_DIR/.prettierrc" << 'EOL'
{
  "printWidth": 100,
  "tabWidth": 2,
  "useTabs": false,
  "semi": true,
  "singleQuote": true,
  "trailingComma": "all",
  "bracketSpacing": true,
  "arrowParens": "always",
  "endOfLine": "auto"
}
EOL

# 4. Настройка Husky для yarn
echo "🐶 Настраиваем Husky..."
yarn dlx husky-init --yarn2 && yarn
mkdir -p "../../.husky"

# Создаем pre-commit хук с вашим содержимым
cat > "../../.husky/pre-commit" << 'EOL'
#!/bin/sh
. "$(dirname "$0")/_/husky.sh"

echo "🔍 Running lint-staged..."
npx lint-staged
EOL

# Даем права на выполнение
chmod +x "../../.husky/pre-commit"

# 5. Настройка lint-staged
cat > "../../.lintstagedrc" << 'EOL'
{
  "*.{js,ts,vue}": ["eslint --fix", "prettier --write"],
  "*.{json,md}": ["prettier --write"]
}
EOL

# 6. Добавляем скрипты в package.json
echo "📦 Обновляем package.json..."
yarn pkg set scripts.lint="eslint ."
yarn pkg set scripts."lint:fix"="eslint . --fix"
yarn pkg set scripts.format="prettier --write ."
yarn pkg set scripts.prepare="husky install"

# 7. Устанавливаем Husky hooks
echo "⚙️ Активируем git hooks..."
yarn prepare

echo "✅ Настройка линтинга завершена!"
echo "Структура проекта:"
echo "  ├── setup/linting/configs/  - конфиги ESLint и Prettier"
echo "  ├── .husky/                - git hooks"
echo "  └── tsconfig.json          - основной TS конфиг"
echo ""
echo "Команды:"
echo "  yarn lint     - проверка кода"
echo "  yarn lint:fix - автоматическое исправление ошибок"
echo "  yarn format   - форматирование кода"