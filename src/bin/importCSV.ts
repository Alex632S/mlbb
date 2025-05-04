/* import * as fs from 'fs';
import * as path from 'path';

// Интерфейсы для типизации данных
interface Skill {
  [skillName: string]: string; // Название навыка и его описание
}

interface Hero {
  Класс: string;
  Специальность: string;
  Линия: string;
  Навыки: Skill;
}

// Функция для чтения CSV и преобразования в JSON
function csvToNestedJson(csvFilePath: string): Record<string, Hero> {
  const csvData = fs.readFileSync(path.resolve(csvFilePath), 'utf-8');
  const lines = csvData.split('\n').map(line => line.trim());
  const headers = lines[0].split(',');

  const result: Record<string, Hero> = {};
  let currentHero: string | null = null;

  for (let i = 1; i < lines.length; i++) {
    const row = lines[i].split(',');
    if (row.length < headers.length) continue; // Пропускаем пустые строки

    const heroName = row[0]; // Имя героя
    const skillName = row[4]; // Название навыка
    const skillDescription = row[5]; // Описание навыка

    if (heroName) {
      // Если это новая запись героя
      currentHero = heroName;
      result[currentHero] = {
        Класс: row[1],
        Специальность: row[2],
        Линия: row[3],
        Навыки: {}
      };
    }

    if (currentHero && skillName && skillDescription) {
      // Добавляем навыки к текущему герою
      result[currentHero].Навыки[skillName] = skillDescription;
    }
  }

  return result;
}

// Путь к CSV-файлу
const csvFilePath = './До Гатоткачи по списку.csv';

// Преобразование и сохранение результата
const jsonResult = csvToNestedJson(csvFilePath);
fs.writeFileSync('./heroes.json', JSON.stringify(jsonResult, null, 2), 'utf-8');

console.log('JSON успешно создан:', jsonResult);
*/