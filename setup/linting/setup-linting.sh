#!/bin/bash
# setup/linting/setup-linting.sh

# Проверка ОС
OS="$(uname -s)"
echo "🔍 Обнаружена ОС: $OS"

CONFIG_DIR="$(dirname "$(realpath "$0")")/configs"
mkdir -p "$CONFIG_DIR"

# 1. Установка Homebrew (если нужно) и jq для macOS
if [[ "$OS" == "Darwin" ]]; then
  if ! command -v brew &> /dev/null; then
    echo "🛠  Установка Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  if ! command -v jq &> /dev/null; then
    echo "🛠  Установка jq..."
    brew install jq
  fi
fi

# 2. Установка зависимостей через yarn
echo "📦 Устанавливаем зависимости..."
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

# 3. Создаем ESLint конфиг
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

# 4. Создаем Prettier конфиг
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

# 5. Настройка Husky
echo "🐶 Настраиваем Husky..."
yarn dlx husky-init --yarn2 && yarn
mkdir -p "../../.husky"

cat > "../../.husky/pre-commit" << 'EOL'
#!/bin/sh
. "$(dirname "$0")/_/husky.sh"

echo "🔍 Running lint-staged..."
npx lint-staged
EOL

# Установка прав для macOS/Linux
chmod +x "../../.husky/pre-commit"

# 6. Настройка lint-staged
cat > "../../.lintstagedrc" << 'EOL'
{
  "*.{js,ts,vue}": ["eslint --fix", "prettier --write"],
  "*.{json,md}": ["prettier --write"]
}
EOL

# 7. Добавляем скрипты в package.json
echo "📦 Обновляем package.json..."

# Для macOS используем встроенный plutil или jq
if [[ "$OS" == "Darwin" ]]; then
  if command -v jq &> /dev/null; then
    echo "🛠  Используем jq для обновления package.json..."
    jq '.scripts += {
      "lint": "eslint .",
      "lint:fix": "eslint . --fix",
      "format": "prettier --write .",
      "prepare": "husky install",
      "husky-logs": "cat .husky/husky.log"
    }' package.json > temp.json && mv temp.json package.json
  else
    echo "⚠️  Используем встроенные инструменты macOS..."
    # Альтернатива через node, если jq нет
    node <<EOF
    const fs = require('fs');
    const pkg = JSON.parse(fs.readFileSync('package.json'));
    pkg.scripts = {
      ...pkg.scripts,
      lint: "eslint .",
      "lint:fix": "eslint . --fix",
      format: "prettier --write .",
      prepare: "husky install",
      "husky-logs": "cat .husky/husky.log"
    };
    fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2) + '\n');
EOF
  fi
else
  # Для других ОС используем jq или ручное добавление
  if command -v jq &> /dev/null; then
    jq '.scripts += {
      "lint": "eslint .",
      "lint:fix": "eslint . --fix",
      "format": "prettier --write .",
      "prepare": "husky install",
      "husky-logs": "cat .husky/husky.log"
    }' package.json > temp.json && mv temp.json package.json
  else
    echo "⚠️  Добавьте вручную в секцию scripts package.json:"
    echo '{'
    echo '  "lint": "eslint .",'
    echo '  "lint:fix": "eslint . --fix",'
    echo '  "format": "prettier --write .",'
    echo '  "prepare": "husky install",'
    echo '  "husky-logs": "cat .husky/husky.log"'
    echo '}'
  fi
fi

# 8. Устанавливаем Husky hooks
echo "⚙️ Активируем git hooks..."
yarn prepare

# 9. Создаем документацию
cat > "../../.husky/README.md" << 'EOL'
# Husky на macOS

## Проверка установки
1. Убедитесь, что хуки исполняются:
```bash
ls -la .husky/