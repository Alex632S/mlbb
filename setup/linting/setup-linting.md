Адаптированная конфигурация для **yarn** со структурой внутри проекта:

```
nuxt-project/
├── setup/
│   ├── linting/
│   │   ├── setup-linting.sh
│   │   └── configs/
│   │       ├── eslint.config.mjs
│   │       └── .prettierrc
│   └── other-scripts/  # для будущих скриптов
├── .husky/            # будет создаваться автоматически
└── package.json

```

### 1. Скрипт установки (`setup/linting/setup-linting.sh`)

### 2. Ключевые изменения для yarn:

1. **Установка пакетов**:

   ```bash
   yarn add --dev вместо npm install --save-dev
   ```

2. **Инициализация Husky**:

   ```bash
   yarn dlx husky-init --yarn2 && yarn
   ```

3. **Запуск lint-staged**:

   ```bash
   yarn lint-staged вместо npx lint-staged
   ```

4. **Изменение package.json**:

   ```bash
   yarn pkg set вместо npm pkg set
   ```

5. **Активация хуков**:
   ```bash
   yarn prepare вместо npm run prepare
   ```

### 3. Особенности работы с yarn:

1. **Более быстрая установка** зависимостей
2. **Автоматическое разрешение** peer dependencies
3. **Поддержка Workspaces** (если используется)
4. **Детерминированные установки** через yarn.lock

### 4. Как использовать:

1. Убедитесь, что yarn установлен глобально:
   ```bash
   npm install -g yarn
   ```
2. Дайте права на выполнение скрипта:
   ```bash
   chmod +x setup/linting/setup-linting.sh
   ```
3. Запустите скрипт:
   ```bash
   ./setup/linting/setup-linting.sh
   ```

После выполнения все команды линтинга будут доступны через yarn:

```bash
yarn lint      # Проверка кода
yarn lint:fix  # Автоисправление ошибок
yarn format    # Форматирование кода
```
