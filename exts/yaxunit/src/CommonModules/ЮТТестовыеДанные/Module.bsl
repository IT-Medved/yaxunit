//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2023 BIA-Technologies Limited Liability Company
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
//©///////////////////////////////////////////////////////////////////////////©//

#Область ПрограммныйИнтерфейс

// Создает новый элемент и возвращает его ссылку.
//  
// Параметры:
//  Менеджер - Произвольный - Менеджер справочника/ПВХ и тд.
//  Наименование - Строка, Неопределено - Наименование элемента
//  Реквизиты - Структура, Неопределено - Значения реквизитов элемента
// 
// Возвращаемое значение:
//  ЛюбаяСсылка - Ссылка на созданный объект
Функция СоздатьЭлемент(Менеджер, Наименование = Неопределено, Реквизиты = Неопределено) Экспорт
	
	Если Реквизиты <> Неопределено Тогда
		Данные = Реквизиты;
	Иначе
		Данные = Новый Структура;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Наименование) Тогда
		Данные.Вставить("Наименование", Наименование);
	КонецЕсли;
	
	Ссылка = ЮТТестовыеДанныеВызовСервера.СоздатьЗапись(Менеджер, Данные, Неопределено, Ложь);
	ЮТТестовыеДанныеСлужебный.ДобавитьТестовуюЗапись(Ссылка);
	
	Возврат Ссылка;
	
КонецФункции

// Создает новый документ и возвращает его ссылку.
//  
// Параметры:
//  Менеджер - Произвольный - Менеджер справочника/ПВХ и тд.
//  Реквизиты - Структура, Неопределено - Значения реквизитов элемента
// 
// Возвращаемое значение:
//  ДокументСсылка - Ссылка на созданный объект
Функция СоздатьДокумент(Менеджер, Реквизиты = Неопределено) Экспорт
	
	Если Реквизиты <> Неопределено Тогда
		Данные = Реквизиты;
	Иначе
		Данные = Новый Структура;
	КонецЕсли;
	
	Если Данные.Свойство("РежимЗаписи") Тогда
		ПараметрыЗаписи = ЮТОбщий.ПараметрыЗаписи();
		ПараметрыЗаписи.РежимЗаписи = Данные.РежимЗаписи;
		Данные.Удалить("РежимЗаписи");
	КонецЕсли;
	
	Ссылка = ЮТТестовыеДанныеВызовСервера.СоздатьЗапись(Менеджер, Данные, ПараметрыЗаписи, Ложь);
	ЮТТестовыеДанныеСлужебный.ДобавитьТестовуюЗапись(Ссылка);
	
	Возврат Ссылка;
	
КонецФункции

// Создает новую группу
//  
// Параметры:
//  Менеджер - Произвольный - Менеджер справочника/ПВХ и тд.
//  Наименование - Строка, Неопределено - Наименование элемента
//  Реквизиты - Структура, Неопределено - Значения реквизитов элемента
// 
// Возвращаемое значение:
//  ЛюбаяСсылка - Ссылка на созданную группу
Функция СоздатьГруппу(Менеджер, Наименование = Неопределено, Реквизиты = Неопределено) Экспорт
	
	Если Реквизиты <> Неопределено Тогда
		Данные = Реквизиты;
	Иначе
		Данные = Новый Структура;
	КонецЕсли;
	
	Данные.Вставить("ЭтоГруппа", Истина);
	
	Возврат СоздатьЭлемент(Менеджер, Наименование, Данные);
	
КонецФункции

// Генерирует и возвращает случайное число.
// 
// Параметры:
//  Минимум - Неопределено, Число - Минимальное значение
//  Максимум - Неопределено, Число - Максимальное значение
//  ЗнаковПослеЗапятой - Число - Количество знаков после запятой
// 
// Возвращаемое значение:
//  Число - Случайное число
Функция СлучайноеЧисло(Минимум = 0, Максимум = Неопределено, ЗнаковПослеЗапятой = 0) Экспорт
	
#Если ВебКлиент Тогда
	ВызватьИсключение ЮТОбщий.МетодНеДоступен("ЮТТестовыеДанные.СлучайноеЧисло");
#Иначе
	Генератор = ЮТКонтекст.ЗначениеКонтекста("ГенераторСлучайныхЧисел");
	
	Если Генератор = Неопределено Тогда
		Генератор = Новый ГенераторСлучайныхЧисел();
		ЮТКонтекст.УстановитьЗначениеКонтекста("ГенераторСлучайныхЧисел", Генератор);
	КонецЕсли;
	
	Если Максимум = Неопределено Тогда
		Результат = Генератор.СлучайноеЧисло(Минимум);
	Иначе
		Результат = Генератор.СлучайноеЧисло(Минимум, Максимум);
	КонецЕсли;
	
	Если ЗнаковПослеЗапятой > 0 Тогда
		Множитель = Pow(10, ЗнаковПослеЗапятой);
		Результат = Результат + Окр(Генератор.СлучайноеЧисло(0, Множитель) / Множитель, ЗнаковПослеЗапятой);
	КонецЕсли;
	
	Возврат Результат;
#КонецЕсли
	
КонецФункции

// Генерирует и возвращает случайное положительное число.
// 
// Параметры:
//  Максимум - Неопределено, Число - Максимальное значение
//  ЗнаковПослеЗапятой - Число - Знаков после запятой
// 
// Возвращаемое значение:
//  Число - Случайное положительное число
Функция СлучайноеПоложительноеЧисло(Максимум = Неопределено, ЗнаковПослеЗапятой = 0) Экспорт
	
	Возврат СлучайноеЧисло(1, Максимум, ЗнаковПослеЗапятой);
	
КонецФункции

// Генерирует и возвращает случайное отрицательное число.
// 
// Параметры:
//  Минимум - Неопределено, Число - Минимальное значение
//  ЗнаковПослеЗапятой - Число - Знаков после запятой
// 
// Возвращаемое значение:
//  Число - Случайное отрицательное число
Функция СлучайноеОтрицательноеЧисло(Минимум = Неопределено, ЗнаковПослеЗапятой = 0) Экспорт
	
	Возврат -СлучайноеЧисло(0, -Минимум, ЗнаковПослеЗапятой);
	
КонецФункции

// Генерирует и возвращает случайную строку указанной длины, строка может содержать цифры, английские и русские буквы в разных регистрах.
// 
// Параметры:
//  Длина - Число - Длина генерируемой строки с учетом префикса
//  Префикс - Строка - Префикс строки
//  ДопустимыеСимволы - Строка - Допустимые символы из которая будет формироваться случайная строка
// 
// Возвращаемое значение:
//  Строка - Случайная строка
Функция СлучайнаяСтрока(Знач Длина = 10, Префикс = "", Знач ДопустимыеСимволы = Неопределено) Экспорт
	
	Если ДопустимыеСимволы = Неопределено Тогда
		ДопустимыеСимволы = ЮТСтроки.РусскиеБуквы(Истина, Истина) + ЮТСтроки.АнглийскиеБуквы(Истина, Истина) + ЮТСтроки.Цифры();
	КонецЕсли;
	
	Результат = "";
	КоличествоСимволов = СтрДлина(ДопустимыеСимволы);
	
	Длина = Длина - СтрДлина(Префикс);
	
	Для Инд = 1 По Длина Цикл
		
		Результат = Результат + Сред(ДопустимыеСимволы, СлучайноеЧисло(1, КоличествоСимволов), 1);
		
	КонецЦикла;
	
	Возврат Префикс + Результат;
	
КонецФункции

// Возвращяет случайный валидный идентификатор
// 
// Параметры:
//  Длина - Число - Длина генерируемой строки с учетом префикса
//  Префикс - Строка - Префикс строки
// 
// Возвращаемое значение:
//  Строка - Случайный идентификатор
Функция СлучайныйИдентификатор(Знач Длина = 10, Знач Префикс = "") Экспорт
	
	НаборСимволов = "_" + ЮТСтроки.РусскиеБуквы(Истина, Истина) + ЮТСтроки.АнглийскиеБуквы(Истина, Истина);
	
	Если ПустаяСтрока(Префикс) Тогда
		Префикс = СлучайнаяСтрока(1, "", НаборСимволов);
	КонецЕсли;
	
	НаборСимволов = НаборСимволов + ЮТСтроки.Цифры();
	
	Возврат СлучайнаяСтрока(Длина, Префикс, НаборСимволов);
	
КонецФункции

// Генерирует и возвращает случайную дату в указанном интервале (если не указан используется `0001-01-01  - 3999-12-31`).
// 
// Параметры:
//  Минимум - Дата - Минимальное значение случайной даты
//          - Неопределено - Если не указано используется `0001-01-01`
//  Максимум - Дата - Максимальное значение случайной даты
//           - Неопределено - Если не указано используется `3999-12-31`
// 
// Возвращаемое значение:
//  Дата - Случайная дата
Функция СлучайнаяДата(Знач Минимум = Неопределено, Знач Максимум = Неопределено) Экспорт
	
	Если Минимум = Неопределено Тогда
		Минимум = '00010101';
	КонецЕсли;
	
	Если Максимум = Неопределено Тогда
		Максимум = '39991231';
	КонецЕсли;
	
	СекундВДне = 86400;
	КоличествоДней = Цел((Максимум - Минимум) / СекундВДне);
	Возврат Минимум + СлучайноеЧисло(0, КоличествоДней) * СекундВДне + СлучайноеЧисло(0, СекундВДне);
	
КонецФункции

// Генерирует и возвращает случайный IP адрес.
// 
// Возвращаемое значение:
//  Строка - Случайный IP адрес
Функция СлучайныйIPАдрес() Экспорт
	
	Части = Новый Массив();
	Части.Добавить(СлучайноеЧисло(1, 253));
	Части.Добавить(СлучайноеЧисло(1, 253));
	Части.Добавить(СлучайноеЧисло(1, 253));
	Части.Добавить(СлучайноеЧисло(1, 253));
	
	Возврат СтрСоединить(Части, ".");
	
КонецФункции

// Генерирует и возвращает уникальную строку, формируется из уникального идентификатора.
// 
// Параметры:
//  Префикс - Строка - Префикс строки
// 
// Возвращаемое значение:
//  Строка - Уникальная строка
Функция УникальнаяСтрока(Префикс = "") Экспорт
	
	Возврат Префикс + Новый УникальныйИдентификатор();
	
КонецФункции

// Возвращает случайный элемент списка.
// 
// Параметры:
//  Список - Массив из Произвольный - Коллекция возможных значений
// 
// Возвращаемое значение:
//  Произвольный - случайное значение из списка
Функция СлучайноеЗначениеИзСписка(Список) Экспорт
	
	Индекс = СлучайноеЧисло(0, Список.ВГраница());
	
	Возврат Список[Индекс];
	
КонецФункции

// Возвращает случайно логическое значение.
// 
// Возвращаемое значение:
//  Булево - Случайное булево
Функция СлучайноеБулево() Экспорт
	
	Возврат СлучайноеЧисло() %2 = 0;
	
КонецФункции

// Создает новый файл, который будет удален после теста
// 
// Параметры:
//  Содержимое - Строка, Неопределено - Содержимое файла
//  ТолькоЧтение - Булево - Установить атрибут `только чтение`
//  Расширение - Строка, Неопределено - Расширение нового файла
// 
// Возвращаемое значение:
//  Строка - Новый файл
Функция НовыйФайл(Содержимое = Неопределено, ТолькоЧтение = Ложь, Расширение = Неопределено) Экспорт
	
	Результат = НовоеИмяВременногоФайла(Расширение);
	
	ЗаписьДанных = Новый ЗаписьДанных(Результат);
	
	Если Содержимое <> Неопределено Тогда
		ЗаписьДанных.ЗаписатьСимволы(Содержимое);
	КонецЕсли;
	
	ЗаписьДанных.Закрыть();
	
	Если ТолькоЧтение Тогда
		СозданныйФайл = Новый Файл(Результат);
		СозданныйФайл.УстановитьТолькоЧтение(Истина);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Возвращает имя нового файла.
// По окончании выполнения теста этот файл будет удален.
// 
// Параметры:
//  Расширение - Строка - Расширение нового файла
// 
// Возвращаемое значение:
//  Строка
Функция НовоеИмяВременногоФайла(Расширение = Неопределено) Экспорт
	
	Возврат ЮТТестовыеДанныеСлужебный.НовоеИмяВременногоФайла(Расширение);
	
КонецФункции

// Читает таблицу MarkDown в массив структур
// 
// Параметры:
//  Строки - Строка - Таблица markdown
// 
// Возвращаемое значение:
//  Массив  из Структура - Данные таблицы markdown
Функция ТаблицаMarkDown(Строки) Экспорт
	
	ЗагрузилиЗаголовок = Ложь;
	Результат = Новый Массив();
	Ключи = "";
	
	Разделитель = "|";
	
	Кодировка = КодировкаТекста.UTF8;
	Поток = ПолучитьДвоичныеДанныеИзСтроки(Строки, Кодировка).ОткрытьПотокДляЧтения();
	Чтение = Новый ЧтениеТекста(Поток, Кодировка);
	
	Пока Истина Цикл
		
		Строка = Чтение.ПрочитатьСтроку();
		Если Строка = Неопределено Тогда
			Прервать;
		КонецЕсли;
		
		Строка = СокрЛП(Строка);
		
		Если ПустаяСтрока(Строка) Тогда
			Продолжить;
		ИначеЕсли НЕ СтрНачинаетсяС(Строка, Разделитель) Тогда
			Если ЗагрузилиЗаголовок Тогда
				Прервать;
			Иначе
				Продолжить;
			КонецЕсли;
		КонецЕсли;
		
		Блоки = СтрРазделить(Строка, Разделитель);
		
		Если ЗагрузилиЗаголовок Тогда
			
			Если Блоки.Количество() <> Ключи.Количество() Тогда
				ВызватьИсключение СтрШаблон("Количество значений в строке (%1) Markdown не совпадает с количеством заголовков (%2):
											|%3", Блоки.Количество(), Ключи.Количество(), Строка);
			КонецЕсли;
			
			СтрокаРезультата = Новый Структура();
			Для Инд = 1 По Блоки.ВГраница() - 1 Цикл
				СтрокаРезультата.Вставить(Ключи[Инд], СокрЛП(Блоки[Инд]));
			КонецЦикла;
			Результат.Добавить(СтрокаРезультата);
		Иначе
			Ключи = Новый Массив();
			Для Инд = 0 По Блоки.ВГраница() Цикл
				Ключи.Добавить(СокрЛП(Блоки[Инд]));
			КонецЦикла;
			Чтение.ПрочитатьСтроку(); // Пропуск строки разделителя
			ЗагрузилиЗаголовок = Истина;
		КонецЕсли;
		
	КонецЦикла;
	
	Чтение.Закрыть();
	Поток.Закрыть();
	
	Возврат Результат;
	
КонецФункции

// Формирует структуру на основании таблицы Markdown
// 
// Параметры:
//  Ключ - Строка - Имя ключевой колонки
//  Строки - Строка - Таблица markdown
// 
// Возвращаемое значение:
//  Структура
Функция СтруктураMarkDown(Ключ, Строки) Экспорт
	
	Таблица = ТаблицаMarkDown(Строки);
	
	Результат = Новый Структура();
	
	Для Каждого Строка Из Таблица Цикл
		Результат.Вставить(Строка[Ключ], Строка);
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

// Читает табличный документ в массив структур
//
//	Параметры:
//		ТабличныйДокумент - ТабличныйДокумент - Исходный табличный документ
//		НомерКолонки - Число - Номер строки таблицы, с которой следует начать считывание
//		НомерСтроки - Число - Номер колонки таблицы, с которой следует начать считывание
//	Возвращаемое значение:
//		Массив из Структура - Данные табличного документа	
Функция СтруктурыТабличногоДокумента(ТабличныйДокумент, Знач НомерКолонки = 1, Знач НомерСтроки = 1) Экспорт
	
	МассивДанных = Новый Массив;
	СведенияКолонок = Новый Массив;
	
	ЗаменяемыеСтроки = ЮТТестовыеДанныеСлужебный.ПодстрокиДляЗаменыВИменахСвойств();
	
	ЗначениеКолонки = ТабличныйДокумент.Область(НомерСтроки, НомерКолонки).Текст;
	Пока ЗначениеЗаполнено(ЗначениеКолонки) Цикл
		
		Для Каждого Замена Из ЗаменяемыеСтроки Цикл
			ПодстрокаПоиска = Замена.Ключ;
			ПодстрокаЗамены = Замена.Значение;
			ИмяКолонки = СтрЗаменить(ЗначениеКолонки, ПодстрокаПоиска, ПодстрокаЗамены);
		КонецЦикла;
		
		Сведения = Новый Структура("НомерКолонки, ИмяКолонки", НомерКолонки, ИмяКолонки);
		СведенияКолонок.Добавить(Сведения);
		
		НомерКолонки = НомерКолонки + 1;
		ЗначениеКолонки = ТабличныйДокумент.Область(НомерСтроки, НомерКолонки).Текст;
		
	КонецЦикла;
	
	НомерСтроки = НомерСтроки + 1;
	
	Пока ЕстьЗначенияВСтроке(ТабличныйДокумент, НомерСтроки, СведенияКолонок) Цикл
		
		Структура = Новый Структура;
		
		Для Каждого Сведения Из СведенияКолонок Цикл
			Значение = СокрЛП(ТабличныйДокумент.Область(НомерСтроки, Сведения.НомерКолонки).Текст);
			Структура.Вставить(Сведения.ИмяКолонки, Значение);
		КонецЦикла;
		
		МассивДанных.Добавить(Структура);
		
		НомерСтроки = НомерСтроки + 1;
		
	КонецЦикла;
	
	Возврат МассивДанных;
	
КонецФункции
	
// Формирует массив различных комбиначий параметров
// 
// Предназначено для формирования таблицы возможных значений параметров для краш теста метода.
// 
// Параметры:
//  ЗначенияПоУмолчанию - Структура - Значения параметров по умолчанию.
//  ЗначенияПараметров - Структура - Массивы значений для каждого параметра.
// 
// Возвращаемое значение:
//  Массив из Структура - Варианты параметров.
Функция ВариантыПараметров(ЗначенияПоУмолчанию, ЗначенияПараметров) Экспорт
	
	Варианты = Новый Массив;
	Варианты.Добавить(ЗначенияПоУмолчанию);
	
	Ключи = ЮТОбщий.ВыгрузитьЗначения(ЗначенияПараметров, "Ключ");
	
	ДобавитьВарианты(Варианты, ЗначенияПоУмолчанию, ЗначенияПараметров, Ключи, 0);
	
	Возврат Варианты;
	
КонецФункции

// Возвращает конструктор создания тестовых данных
// 
// Конструктор имеет ряд особенностей:
// 
// * Нельзя использовать параллельно несколько конструкторов. 
//   Например
//   
//   ```bsl
//   Пользователь = КонструкторОбъекта(Справочники.Пользователи);
//   Документ = КонструкторОбъекта(Документы.Приход);
//   ...
//   Пользователь.Записать();
//   Документ.Провести();
//   ```
//   
// * Создание объекта происходит при вызове методов `Записать` и `Провести`, а создание реквизитов происходит во время вызова методов установки.
// * При использовании на клиенте все значения должны быть сериализуемыми.
// 
// Параметры:
//  Менеджер - Строка - Имя менеджера. Примеры: Справочники.Товары, Документы.ПриходТоваров
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТКонструкторТестовыхДанных
Функция КонструкторОбъекта(Менеджер) Экспорт
	
	Возврат ЮТКонструкторТестовыхДанныхСлужебный.Инициализировать(Менеджер);
	
КонецФункции

// Удаляет переданные объекта
// 
// Параметры:
//  Ссылки - Массив из ЛюбаяСсылка
Процедура Удалить(Ссылки) Экспорт
	
	Если ЗначениеЗаполнено(Ссылки) Тогда
		ЮТТестовыеДанныеВызовСервера.Удалить(Ссылки);
	КонецЕсли;
	
КонецПроцедуры

// Возвращает объект подражателя для формирования осмысленных тестовых данных
//
// Возвращаемое значение:
//  ОбщийМодуль - Подражатель
Функция Подражатель() Экспорт
	Возврат ЮТПодражательСлужебный.Инициализировать();
КонецФункции

#Если Сервер Тогда
// Возвращает мок для `HTTPСервисЗапрос`.
// 
// Возвращаемое значение:
//  ОбработкаОбъект.ЮТHTTPСервисЗапрос - Мок
Функция HTTPСервисЗапрос() Экспорт
	
	Возврат Обработки.ЮТHTTPСервисЗапрос.Создать();
	
КонецФункции

// Возвращает таблицу значений из табличного документа
//	Параметры:
//		ТабличныйДокумент - ТабличныйДокумент - Исходный табличный документ
//		ОписанияТипов - Соответствие из Строка - Соответствие имен колонок таблицы к типам значений
//		КэшЗначений - Соответствие из Произвольный - Соответствие для хранения создаваемых значений
//		ЗаменяемыеЗначения - Соответствие из Строка - Значения, использующиеся для замены
//		ПараметрыСозданияОбъектов - Структура:
//			* ФикцияОбязательныхПолей - Булево - По умолчанию - Ложь
//			* ОбменДаннымиЗагрузка - Булево - По умолчанию - Истина
//	Возвращаемое значение:
//		см. ЮТТестовыеДанные_ТаблицыЗначений.ТаблицаЗначенийИзМассиваСтруктур
Функция ТаблицаЗначенийИзТабличногоДокумента(ТабличныйДокумент, ОписанияТипов, КэшЗначений = Неопределено,
	ЗаменяемыеЗначения = Неопределено, ПараметрыСозданияОбъектов = Неопределено) Экспорт
	
	Параметры = ЮТТестовыеДанные_ТаблицыЗначений.ПараметрыЗаполненияТаблицыЗначений(ПараметрыСозданияОбъектов);
	ИсточникДанных = СтруктурыТабличногоДокумента(ТабличныйДокумент);
	ТаблицаЗначений = ЮТТестовыеДанные_ТаблицыЗначений.ТипизированнаяТаблицаЗначений(
		ИсточникДанных,
		ОписанияТипов,
		КэшЗначений,
		ЗаменяемыеЗначения,
		Параметры
	);
	
	Возврат ТаблицаЗначений;
	
КонецФункции

// Возвращает таблицу значений из таблицы MarkDown
//	Параметры:
//		Строки - Строка - Таблица markdown
//		ОписанияТипов - Соответствие из Строка - Соответствие имен колонок таблицы к типам значений
//		КэшЗначений - Соответствие из Произвольный - Соответствие для хранения создаваемых значений
//		ЗаменяемыеЗначения - Соответствие из Строка - Значения, использующиеся для замены
//		ПараметрыСозданияОбъектов - Структура:
//			* ФикцияОбязательныхПолей - Булево - По умолчанию - Ложь
//			* ОбменДаннымиЗагрузка - Булево - По умолчанию - Истина
//	Возвращаемое значение:
//		см. ЮТТестовыеДанные_ТаблицыЗначений.ТаблицаЗначенийИзМассиваСтруктур
Функция ТаблицаЗначенийИзТаблицыMarkDown(Строки, ОписанияТипов, КэшЗначений = Неопределено,
	ЗаменяемыеЗначения = Неопределено, ПараметрыСозданияОбъектов = Неопределено) Экспорт
	
	Параметры = ЮТТестовыеДанные_ТаблицыЗначений.ПараметрыЗаполненияТаблицыЗначений(ПараметрыСозданияОбъектов);
	ИсточникДанных = ТаблицаMarkDown(Строки);
	ТаблицаЗначений = ЮТТестовыеДанные_ТаблицыЗначений.ТипизированнаяТаблицаЗначений(
		ИсточникДанных,
		ОписанияТипов,
		КэшЗначений,
		ЗаменяемыеЗначения,
		Параметры
	);
	
	Возврат ТаблицаЗначений;
	
КонецФункции
	
#КонецЕсли

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ДобавитьВарианты(Варианты, БазоваяСтруктура, ЗначенияПараметров, Ключи, Инд)
	
	Если Инд > Ключи.ВГраница() Тогда
		Возврат;
	КонецЕсли;
	
	Ключ = Ключи[Инд];
	Для Каждого Значение Из ЗначенияПараметров[Ключ] Цикл
		
		Вариант = ЮТОбщий.СкопироватьСтруктуру(БазоваяСтруктура);
		Вариант[Ключ] = Значение;
		Варианты.Добавить(Вариант);
		
		ДобавитьВарианты(Варианты, Вариант, ЗначенияПараметров, Ключи, Инд + 1);
		
	КонецЦикла;

КонецПроцедуры

Функция ЕстьЗначенияВСтроке(ТабличныйДокумент, НомерСтроки, СведенияКолонок)
	
	ЕстьЗаполненныеЗначения = Ложь;
	
	Для Каждого Сведения Из СведенияКолонок Цикл
		Если ЕстьЗаполненныеЗначения Тогда
			Прервать;
		КонецЕсли;
		НомерКолонки = Сведения.НомерКолонки;
		ЕстьЗаполненныеЗначения = ЗначениеЗаполнено(ТабличныйДокумент.Область(НомерСтроки, НомерКолонки).Текст);
	КонецЦикла;
	
	Возврат ЕстьЗаполненныеЗначения;
	
КонецФункции

#КонецОбласти
