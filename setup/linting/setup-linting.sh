#!/bin/bash
# setup/linting/setup-linting.sh

# --- Конфигурация ---
CONFIG_DIR="$(dirname "$(realpath "$0")")/configs"
HUSKY_DIR="../../.husky"
LOG_PREFIX="husky-"

# --- Функции ---
generate_log_filename() {
  # Получаем хеш текущего коммита (если есть)
  local commit_hash=$(git rev-parse --short HEAD 2>/dev/null || echo "pre-commit")
  echo "${HUSKY_DIR}/${LOG_PREFIX}${commit_hash}.log"
}

init_package_json() {
  [ -f "package.json" ] || { echo "{}" > "package.json"; echo "✓ Создан package.json"; }
}

add_scripts() {
  node <<EOF
  const fs = require('fs');
  try {
    const pkg = JSON.parse(fs.readFileSync('package.json'));
    pkg.scripts = {
      ...pkg.scripts,
      lint: "eslint . --max-warnings 0",
      "lint:fix": "eslint . --fix",
      format: "prettier --write .",
      prepare: "husky install",
      "husky-logs": "ls -lt ${HUSKY_DIR}/${LOG_PREFIX}*.log | head -n 5"
    };
    fs.writeFileSync('package.json', JSON.stringify(pkg, null, 2));
    console.log("✓ Скрипты добавлены");
  } catch (e) {
    console.error("𐄂 Ошибка:", e.message);
    process.exit(1);
  }
EOF
}

# --- Основной скрипт ---
echo "🔧 Начало настройки"
mkdir -p "${CONFIG_DIR}"
init_package_json

# Установка зависимостей
echo "📦 Установка пакетов..."
yarn add --dev @nuxt/eslint-config @typescript-eslint/eslint-plugin eslint-plugin-vue eslint-config-prettier prettier husky lint-staged

# Конфигурация
cat > "${CONFIG_DIR}/eslint.config.mjs" << 'EOL'
import { createConfigForNuxt } from '@nuxt/eslint-config/flat'
export default createConfigForNuxt({
  features: {
    stylistic: true,
    tooling: true,
    vue: true
  }
})
EOL

cat > "${CONFIG_DIR}/.prettierrc" << 'EOL'
{
  "semi": false,
  "singleQuote": true,
  "printWidth": 100
}
EOL

# Настройка Husky с динамическими логами
echo "🐶 Настройка Husky..."
npx husky-init && yarn
mkdir -p "${HUSKY_DIR}"

cat > "${HUSKY_DIR}/pre-commit" << 'EOL'
#!/bin/sh
. "$(dirname "$0")/_/husky.sh"

LOG_FILE="$(git rev-parse --short HEAD 2>/dev/null || echo "pre-commit")"
CURRENT_LOG="${HUSKY_DIR}/${LOG_PREFIX}${LOG_FILE}.log"

echo "🚀 Запуск проверок для коммита: ${LOG_FILE}" | tee "${CURRENT_LOG}"
npx lint-staged --verbose | tee -a "${CURRENT_LOG}"

# Ограничиваем количество файлов логов (сохраняем последние 10)
ls -t ${HUSKY_DIR}/${LOG_PREFIX}*.log | tail -n +11 | xargs rm -f --
EOL

chmod +x "${HUSKY_DIR}/pre-commit"

# Настройка lint-staged
cat > .lintstagedrc << 'EOL'
{
  "*.{js,ts,vue}": [
    "eslint --fix --max-warnings 0",
    "prettier --write"
  ],
  "*.{json,md}": ["prettier --write"]
}
EOL

# Финализация
add_scripts
yarn prepare
echo "✅ Готово"

# Инструкция
cat << 'EOL'

💡 ИНСТРУКЦИЯ:

1. Логи хранятся с именами:
   .husky/husky-<commit-hash>.log
   .husky/husky-precommit.log (если коммита нет)

2. Просмотр логов:
   yarn husky-logs       # Покажет последние 5 логов
   cat .husky/husky-<hash>.log # Конкретный лог

3. Очистка:
   Добавьте в .gitignore:
   .husky/husky-*.log
EOL