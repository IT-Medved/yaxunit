//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2022 BIA-Technologies Limited Liability Company
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

///////////////////////////////////////////////////////////////////
// ПрограммныйИнтерфейс
// Экспортные процедуры и функции для прикладного использования 
/////////////////////////////////////////////////////////////////// 

#Область ПрограммныйИнтерфейс

// СоздатьЭлемент
//  Создает новый элемент и возвращает его ссылку 
// Параметры:
//  Менеджер - Произвольный - Менеджер справочника/ПВХ и тд.
//  Наименование - Строка, Неопределено - Наименование элемента
//  Реквизиты - Структура, Неопределено - Значения реквизитов элемента
// 
// Возвращаемое значение:
//  ЛюбаяСсылка - Ссылка на созданный объект
Функция СоздатьЭлемент(Менеджер, Наименование = Неопределено, Реквизиты = Неопределено) Экспорт
	
	Объект = Менеджер.СоздатьЭлемент();
	
	Если ЗначениеЗаполнено(Наименование) Тогда
		Объект.Наименование = Наименование;
	Иначе
		Объект.Наименование = Новый УникальныйИдентификатор();
	КонецЕсли;
	
	Если Реквизиты <> Неопределено Тогда
		ЗаполнитьЗначенияСвойств(Объект, Реквизиты);
	КонецЕсли;
	
	Объект.Записать();
	
	Возврат Объект.Ссылка;
	
КонецФункции

// СоздатьДокумент
//  Создает новый документ и возвращает его ссылку 
// Параметры:
//  Менеджер - Произвольный - Менеджер справочника/ПВХ и тд.
//  Реквизиты - Структура, Неопределено - Значения реквизитов элемента
// 
// Возвращаемое значение:
//  ЛюбаяСсылка - Ссылка на созданный объект
Функция СоздатьДокумент(Менеджер, Реквизиты = Неопределено) Экспорт
	
	Объект = Менеджер.СоздатьДокумент();
	Объект.Дата = глПолучитьМосковскоеВремя();
	Объект.УстановитьНовыйНомер();
	
	Если Реквизиты <> Неопределено Тогда
		ЗаполнитьЗначенияСвойств(Объект, Реквизиты);
	КонецЕсли;
	
	Объект.Записать();
	
	Возврат Объект.Ссылка;
	
КонецФункции

// СлучайноеЧисло
//   Генерирует и возвращает случайное число
// Параметры:
//  Минимум - Неопределено, Число - Минимальное значение
//  Максимум - Неопределено, Число - Максимальное значение
//  ЗнаковПослеЗапятой - Число - Количество знаков после запятой
// 
// Возвращаемое значение:
//  Число - Случайное число
Функция СлучайноеЧисло(Минимум = 0, Максимум = Неопределено, ЗнаковПослеЗапятой = 0) Экспорт
	
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
	
КонецФункции

// СлучайноеПоложительноеЧисло
//   Генерирует и возвращает случайное положительное число
// Параметры:
//  Максимум - Неопределено, Число - Максимальное значение
//  ЗнаковПослеЗапятой - Число - Знаков после запятой
// 
// Возвращаемое значение:
//  Число - Случайное положительное число
Функция СлучайноеПоложительноеЧисло(Максимум = Неопределено, ЗнаковПослеЗапятой = 0) Экспорт
	
	Возврат СлучайноеЧисло(1, Максимум, ЗнаковПослеЗапятой);
	
КонецФункции

// СлучайноеОтрицательноеЧисло
// 
// Параметры:
//  Минимум - Неопределено, Число - Минимальное значение
//  ЗнаковПослеЗапятой - Число - Знаков после запятой
// 
// Возвращаемое значение:
//  Число - Случайное отрицательное число
Функция СлучайноеОтрицательноеЧисло(Минимум = Неопределено, ЗнаковПослеЗапятой = 0) Экспорт
	
	Возврат -СлучайноеЧисло(Минимум, 0, ЗнаковПослеЗапятой);
	
КонецФункции

// СлучайнаяСтрока
//  Генерирует и возвращает случайную строку указанной длины, строка может содержить цифры, английские и русские буквы в разных регистрах
// Параметры:
//  Префикс - Строка - Префикс строки
//  Длина - Число - Длина генерируемой строки, без учета префикса
// 
// Возвращаемое значение:
//  Строка - Случайная строка
Функция СлучайнаяСтрока(Префикс = "", Длина = 10) Экспорт
	
	Строка = "1234567890абвгдеёжзийклмнопрстуфхцчшщъыьэюяАБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
	
	Результат = "";
	КоличествоСимволов = СтрДлина(Строка);
	
	Для Инд = 1 По Длина Цикл
		
		Результат = Результат + Сред(Строка, СлучайноеЧисло(1, КоличествоСимволов), 1);
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

// СлучайныйIPАдрес
//   Генерирует и возвращает случайный IP адрес
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

// УникальнаяСтрока
//   Генерирует и возвращает уникальную строку
// Параметры:
//  Префикс - Строка - Префик строкис
// 
// Возвращаемое значение:
//  Строка - Уникальная строка
Функция УникальнаяСтрока(Префикс = "") Экспорт
	
	Возврат Префикс + Новый УникальныйИдентификатор();
	
КонецФункции

// СлучайноеЗначениеИзСписка
//  Возвращает случайный элемент списка
// Параметры:
//  Список - Массив из Произвольный - Коллекция возможных значений
// 
// Возвращаемое значение:
//  Произвольный - случайное значение из списка
Функция СлучайноеЗначениеИзСписка(Список) Экспорт
	
	Индекс = СлучайноеЧисло(0, Список.ВГраница());
	
	Возврат Список[Индекс];
	
КонецФункции

Функция НовыйФайл(Содержимое = Неопределено, ТолькоЧтение = Ложь) Экспорт
	
	Результат = ПолучитьИмяВременногоФайла();
	ЮТКонтекст.КонтекстТеста().ВременныеФайлы.Добавить(Результат);
	
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
				ВызватьИсключение СтрШаблон("Количество значений в строке (%1) Markdown не совпадает с количеством заголовков (2):
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
//  Строки - Строка - Строки таблицы Markdown
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

#КонецОбласти
/////////////////////////////////////////////////////////////////////////////////
// Экспортные процедуры и функции для служебного использования внутри подсистемы
///////////////////////////////////////////////////////////////////////////////// 

#Область СлужебныйПрограммныйИнтерфейс

// Обработчик события "ПередТестом"
// 
// Параметры:
//  ОписаниеСобытия - см. ЮТФабрика.ОписаниеСобытияИсполненияТестов
Процедура ПередТестом(ОписаниеСобытия) Экспорт
	
	ЮТКонтекст.КонтекстТеста().Вставить("ВременныеФайлы", Новый Массив);
	
КонецПроцедуры

// Обработчик события "ПослеТеста"
// 
// Параметры:
//  ОписаниеСобытия - см. ЮТФабрика.ОписаниеСобытияИсполненияТестов
Процедура ПослеТеста(ОписаниеСобытия) Экспорт
	
	ВременныеФайлы = ЮТКонтекст.КонтекстТеста().ВременныеФайлы;
	
	Если ВременныеФайлы.Количество() = 0 Тогда
		Возврат;
	КонецЕсли;
	
	Ошибки = Новый Массив();
	
	Для Каждого УдаляемыйФайл Из ВременныеФайлы Цикл
		
		Если ТипЗнч(УдаляемыйФайл) = Тип("Строка") Тогда
			УдаляемыйФайл = Новый Файл(УдаляемыйФайл);
		КонецЕсли;
		
		Попытка
			Если УдаляемыйФайл.Существует() Тогда
				
				Если УдаляемыйФайл.ПолучитьТолькоЧтение() Тогда
					УдаляемыйФайл.УстановитьТолькоЧтение(Ложь);
				КонецЕсли;
				
				УдалитьФайлы(УдаляемыйФайл.ПолноеИмя);
				
			КонецЕсли;
		Исключение
			
			Ошибки.Добавить(ЮТРегистрацияОшибок.ПредставлениеОшибки("Удаление файла " + УдаляемыйФайл, ИнформацияОбОшибке()));
			
		КонецПопытки;
		
	КонецЦикла;
	
	Если ЗначениеЗаполнено(Ошибки) Тогда
		ВызватьИсключение СтрСоединить(Ошибки, Символы.ПС);
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

/////////////////////////////////////////////////////////////////////////////////
// Процедуры и функции, составляющие внутреннюю реализацию модуля 
///////////////////////////////////////////////////////////////////////////////// 

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
