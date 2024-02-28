//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2024 BIA-Technologies Limited Liability Company
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

#Область СлужебныйПрограммныйИнтерфейс

// Параметры записи объекта
// 
// Возвращаемое значение:
//  Структура - Параметры записи:
// * ОбменДаннымиЗагрузка - Булево
// * ДополнительныеСвойства - Структура
// * РежимЗаписи - РежимЗаписиДокумента
Функция ПараметрыЗаписи() Экспорт
	
	ПараметрыЗаписи = Новый Структура();
	ПараметрыЗаписи.Вставить("ОбменДаннымиЗагрузка", Ложь);
	ПараметрыЗаписи.Вставить("ДополнительныеСвойства", Новый Структура);
	ПараметрыЗаписи.Вставить("РежимЗаписи", РежимЗаписиДокумента.Запись);
	
	Возврат ПараметрыЗаписи;
	
КонецФункции

// КонтекстыВызова
//  Возвращает перечисление возможных контекстов вызова
// Возвращаемое значение:
//  ФиксированнаяСтруктура - Контексты вызова:
//  * КлиентОбычноеПриложение - Строка
//  * КлиентУправляемоеПриложение - Строка
//  * Сервер - Строка
//  * ВызовСервера - Строка
Функция КонтекстыВызова() Экспорт
	
	Контексты = Новый Структура();
	
	Контексты.Вставить("КлиентОбычноеПриложение", "КлиентОбычноеПриложение");
	Контексты.Вставить("КлиентУправляемоеПриложение", "КлиентУправляемоеПриложение");
	Контексты.Вставить("Сервер", "Сервер");
	Контексты.Вставить("ВызовСервера", "ВызовСервера");
	
	// TODO Подозреваю нужно добавить web клиент
	
	Возврат Новый ФиксированнаяСтруктура(Контексты);
	
КонецФункции

// Доступные параметры (настройки) исполнения тестов
// 
// Возвращаемое значение:
//  ФиксированнаяСтруктура - Параметры исполнения теста:
//  * ВТранзакции - Строка - Тест должен выполняться в транзакции
//  * УдалениеТестовыхДанных - Строка - Тест должен удалить созданные тестовые данные
//  * Перед - Строка - Перед тестом должен выполниться указанный обработчик события вместо основного
//  * После - Строка - После теста должен выполниться указанный обработчик события вместо основного
Функция ПараметрыИсполненияТеста() Экспорт
	
	Параметры = Новый Структура();
	Параметры.Вставить("ВТранзакции", "ВТранзакции");
	Параметры.Вставить("УдалениеТестовыхДанных", "УдалениеТестовыхДанных");
	Параметры.Вставить("Перед", "Перед");
	Параметры.Вставить("После", "После");
	
	Возврат Новый ФиксированнаяСтруктура(Параметры);
	
КонецФункции

#Область Перечисления

// КонтекстыИсполнения
// Возвращает перечисление возможных контекстов исполнения тестов
// 
// Возвращаемое значение:
//  ФиксированнаяСтруктура - Контексты исполнения:
//	* Клиент - Строка
//	* Сервер - Строка
Функция КонтекстыИсполнения() Экспорт
	
	Контексты = Новый Структура();
	
	Контексты.Вставить("Клиент", "Клиент");
	Контексты.Вставить("Сервер", "Сервер");
	
	Возврат Новый ФиксированнаяСтруктура(Контексты);
	
КонецФункции

// Возвращает перечисление возможных статусов выполнения теста, жизненный цикл теста
// 
// Возвращаемое значение:
//  ФиксированнаяСтруктура - Статусы исполнения теста:
//  * Ожидание- Строка - Тест не выполнялся
//  * Исполнение- Строка - Тест выполняется в данный момент
//  * Успешно- Строка - Тест успешно пройден
//  * Ошибка- Строка - Тест упал с ошибкой выполнения
//  * Сломан- Строка - Тест упал на проверках утверждений
//  * Пропущен- Строка - Тест пропущен по каким либо причинам
//  * НеРеализован- Строка - Тест не реализован
Функция СтатусыИсполненияТеста() Экспорт
	
	Статусы = Новый Структура();
	
	Статусы.Вставить("Ожидание", "Ожидание");
	Статусы.Вставить("Исполнение", "Исполнение");
	Статусы.Вставить("Успешно", "Успешно");
	Статусы.Вставить("Ошибка", "Ошибка");
	Статусы.Вставить("Сломан", "Сломан");
	Статусы.Вставить("Пропущен", "Пропущен");
	Статусы.Вставить("НеРеализован", "НеРеализован");
	
	Возврат Новый ФиксированнаяСтруктура(Статусы);
	
КонецФункции

// Типы ошибок.
// 
// Возвращаемое значение:
//  ФиксированнаяСтруктура - Типы возможных ошибок:
//  * ТестНеРеализован - Строка
//  * ОшибкаСравнения - Строка
//  * ОшибкаОбработкиСобытия - Строка
//  * Утверждений - Строка
//  * Исполнения - Строка
//  * ЧтенияТестов - Строка
//  * МалоПараметров - Строка
//  * МногоПараметров - Строка
//  * НекорректныйКонтекстИсполнения - Строка
//  * Пропущен - Строка
Функция ТипыОшибок() Экспорт
	
	Типы = Новый Структура;
	
	Для Каждого ТипОшибки Из ПараметрыТиповОшибок() Цикл
		Типы.Вставить(ТипОшибки.Ключ, ТипОшибки.Ключ);
	КонецЦикла;
	
	//@skip-check constructor-function-return-section
	Возврат Новый ФиксированнаяСтруктура(Типы);
	
КонецФункции

Функция ПараметрыТиповОшибок(Кешировать = Истина) Экспорт
	
	Если Кешировать Тогда
		ЮТПовторногоИспользования.ПараметрыТиповОшибок();
	КонецЕсли;
	
	Статусы = СтатусыИсполненияТеста();
	Реквизиты = "Ключ, Представление, Статус";
	
	ТипыОшибок = Новый Массив();
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "ТестНеРеализован", "Не реализован", Статусы.НеРеализован));
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "ОшибкаСравнения", "Ошибка сравнения", Статусы.Ошибка));
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "ОшибкаОбработкиСобытия", "Ошибка обработки события", Статусы.Сломан));
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "Утверждений", "Ошибка утверждений", Статусы.Ошибка));
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "Исполнения", "Ошибка исполнения", Статусы.Сломан));
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "ЧтенияТестов", "Загрузки тестов", Статусы.Сломан));
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "МалоПараметров", "Мало фактических параметров", Статусы.Сломан));
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "МногоПараметров", "Много фактических параметров", Статусы.Сломан));
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "НекорректныйКонтекстИсполнения", "Некорректный контекст исполнения", Статусы.Пропущен));
	ТипыОшибок.Добавить(Новый Структура(Реквизиты, "Пропущен", "Пропущен", Статусы.Пропущен));
	
	Возврат ЮТОбщий.ВСтруктуру(ТипыОшибок, "Ключ");
	
КонецФункции

Функция УровниИсполнения() Экспорт
	
	Уровни = Новый Структура;
	Уровни.Вставить("Модуль", "Модуль");
	Уровни.Вставить("НаборТестов", "НаборТестов");
	Уровни.Вставить("Тест", "Тест");
	
	Возврат Новый ФиксированнаяСтруктура(Уровни);
	
КонецФункции

#КонецОбласти

#Область СтруктурыДанных

// Описание тестового модуля.
// 
// Параметры:
//  МетаданныеМодуля - см. ЮТФабрика.ОписаниеМодуля
//  НаборыТестов - Массив из см. ЮТФабрика.ОписаниеТестовогоНабора
// 
// Возвращаемое значение:
//  Структура - Описание тестового модуля:
// * МетаданныеМодуля - см. ЮТФабрика.ОписаниеМодуля
// * НаборыТестов - Массив из см. ЮТФабрика.ОписаниеТестовогоНабора
// * Ошибки - Массив из см. ЮТФабрика.ОписаниеВозникшейОшибки 
// * НастройкиВыполнения- Структура - Настройки исполнения теста
Функция ОписаниеТестовогоМодуля(МетаданныеМодуля, НаборыТестов) Экспорт
	
	Описание = Новый Структура;
	Описание.Вставить("МетаданныеМодуля", МетаданныеМодуля);
	Описание.Вставить("НаборыТестов", НаборыТестов);
	Описание.Вставить("Ошибки", Новый Массив);
	Описание.Вставить("НастройкиВыполнения", Новый Структура());
	
	Возврат Описание;
	
КонецФункции

// ОписаниеТестовогоНабора
//  Возвращает описание регистрируемого тестового набора.
//  Эта структура используется на этапе формирования описаний имеющихся тестов
// Параметры:
//  Имя - Строка - Имя набора
//  ТегиСтрокой - Строка - Теги набора
// 
// Возвращаемое значение:
//  Структура - Описание тестового набора:
// * Имя - Строка - Имя набора
// * Представление - Строка - Представление, краткое описание
// * Теги - Массив из Строка - Коллекция тегов набора
// * Тесты - Массив из см. ОписаниеТеста - Коллекция тестов набора, см. ОписаниеТеста
// * Ошибки - Массив из см. ЮТФабрика.ОписаниеВозникшейОшибки - Описания ошибок регистрации тестов
// * НастройкиВыполнения- Структура - Настройки исполнения теста
Функция ОписаниеТестовогоНабора(Имя, ТегиСтрокой = "") Экспорт
	
	Описание = Новый Структура;
	Описание.Вставить("Имя", Строка(Имя));
	Описание.Вставить("Представление", Строка(Имя));
	Описание.Вставить("Теги", СтрРазделить(ТегиСтрокой, ", ", Ложь));
	Описание.Вставить("Тесты", Новый Массив);
	Описание.Вставить("Ошибки", Новый Массив);
	Описание.Вставить("НастройкиВыполнения", Новый Структура());
	
	Возврат Описание;
	
КонецФункции

// ОписаниеТеста
//  Возвращает описание регистрируемого теста.
//  Эта структура используется на этапе формирования описаний имеющихся тестов
// Параметры:
//  Имя - Строка - Имя тестового метода
//  Представление - Строка - Представление, краткое описание теста
//  КонтекстыВызова - Массив из Строка - Контексты исполнения теста
//  ТегиСтрокой - Строка - Теги теста
// 
// Возвращаемое значение:
//  Структура - Описание теста:
// * Имя - Строка - Имя теста (тестового метода)
// * Представление - Строка - Представление теста
// * Теги - Массив из Строка - Теги теста
// * КонтекстВызова - Массив из Строка - Контексты исполнения теста
// * НастройкиВыполнения- Структура - Настройки исполнения теста
// * Параметры - Неопределено, Массив из Произвольный - Параметры теста
// * НомерВНаборе - Число - Порядковый номер теста в наборе
Функция ОписаниеТеста(Имя, Представление, КонтекстыВызова, Знач ТегиСтрокой = "") Экспорт
	
	Если ТегиСтрокой = Неопределено Тогда
		ТегиСтрокой = "";
	КонецЕсли;
	
	Описание = Новый Структура();
	Описание.Вставить("Имя", Строка(Имя));
	Описание.Вставить("Представление", Строка(Представление));
	Описание.Вставить("Теги", СтрРазделить(ТегиСтрокой, ", ", Ложь));
	Описание.Вставить("КонтекстВызова", КонтекстыВызова);
	Описание.Вставить("НастройкиВыполнения", Новый Структура());
	Описание.Вставить("Параметры", Неопределено);
	Описание.Вставить("НомерВНаборе", 0);
	
	Возврат Описание;
	
КонецФункции

// Описание исполняемого тестового модуля.
//  Содержит всю необходимую информацию для прогона тестов, а также данные результата
// Параметры:
//  ТестовыйМодуль - см. ОписаниеТестовогоМодуля
// 
// Возвращаемое значение:
//  Структура - Описание тестового модуля:
// * МетаданныеМодуля - см. ЮТФабрика.ОписаниеМодуля
// * НаборыТестов - Массив из см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов
// * Ошибки - Массив из см. ЮТФабрика.ОписаниеВозникшейОшибки 
// * НастройкиВыполнения- Структура - Настройки исполнения теста
Функция ОписаниеИсполняемогоТестовогоМодуля(ТестовыйМодуль) Экспорт
	
	Описание = Новый Структура;
	
	Описание.Вставить("МетаданныеМодуля", ТестовыйМодуль.МетаданныеМодуля);
	Описание.Вставить("НаборыТестов", Новый Массив);
	Описание.Вставить("Ошибки", ЮТОбщий.СкопироватьМассив(ТестовыйМодуль.Ошибки));
	Описание.Вставить("НастройкиВыполнения", ЮТОбщий.СкопироватьСтруктуру(ТестовыйМодуль.НастройкиВыполнения));
	
	Возврат Описание;
	
КонецФункции

// ОписаниеИсполняемогоНабораТестов
//  Возвращает описание исполняемого тестового набора.
//  Содержит данные необходимые для выполнения прогона тестов
// Параметры:
//  НаборТестов - См. ОписаниеТестовогоНабора
//  ТестовыйМодуль - См. ОписаниеТестовогоМодуля
// 
// Возвращаемое значение:
//  Структура - Описание исполняемого набора тестов:
// * Имя - Строка - Имя набора
// * Представление - Строка - Представление набора
// * Теги - Массив из Строка - Тэги набора
// * Ошибки - Массив из см. ЮТФабрика.ОписаниеВозникшейОшибки - Описания ошибок выполнения теста
// * Режим - Строка - Режим исполнения набора, см. КонтекстыВызова
// * МетаданныеМодуля - см. ЮТФабрика.ОписаниеМодуля
// * Тесты - Массив из см. ОписаниеИсполняемогоТеста - Тесты набора, структуру тестов см. ОписаниеИсполняемогоТеста
// * Выполнять - Булево - Признак, что можно выполнить прогон набора (нет ошибок блокирующих запуск) 
// * ДатаСтарта - Число - Дата запуска набора
// * Длительность - Число - Продолжительность выполнения набора
// * НастройкиВыполнения - Структура - Настройки исполнения теста
// * ТестовыйМодуль - См. ОписаниеТестовогоМодуля
Функция ОписаниеИсполняемогоНабораТестов(НаборТестов, ТестовыйМодуль) Экспорт
	
	Описание = Новый Структура();
	
	Описание.Вставить("Имя", НаборТестов.Имя);
	Описание.Вставить("Представление", НаборТестов.Представление);
	Описание.Вставить("Теги", НаборТестов.Теги);
	Описание.Вставить("Ошибки", ЮТОбщий.СкопироватьМассив(НаборТестов.Ошибки));
	Описание.Вставить("Режим", "");
	Описание.Вставить("ТестовыйМодуль", ТестовыйМодуль);
	Описание.Вставить("МетаданныеМодуля", ТестовыйМодуль.МетаданныеМодуля);
	Описание.Вставить("Тесты", Новый Массив);
	Описание.Вставить("Выполнять", Описание.Ошибки.Количество() = 0);
	Описание.Вставить("ДатаСтарта", 0);
	Описание.Вставить("Длительность", 0);
	Описание.Вставить("НастройкиВыполнения", НаборТестов.НастройкиВыполнения);
	
	Возврат Описание;
	
КонецФункции

// ОписаниеИсполняемогоТеста
//  Возвращает описание исполняемого теста
//  Содержит данные необходимые для выполнения прогона тестов
// 
// Параметры:
//  Тест - См. ОписаниеТеста
//  Режим - См. КонтекстыВызова
//  ТестовыйМодуль - См. ОписаниеТестовогоМодуля
// 
// Возвращаемое значение:
//  Структура - Описание исполняемого теста:
// * Имя - Строка - Имя/представление теста
// * Метод - Строка - Имя тестового метода
// * ПолноеИмяМетода - Строка - Полное имя тестового метода, ИмяМодуля.ИмяМетода
// * Теги - Массив из Строка - Теги теста
// * Режим - Строка - Режим исполнения теста, см. КонтекстыВызова
// * ДатаСтарта - Число - Дата запуска теста
// * Длительность - Число - Продолжительность выполнения теста
// * Статус - Строка - Статус выполнения теста, см. СтатусыИсполненияТеста
// * Ошибки - Массив из см. ЮТФабрика.ОписаниеВозникшейОшибки - Описания ошибок выполнения теста, см. ЮТФабрика.ОписаниеВозникшейОшибки
// * НастройкиВыполнения- Структура - Настройки исполнения теста
// * Параметры - Неопределено, Массив из Произвольный - Набор параметров теста
// * НомерВНаборе - Число - Порядковый номер теста в наборе
Функция ОписаниеИсполняемогоТеста(Тест, Режим, ТестовыйМодуль) Экспорт
	
	ПолноеИмяМетода = СтрШаблон("%1.%2", ТестовыйМодуль.МетаданныеМодуля.Имя, Тест.Имя);
	Представление = ПредставлениеТеста(Тест);
	
	ОписаниеТеста = Новый Структура;
	ОписаниеТеста.Вставить("Имя", Представление);
	ОписаниеТеста.Вставить("Метод", Тест.Имя);
	ОписаниеТеста.Вставить("ПолноеИмяМетода", ПолноеИмяМетода);
	ОписаниеТеста.Вставить("Теги", Тест.Теги);
	ОписаниеТеста.Вставить("Режим", Режим);
	ОписаниеТеста.Вставить("ДатаСтарта", 0);
	ОписаниеТеста.Вставить("Длительность", 0);
	ОписаниеТеста.Вставить("Статус", СтатусыИсполненияТеста().Ожидание);
	ОписаниеТеста.Вставить("Ошибки", Новый Массив);
	ОписаниеТеста.Вставить("НастройкиВыполнения", Тест.НастройкиВыполнения);
	ОписаниеТеста.Вставить("Параметры", Тест.Параметры);
	ОписаниеТеста.Вставить("НомерВНаборе", Тест.НомерВНаборе);
	
	//@skip-check constructor-function-return-section
	Возврат ОписаниеТеста;
	
КонецФункции

// ПараметрыЗапуска
//  Набор параметров подсистемы тестирования. 
//  Параметры на английском, чтобы не держать несколько реализаций чтения и обработки параметров
// 
// Возвращаемое значение:
//  Структура - Параметры:
// * ВыполнятьМодульноеТестирование - Булево - Признак необходимости выполнения тестов
// * reportPath - Строка - Файл или каталог сохранения отчета о тестировании
// * filter - см. ПараметрыФильтрации
// * settings - см. НастройкиВыполнения
// * closeAfterTests - Булево - Признак необходимости закрытия приложения по окончании прогона
// * reportFormat - Строка - Формат отчета о тестировании. 
//                  Модули реализующие различные форматы отчетов собраны в подсистеме ЮТФормированиеОтчета
// * logging - см. ПараметрыЛогирования
// * showReport - Булево - Признак необходмости отобразить отчет в 1с по окончании тестирования
// * exitCode - Строка - Путь к файлу, в который будет записан коды выхода
// * ПодключатьВнешниеКомпоненты - Булево - Выполнять установку и подключение внешних компонент при старте.
//                                 Если выключено и включен запрет синхронных вызовов, то компоненты не будут доступы в тонком клиенте. 
//                                 Если выключено и разрешены синхронные вызовы, то компоненты можно установить вручную и тогда они будут доступны на клиенте. 
Функция ПараметрыЗапуска() Экспорт
	
	Параметры = Новый Структура;
	
	Параметры.Вставить("ВыполнятьМодульноеТестирование", Ложь);
	
	Параметры.Вставить("reportPath", "");
	Параметры.Вставить("closeAfterTests", Истина);
	Параметры.Вставить("filter", ПараметрыФильтрации());
	Параметры.Вставить("settings", НастройкиВыполнения());
	Параметры.Вставить("reportFormat", "jUnit");
	Параметры.Вставить("showReport", Ложь);
	Параметры.Вставить("logging", ПараметрыЛогирования());
	Параметры.Вставить("exitCode", "");
	
	Параметры.Вставить("ПодключатьВнешниеКомпоненты", Истина);
	
	Возврат Параметры;
	
КонецФункции

// ОписаниеКонтекстаОшибки
//  Возвращает описание деталей/расшифровки ошибки
// Возвращаемое значение:
//  Структура - Детали ошибки:
// * ОшибкаУтверждения - Булево - Признак, это ошибка проверки утверждения
// * ПроверяемоеЗначение - Произвольный - Фактическое значение
// * ОжидаемоеЗначение - Произвольный - Ожидаемое значение
// * Сообщение - Строка
Функция ОписаниеКонтекстаОшибки() Экспорт
	
	Описание = Новый Структура("ПроверяемоеЗначение, ОжидаемоеЗначение");
	Описание.Вставить("ОшибкаУтверждения", Ложь);
	Описание.Вставить("Сообщение", "");
	
	//@skip-check constructor-function-return-section
	Возврат Описание;
	
КонецФункции

// ОписаниеМодуля
//  Возвращает структуру описания модуля
// Возвращаемое значение:
//  Структура - Описание модуля:
// * Имя - Строка - Имя модуля
// * ПолноеИмя - Строка - Полное имя модуля
// * Расширение - Строка - Имя расширения, владельца модуля
// * КлиентУправляемоеПриложение - Булево - Доступность контекста 
// * КлиентОбычноеПриложение - Булево - Доступность контекста
// * Сервер - Булево - Доступность контекста
// * ВызовСервера - Булево - Доступность контекста
// * Глобальный - Булево - Доступность контекста
Функция ОписаниеМодуля() Экспорт
	
	Описание = Новый Структура;
	Описание.Вставить("Имя", "");
	Описание.Вставить("ПолноеИмя", "");
	Описание.Вставить("Расширение", "");
	Описание.Вставить("КлиентУправляемоеПриложение", Ложь);
	Описание.Вставить("КлиентОбычноеПриложение", Ложь);
	Описание.Вставить("Сервер", Ложь);
	Описание.Вставить("ВызовСервера", Ложь);
	Описание.Вставить("Глобальный", Ложь);
	
	Возврат Описание;
	
КонецФункции

// ОписаниеВозникшейОшибки
//  Возвращает базовую структуру ошибки
// 
// Параметры:
//  Сообщение - Строка
// 
// Возвращаемое значение:
//  Структура - Описание возникшей ошибки:
// * Сообщение - Строка - Описание возникшей ошибки
// * Стек - Строка - Стек возникшей ошибки
// * ТипОшибки - Строка - Тип возникшей ошибки. Доступные значения см. ЮТФабрика.ТипыОшибок
Функция ОписаниеВозникшейОшибки(Сообщение) Экспорт
	
	Возврат Новый Структура("Сообщение, Стек, ТипОшибки", Сообщение, "", "");
	
КонецФункции

// Возвращает базовую структуру ошибки проверки факта и ожидания
// 
// Параметры:
//  Сообщение - Строка
// 
// Возвращаемое значение:
//  Структура - Описание возникшей ошибки:
// * Сообщение - Строка - Описание возникшей ошибки
// * Стек - Строка - Стек возникшей ошибки
// * ТипОшибки - Строка - Тип возникшей ошибки. Доступные значения см. ЮТФабрика.ТипыОшибок
// * ПроверяемоеЗначение - Произвольный - Проверяемое, фактическое значение
// * ОжидаемоеЗначение - Произвольный - Ожидаемое значение
Функция ОписаниеОшибкиСравнения(Сообщение) Экспорт
	
	Описание = ОписаниеВозникшейОшибки(Сообщение);
	Описание.ТипОшибки = ТипыОшибок().Утверждений;
	Описание.Вставить("ПроверяемоеЗначение");
	Описание.Вставить("ОжидаемоеЗначение");
	
	//@skip-check constructor-function-return-section
	Возврат Описание;
	
КонецФункции

// Возвращает базовую структуру ошибки пропуска теста
// 
// Параметры:
//  Сообщение - Строка
// 
// Возвращаемое значение:
//  Структура - Описание возникшей ошибки:
// * Сообщение - Строка - Описание возникшей ошибки
// * Стек - Строка - Стек возникшей ошибки
// * ТипОшибки - Строка - Тип возникшей ошибки. Доступные значения 
//   См. ЮТФабрика.ТипыОшибок
Функция ОписаниеОшибкиПропуска(Сообщение) Экспорт
	
	Описание = ОписаниеВозникшейОшибки(Сообщение);
	Описание.ТипОшибки = ТипыОшибок().Пропущен;
	
	Возврат Описание;
	
КонецФункции

// Описание события исполнения тестов.
// 
// Параметры:
//  Модуль - см. ЮТФабрика.ОписаниеТестовогоМодуля
//  Набор 	- см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов
//  Тест 	- см. ЮТФабрика.ОписаниеИсполняемогоТеста
// 
// Возвращаемое значение:
//  Структура - Описание события исполнения тестов:
// * Модуль - см. ЮТФабрика.ОписаниеТестовогоМодуля
// * Набор 	- см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов 
// * Тест 	- см. ЮТФабрика.ОписаниеИсполняемогоТеста
Функция ОписаниеСобытияИсполненияТестов(Модуль, Набор = Неопределено, Тест = Неопределено) Экспорт
	
	Описание = Новый Структура();
	Описание.Вставить("Модуль", Модуль);
	Описание.Вставить("Набор", Набор);
	Описание.Вставить("Тест", Тест);
	
	//@skip-check constructor-function-return-section
	Возврат Описание;
	
КонецФункции

// Описание категория набора тестов.
// 
// Параметры:
//  ТестовыйМодуль - см. ЮТФабрика.ОписаниеТестовогоМодуля
// 
// Возвращаемое значение:
//  Структура - Описание категория набора тестов:
// * ТестовыйМодуль - см. ЮТФабрика.ОписаниеТестовогоМодуля
// * Клиентские - Массив из см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов
// * Серверные - Массив из см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов
// * Пропущенные - Массив из см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов
Функция ОписаниеКатегорияНабораТестов(ТестовыйМодуль) Экспорт
	
	КатегорииНаборов = Новый Структура();
	КатегорииНаборов.Вставить("ТестовыйМодуль", ТестовыйМодуль);
	КатегорииНаборов.Вставить("Клиентские",  Новый Массив());
	КатегорииНаборов.Вставить("Серверные",   Новый Массив());
	КатегорииНаборов.Вставить("Пропущенные", Новый Массив());
	
	//@skip-check constructor-function-return-section
	Возврат КатегорииНаборов;
	
КонецФункции

// Формирует описание проверяемого значения.
// Используется в утверждения для формирования дружелюбного сообщения об ошибке.
// 
// Параметры:
//  ПроверяемоеЗначение - Произвольный - Проверяемое значение
// 
// Возвращаемое значение:
//  Структура - Описание проверяемого значения:
// * Значение - Произвольный
// * Представление - Строка - Представление объекта
//                 - Неопределено - Если не указано тогда используется платформенное предсталение (`Строка(Значение)`) 
// * ИмяСвойства - Строка, Число, Неопределено - Имя проверяемого реквизита, индекса
Функция ОписаниеПроверяемогоЗначения(ПроверяемоеЗначение) Экспорт
	
	Описание = Новый Структура();
	Описание.Вставить("Значение", ПроверяемоеЗначение);
	Описание.Вставить("Представление", Неопределено);
	Описание.Вставить("ИмяСвойства", Неопределено);
	
	Возврат Описание;
	
КонецФункции

// Описание проверки.
// 
// Параметры:
//  ПроверяемоеЗначение - Произвольный
// 
// Возвращаемое значение:
//  Структура - Описание проверки:
// * ОбъектПроверки - см. ОписаниеПроверяемогоЗначения
// * ПрефиксОшибки - Строка, Неопределено -
// * ОписаниеПроверки - Строка, Неопределено -
Функция ОписаниеПроверки(ПроверяемоеЗначение) Экспорт
	
	Описание = Новый Структура();
	Описание.Вставить("ОбъектПроверки", ОписаниеПроверяемогоЗначения(ПроверяемоеЗначение));
	Описание.Вставить("ПрефиксОшибки", Неопределено);
	Описание.Вставить("ОписаниеПроверки", Неопределено);
	
	Возврат Описание;
	
КонецФункции

// Описание реквизита объекта метаданных
// 
// Параметры:
//  Реквизит - ОбъектМетаданных
//  ЭтоКлюч - Булево - Это ключевой реквизит (ссылка, измерение)
// 
// Возвращаемое значение:
//  Структура - Описание реквизита:
// * Имя - Строка
// * Тип - ОписаниеТипов
// * Обязательный - Булево
// * ЭтоКлюч - Булево
Функция ОписаниеРеквизита(Знач Реквизит, Знач ЭтоКлюч) Экспорт
	
	Описание = Новый Структура();
	Описание.Вставить("Имя", Реквизит.Имя);
	Описание.Вставить("Тип", Реквизит.Тип);
	Описание.Вставить("Обязательный", Реквизит.ПроверкаЗаполнения = ПроверкаЗаполнения.ВыдаватьОшибку);
	Описание.Вставить("ЭтоКлюч", ЭтоКлюч);
	
	Возврат Описание;
	
КонецФункции

#КонецОбласти

#Область КонструкторыКонтекстов

// Данные контекста исполнения.
// 
// Возвращаемое значение:
//  Структура - Данные контекста исполнения:
//  * Уровень - Строка - Возможные значения см. УровниИсполнения
//  * Модуль  - Неопределено - Нет исполняемого модуля
//            - см. ОписаниеТестовогоМодуля
//  * Набор   - Неопределено - Нет исполняемого тестового набора
//            - см. ОписаниеИсполняемогоНабораТестов
//  * Тест    - Неопределено - Нет исполняемого теста
//            - см. ОписаниеИсполняемогоТеста
Функция НовыйКонтекстИсполнения() Экспорт
	
	Контекст = Новый Структура();
	Контекст.Вставить("Уровень", "");
	Контекст.Вставить("Модуль", Неопределено);
	Контекст.Вставить("Набор", Неопределено);
	Контекст.Вставить("Тест", Неопределено);
	
	Возврат Контекст;
	
КонецФункции

// Описание результата проверки.
// 
// Параметры:
//  Успешно - Булево - Успешно
// 
// Возвращаемое значение:
//  Структура - Описание результата проверки:
// * Сообщения - Массив из Произвольный
// * Успешно - Булево
Функция ОписаниеРезультатаПроверки(Успешно = Истина) Экспорт
	
	Описание = Новый Структура();
	Описание.Вставить("Сообщения", Новый Массив);
	Описание.Вставить("Успешно", Истина);
	
	Возврат Описание;
	
КонецФункции

// Выражение предиката.
// 
// Параметры:
//  ВидСравнения - Строка - см. ЮТПредикаты.Выражения
//  ИмяРеквизита - Строка - Имя реквизита
//  Значение - Произвольный - Значение
// 
// Возвращаемое значение:
//  Структура - Выражение предиката:
// * ИмяРеквизита - Неопределено, Строка - Имя проверяемого реквизита
// * ВидСравнения - Строка
// * Значение - Произвольный, Неопределено - Операнд выражения
Функция ВыражениеПредиката(ВидСравнения, ИмяРеквизита = Неопределено, Значение = Неопределено) Экспорт
	
	Выражение = Новый Структура();
	ЮТОбщий.УказатьТипСтруктуры(Выражение, "Предикат");
	
	Выражение.Вставить("ИмяРеквизита", ИмяРеквизита);
	Выражение.Вставить("ВидСравнения", ВидСравнения);
	Выражение.Вставить("Значение", Значение);
	
	Возврат Выражение;
	
КонецФункции

#КонецОбласти

// КонтекстыМодуля
//  Возвращает коллекцию доступных контекстов выполнения модуля
// Параметры:
//  Модуль - См. ОписаниеМодуля
// 
// Возвращаемое значение:
//  Массив из Строка - Контексты модуля, возможные значения см. КонтекстыВызова
Функция КонтекстыМодуля(Модуль) Экспорт
	
	Контексты = КонтекстыВызова();
	
	КонтекстыМодуля = Новый Массив();
	
	Если Модуль.Сервер Тогда
		КонтекстыМодуля.Добавить(Контексты.Сервер);
	КонецЕсли;
	
	Если Модуль.КлиентУправляемоеПриложение Тогда
		КонтекстыМодуля.Добавить(Контексты.КлиентУправляемоеПриложение);
	КонецЕсли;
	
	Если Модуль.КлиентОбычноеПриложение Тогда
		КонтекстыМодуля.Добавить(Контексты.КлиентОбычноеПриложение);
	КонецЕсли;
	
	Возврат КонтекстыМодуля;

КонецФункции

// КонтекстыПриложения
//  Возвращает коллекцию доступных контекстов приложения
// Возвращаемое значение:
//  Массив из Строка - Контексты приложения, возможные значения см. КонтекстыВызова
Функция КонтекстыПриложения() Экспорт

#Если НЕ Клиент Тогда
	ВызватьИсключение "Метод получения контекстов приложения должен вызываться с клиента";
#КонецЕсли

	Контексты = КонтекстыВызова();
	КонтекстыПриложения = Новый Массив();
	
	КонтекстыПриложения.Добавить(Контексты.Сервер);
	КонтекстыПриложения.Добавить(Контексты.ВызовСервера);
	
#Если ТолстыйКлиентОбычноеПриложение Тогда
	КонтекстыПриложения.Добавить(Контексты.КлиентОбычноеПриложение);
#ИначеЕсли ТолстыйКлиентУправляемоеПриложение Или ТонкийКлиент Тогда
	КонтекстыПриложения.Добавить(Контексты.КлиентУправляемоеПриложение);
#КонецЕсли
	
	Возврат КонтекстыПриложения;
	
КонецФункции

// КонтекстИсполнения
//  Возвращает контекст исполнения по контексту вызова
// Параметры:
//  КонтекстВызова - Строка - Контекст вызова, см. ЮТФабрика.КонтекстыВызова
// 
// Возвращаемое значение:
//  Неопределено, Строка - Контекст исполнения
Функция КонтекстИсполнения(КонтекстВызова) Экспорт
	
	КонтекстыВызова = КонтекстыВызова();
	
	Если КонтекстВызова = КонтекстыВызова.Сервер Тогда
		
		Возврат КонтекстыИсполнения().Сервер;
		
	ИначеЕсли КонтекстВызова = КонтекстыВызова.КлиентУправляемоеПриложение
		ИЛИ КонтекстВызова = КонтекстыВызова.КлиентОбычноеПриложение
		ИЛИ КонтекстВызова = КонтекстыВызова.ВызовСервера Тогда
		
		Возврат КонтекстыИсполнения().Клиент;
		
	Иначе
		
		Возврат Неопределено;
		
	КонецЕсли;
	
КонецФункции

// Формирует представление теста
// 
// Параметры:
//  Тест - см. ОписаниеТеста
// 
// Возвращаемое значение:
//  Строка - Представление теста
Функция ПредставлениеТеста(Тест) Экспорт
	
	Если ЗначениеЗаполнено(Тест.Представление) Тогда
		Представление = Тест.Представление;
	ИначеЕсли ЗначениеЗаполнено(Тест.Параметры) Тогда
		ПредставлениеПараметров = СтрСоединить(Тест.Параметры, ", ");
		Представление = СтрШаблон("%1(%2)", Тест.Имя, ПредставлениеПараметров);
	Иначе
		Представление = Тест.Имя;
	КонецЕсли;
	
	Возврат Представление;
	
КонецФункции

Функция ПараметрыСозданияОбъектов(Знач ПараметрыЗаписи = Неопределено, ФикцияОбязательныхПолей = Ложь) Экспорт
	
	Если ПараметрыЗаписи = Неопределено Тогда
		ПараметрыЗаписи = ПараметрыЗаписи();
	Иначе
		ВходныеПараметрыЗаписи = ПараметрыЗаписи;
		ПараметрыЗаписи = ПараметрыЗаписи();
		ЗаполнитьЗначенияСвойств(ПараметрыЗаписи, ВходныеПараметрыЗаписи);
	КонецЕсли;
	
	Возврат Новый Структура("ФикцияОбязательныхПолей, ПараметрыЗаписи", ФикцияОбязательныхПолей, ПараметрыЗаписи);
	
КонецФункции

Функция ПараметрыЗаполненияТаблицыЗначений(Знач ПараметрыСозданияОбъектов = Неопределено) Экспорт
	
	Если ПараметрыСозданияОбъектов = Неопределено Тогда
		ПараметрыСозданияОбъектов = ПараметрыСозданияОбъектов();
	Иначе
		ВходныеПараметрыСозданияОбъектов = ПараметрыСозданияОбъектов;
		ПараметрыСозданияОбъектов = ПараметрыСозданияОбъектов();
		ЗаполнитьЗначенияСвойств(ПараметрыСозданияОбъектов, ВходныеПараметрыСозданияОбъектов);
	КонецЕсли;
	
	Возврат Новый ФиксированнаяСтруктура("СозданиеОбъектовМетаданных", ПараметрыСозданияОбъектов);
	
КонецФункции

// Параметры генератора отчета.
// Описывает предоставляемые модулем форматы отчетов
// 
// Возвращаемое значение:
//  Структура - Параметры генератора отчета:
// * Форматы - Структура - Форматы отчетов, предоставляемые модулем 
Функция ПараметрыГенератораОтчета() Экспорт
	
	Параметры = Новый Структура();
	Параметры.Вставить("Форматы", Новый Структура);
	
	Возврат Параметры;
	
КонецФункции

// Описание формата отчета.
// 
// Параметры:
//  Идентификатор - Строка - Уникальный идентификатор формата отчета
//  Представление - Строка - Пользовательское представление отчета, выводится в форму настроек тестирования
// 
// Возвращаемое значение:
//  Структура - Описание формата отчета:
// * Идентификатор - Строка - Уникальный идентификатор формата отчета
// * Представление - Строка - Пользовательское представление отчета, выводится в форму настроек тестирования
// * ЗаписьВКаталог - Булево - Отчет записывается в каталог, в этом случае должен быть установлен призак `СамостоятельнаяЗаписьОтчета`
// * ФильтрВыбораФайла - Строка - Фильтр выбора, используется в форме настроек тестирования
// * ИмяФайлаПоУмолчанию - Строка - Для отчетов, записываемых в файл, имя файла если в параметрах указан каталог
// * СамостоятельнаяЗаписьОтчета - Булево - Способ записи отчета в файлы.
//											Истина - Модуль формирования отчета самостоятельно записывает отчет
//											Ложь - Модуль формирования отчета генерирует данные, которые записываются движком
Функция ОписаниеФорматаОтчета(Идентификатор, Представление) Экспорт
	
	Описание = Новый Структура();
	Описание.Вставить("Идентификатор", Идентификатор);
	Описание.Вставить("Представление", Представление);
	Описание.Вставить("ЗаписьВКаталог", Ложь);
	Описание.Вставить("ФильтрВыбораФайла", "");
	Описание.Вставить("ИмяФайлаПоУмолчанию", "");
	Описание.Вставить("СамостоятельнаяЗаписьОтчета", Ложь);
	
	Возврат Описание;
	
КонецФункции
#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// ПараметрыФильтрации
// 	Возвращает структуру отборов для поиска тестов
// Возвращаемое значение:
//  Структура - Параметры фильтрации:
// * extensions - Неопределено - Нет фильтрации по расширениям
//              - Массив из Строка - Список тестовых расширений
// * modules - Неопределено - Нет фильтрации по модулям
//           - Массив из Строка - Список тестовых модулей
// * suites - Неопределено - Нет фильтрации по тестовым наборам
//          - Массив из Строка - Список тестовых наборов
// * paths - Неопределено - Нет фильтрации по путям
//         - Массив из Строка - Список путей до тестовых методов, путь может быть не полным.
// 									Например: 
// 									+ tests - Ищем тесты в расширении tests
// 									+ tests.ОМ_ОбщегоНазначения - Ищем тесты в модуле ОМ_ОбщегоНазначения расширения tests
// 									+ tests.ОМ_ОбщегоНазначения.ПолучитьЗначениеРеквизита - указание конкретного теста
// * tags - Неопределено - Нет фильтрации по тегам
//        - Массив из Строка - Список тэгов
// * contexts - Неопределено - Нет фильтрации по контекстам
//            - Массив из Строка - Список тестируемых контекстов
// * tests - Неопределено - Нет фильтрации по тестам
//         - Массив из Строка - Список полных имен тестовых методов. ИмяМодуля.ИмяМетода{.Контекст}
Функция ПараметрыФильтрации() Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("extensions", Неопределено);
	Параметры.Вставить("modules", Неопределено);
	Параметры.Вставить("suites", Неопределено);
	Параметры.Вставить("tags", Неопределено);
	Параметры.Вставить("contexts", Неопределено);
	Параметры.Вставить("paths", Неопределено);
	Параметры.Вставить("tests", Неопределено);
	
	Возврат Параметры;
	
КонецФункции

Функция НастройкиВыполнения() Экспорт
	
	Настройки = Новый Структура();
	
	ПараметрыИсполнения = ПараметрыИсполненияТеста();
	Настройки.Вставить(ПараметрыИсполнения.ВТранзакции, Ложь);
	
	Возврат Настройки;
	
КонецФункции

Функция ПараметрыЛогирования() Экспорт
	
	Параметры = Новый Структура();
	Параметры.Вставить("file", "");
	Параметры.Вставить("console", Ложь);
	Параметры.Вставить("enable", Неопределено);
	Параметры.Вставить("level", ЮТЛогирование.УровниЛога().Отладка);
	
	Возврат Параметры;
	
КонецФункции

#КонецОбласти
