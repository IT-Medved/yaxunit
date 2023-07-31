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

#Область СлужебныйПрограммныйИнтерфейс

Процедура Инициализация(ПараметрыЗапуска) Экспорт
	
	Параметры = ЮТОбщий.ЗначениеВМассиве(ПараметрыЗапуска);
	ВызватьОбработчикРасширения("Инициализация", Параметры);
	
КонецПроцедуры

#Область СобытияИсполненияТестов

// Обработчик события "ПередВсемиТестамиМодуля"
// 
// Параметры:
//  ТестовыйМодуль - см. ЮТФабрика.ОписаниеТестовогоМодуля
Процедура ПередВсемиТестамиМодуля(ТестовыйМодуль) Экспорт
	
	Уровни = ЮТФабрика.УровниИсполнения();
	КонтекстИсполнения = ЮТКонтекст.КонтекстИсполнения();
	КонтекстИсполнения.Уровень = Уровни.Модуль;
	КонтекстИсполнения.Модуль = ТестовыйМодуль;
	
	ЮТКонтекст.УстановитьКонтекстМодуля();
	
	ОписаниеСобытия = ЮТФабрика.ОписаниеСобытияИсполненияТестов(ТестовыйМодуль);
	ВызватьОбработкуСобытия("ПередВсемиТестами", ОписаниеСобытия);
	
КонецПроцедуры

// Обработчик события "ПередТестовымНабором"
// 
// Параметры:
//  ТестовыйМодуль - см. ЮТФабрика.ОписаниеТестовогоМодуля
//  Набор - см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов
Процедура ПередТестовымНабором(ТестовыйМодуль, Набор) Экспорт
	
	Уровни = ЮТФабрика.УровниИсполнения();
	КонтекстИсполнения = ЮТКонтекст.КонтекстИсполнения();
	КонтекстИсполнения.Уровень = Уровни.НаборТестов;
	КонтекстИсполнения.Набор = Набор;
	
	ЮТКонтекст.УстановитьКонтекстНабораТестов();
	
	ОписаниеСобытия = ЮТФабрика.ОписаниеСобытияИсполненияТестов(ТестовыйМодуль, Набор);
	ВызватьОбработкуСобытия("ПередТестовымНабором", ОписаниеСобытия);
	
КонецПроцедуры

// Обработчик события "ПередКаждымТестом"
// 
// Параметры:
//  ТестовыйМодуль - см. ЮТФабрика.ОписаниеТестовогоМодуля
//  Набор - см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов
//  Тест - см. ЮТФабрика.ОписаниеИсполняемогоТеста
Процедура ПередКаждымТестом(ТестовыйМодуль, Набор, Тест) Экспорт
	
	Уровни = ЮТФабрика.УровниИсполнения();
	КонтекстИсполнения = ЮТКонтекст.КонтекстИсполнения();
	КонтекстИсполнения.Уровень = Уровни.Тест;
	КонтекстИсполнения.Тест = Тест;
	
	ОписаниеСобытия = ЮТФабрика.ОписаниеСобытияИсполненияТестов(ТестовыйМодуль, Набор, Тест);
	ЮТКонтекст.УстановитьКонтекстТеста();
	
#Если Сервер ИЛИ ТолстыйКлиентОбычноеПриложение ИЛИ ТолстыйКлиентУправляемоеПриложение Тогда
	ПолучитьСообщенияПользователю(Истина);
#КонецЕсли
	
#Если Сервер ИЛИ ТолстыйКлиентОбычноеПриложение ИЛИ ТолстыйКлиентУправляемоеПриложение Тогда
	Если ЮТНастройкиВыполнения.ВТранзакции() Тогда
		НачатьТранзакцию();
	КонецЕсли;
#КонецЕсли
	
	ВызватьОбработкуСобытий(ЮТОбщий.ЗначениеВМассиве("ПередКаждымТестом", "ПередТестом"), ОписаниеСобытия);
	
КонецПроцедуры

// Обработчик события "ПослеКаждогоТеста"
// 
// Параметры:
//  ТестовыйМодуль - см. ЮТФабрика.ОписаниеТестовогоМодуля
//  Набор - см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов
//  Тест - см. ЮТФабрика.ОписаниеИсполняемогоТеста
Процедура ПослеКаждогоТеста(ТестовыйМодуль, Набор, Тест) Экспорт
	
	ОписаниеСобытия = ЮТФабрика.ОписаниеСобытияИсполненияТестов(ТестовыйМодуль, Набор, Тест);
	
	ВызватьОбработкуСобытий(ЮТОбщий.ЗначениеВМассиве("ПослеТеста", "ПослеКаждогоТеста"), ОписаниеСобытия);
	
#Если Сервер ИЛИ ТолстыйКлиентОбычноеПриложение ИЛИ ТолстыйКлиентУправляемоеПриложение Тогда
	Если ЮТНастройкиВыполнения.ВТранзакции() Тогда
		ОтменитьТранзакцию();
		Пока ТранзакцияАктивна() Цикл
			ОтменитьТранзакцию();
			ЮТОбщий.СообщитьПользователю("Обнаружена незакрытая транзакция");
		КонецЦикла;
	КонецЕсли;
#КонецЕсли
	
	Уровни = ЮТФабрика.УровниИсполнения();
	КонтекстИсполнения = ЮТКонтекст.КонтекстИсполнения();
	КонтекстИсполнения.Уровень = Уровни.НаборТестов;
	КонтекстИсполнения.Тест = Неопределено;
	
КонецПроцедуры

// Обработчик события "ПослеТестовогоНабора"
// 
// Параметры:
//  ТестовыйМодуль - см. ЮТФабрика.ОписаниеТестовогоМодуля
//  Набор - см. ЮТФабрика.ОписаниеИсполняемогоНабораТестов
Процедура ПослеТестовогоНабора(ТестовыйМодуль, Набор) Экспорт
	
	ОписаниеСобытия = ЮТФабрика.ОписаниеСобытияИсполненияТестов(ТестовыйМодуль, Набор);
	ВызватьОбработкуСобытия("ПослеТестовогоНабора", ОписаниеСобытия);
	
	Уровни = ЮТФабрика.УровниИсполнения();
	КонтекстИсполнения = ЮТКонтекст.КонтекстИсполнения();
	КонтекстИсполнения.Уровень = Уровни.Модуль;
	КонтекстИсполнения.Набор = Неопределено;
	
КонецПроцедуры

// Обработчик события "ПослеВсехТестовМодуля"
// 
// Параметры:
//  ТестовыйМодуль - см. ЮТФабрика.ОписаниеТестовогоМодуля
Процедура ПослеВсехТестовМодуля(ТестовыйМодуль) Экспорт
	
	ОписаниеСобытия = ЮТФабрика.ОписаниеСобытияИсполненияТестов(ТестовыйМодуль);
	ВызватьОбработкуСобытия("ПослеВсехТестов", ОписаниеСобытия);
	
	КонтекстИсполнения = ЮТКонтекст.КонтекстИсполнения();
	КонтекстИсполнения.Уровень = Неопределено;
	КонтекстИсполнения.Модуль = Неопределено;
	
КонецПроцедуры

Процедура ПередВыполнениемТестов(КоллекцияНаборовТестов) Экспорт
	
	Параметры = ЮТОбщий.ЗначениеВМассиве(КоллекцияНаборовТестов);
	ВызватьОбработчикРасширения("ПередВыполнениемТестов", Параметры);
	
КонецПроцедуры

Процедура ПослеВыполненияТестов(РезультатТестирования) Экспорт
	
	Параметры = ЮТОбщий.ЗначениеВМассиве(РезультатТестирования);
	ВызватьОбработчикРасширения("ПослеВыполненияТестов", Параметры);
	
КонецПроцедуры

#КонецОбласти

#Область СобытияЗагрузкиТестов

// Обработка события "ПередЧтениеСценариев"
Процедура ПередЧтениеСценариев() Экспорт
	
	Параметры = Новый Массив();
	ВызватьОбработчикРасширения("ПередЧтениеСценариев", Параметры);
	
КонецПроцедуры

// Обработчик события "ПередЧтениемСценариевМодуля"
//  Позволяет настроить базовые параметры перед чтением настроек тестов модуля
// Параметры:
//  МетаданныеМодуля - см. ЮТФабрика.ОписаниеМодуля
Процедура ПередЧтениемСценариевМодуля(МетаданныеМодуля) Экспорт
	
	Параметры = ЮТОбщий.ЗначениеВМассиве(МетаданныеМодуля);
	ВызватьОбработчикРасширения("ПередЧтениемСценариевМодуля", Параметры);
	
КонецПроцедуры

// После чтения сценариев модуля.
//  Позволяет настроить/обработать параметры загруженных настроек тестов модуля
// Параметры:
//  МетаданныеМодуля - см. ЮТФабрика.ОписаниеМодуля
//  ИсполняемыеСценарии - см. ЮТТесты.СценарииМодуля
Процедура ПослеЧтенияСценариевМодуля(МетаданныеМодуля, ИсполняемыеСценарии) Экспорт
	
	Параметры = ЮТОбщий.ЗначениеВМассиве(МетаданныеМодуля, ИсполняемыеСценарии);
	ВызватьОбработчикРасширения("ПослеЧтенияСценариевМодуля", Параметры);
	
КонецПроцедуры

// Обработка события "ПослеЧтенияСценариев"
// Параметры:
//  Сценарии - Массив из см. ЮТФабрика.ОписаниеТестовогоМодуля - Набор описаний тестовых модулей, которые содержат информацию о запускаемых тестах
Процедура ПослеЧтенияСценариев(Сценарии) Экспорт
	
	Параметры = ЮТОбщий.ЗначениеВМассиве(Сценарии);
	ВызватьОбработчикРасширения("ПослеЧтенияСценариев", Параметры);
	
КонецПроцедуры

// Обработка события "ПослеФормированияИсполняемыхНаборовТестов"
// Параметры:
//  ИсполняемыеТестовыеМодули - Массив из см. ЮТФабрика.ОписаниеИсполняемогоТестовогоМодуля - Набор исполняемых наборов
Процедура ПослеФормированияИсполняемыхНаборовТестов(ИсполняемыеТестовыеМодули) Экспорт
	
	Параметры = ЮТОбщий.ЗначениеВМассиве(ИсполняемыеТестовыеМодули);
	ВызватьОбработчикРасширения("ПослеФормированияИсполняемыхНаборовТестов", Параметры);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Процедура ВызватьОбработкуСобытий(События, ОписаниеСобытия)
	
	Для ы = 0 По События.ВГраница() Цикл
		ИмяСобытия = События[ы];
		ПропуститьОбработчикТестовогоМодуля = (ы > 0 И ОбработчикСобытияПереопределен(ИмяСобытия));
		Если ПропуститьОбработчикТестовогоМодуля Тогда
			
			Параметры = ЮТОбщий.ЗначениеВМассиве(ОписаниеСобытия);
			Ошибки = ВызватьОбработчикРасширения(ИмяСобытия, Параметры);
			ЗарегистрироватьОшибкиСобытияИсполнения(ИмяСобытия, ОписаниеСобытия, Ошибки);
			
		Иначе
			
			ВызватьОбработкуСобытия(ИмяСобытия, ОписаниеСобытия);
			
		КонецЕсли;
	КонецЦикла;
	
КонецПроцедуры

Процедура ВызватьОбработкуСобытия(ИмяСобытия, ОписаниеСобытия)
	
	Параметры = ЮТОбщий.ЗначениеВМассиве(ОписаниеСобытия);
	
	Если ЭтоСобытиеПеред(ИмяСобытия) Тогда
		Ошибки = ВызватьОбработчикРасширения(ИмяСобытия, Параметры);
		ВызватьОбработчикТестовогоМодуля(ИмяСобытия, ОписаниеСобытия);
	Иначе
		ВызватьОбработчикТестовогоМодуля(ИмяСобытия, ОписаниеСобытия);
		Ошибки = ВызватьОбработчикРасширения(ИмяСобытия, Параметры);
	КонецЕсли;
	
	ЗарегистрироватьОшибкиСобытияИсполнения(ИмяСобытия, ОписаниеСобытия, Ошибки);
	
КонецПроцедуры

Функция ВызватьОбработчикРасширения(ИмяСобытия, ПараметрыСобытия)
	
	Ошибки = Новый Массив();
	
	Для Каждого ИмяМодуля Из ЮТРасширения.ОбработчикиСобытий() Цикл
		
		Если ЮТОбщий.МетодМодуляСуществует(ИмяМодуля, ИмяСобытия) Тогда
			ПолноеИмяМетода = СтрШаблон("%1.%2", ИмяМодуля, ИмяСобытия);
			Ошибка = ЮТОбщий.ВыполнитьМетод(ПолноеИмяМетода, ПараметрыСобытия);
			
			Если Ошибка <> Неопределено Тогда
				Ошибки.Добавить(Ошибка);
			КонецЕсли;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Ошибки;
	
КонецФункции

// Вызвать обработчик модуля.
// 
// Параметры:
//  ИмяСобытия - Строка - Имя вызываемого метода обработки события
//  ОписаниеСобытия - см. ЮТФабрика.ОписаниеСобытияИсполненияТестов
// 
Процедура ВызватьОбработчикТестовогоМодуля(Знач ИмяСобытия, ОписаниеСобытия)
	
	ОбработчикСобытияПереопределен = ОбработчикСобытияПереопределен(ИмяСобытия);
	Если ОбработчикСобытияПереопределен Тогда
		ИмяСобытия = ПереопределенноеИмяСобытия(ИмяСобытия);
	КонецЕсли;
	
	ИмяМодуля = ОписаниеСобытия.Модуль.МетаданныеМодуля.Имя;
	
	ЧастиКоманды = СтрРазделить(ИмяСобытия, ".");
	Если ЧастиКоманды.Количество() = 2 Тогда
		ИмяМодуля  = ЧастиКоманды[0];
		ИмяСобытия = ЧастиКоманды[1];
	КонецЕсли;
	
	Ошибки = Новый Массив();
	Команда = СтрШаблон("%1.%2()", ИмяМодуля, ИмяСобытия);
	Если ЮТОбщий.МетодМодуляСуществует(ИмяМодуля, ИмяСобытия) Тогда
		
		Ошибка = ЮТОбщий.ВыполнитьМетод(Команда);
		
		Если Ошибка <> Неопределено Тогда
			Ошибки.Добавить(Ошибка);
		КонецЕсли;
		
	ИначеЕсли ОбработчикСобытияПереопределен Тогда
		
		ТекстИсключения = СтрШаблон("Не найден обработчик тестового модуля %1", Команда);
		ВызватьИсключение ТекстИсключения
		
	КонецЕсли;
	
	ЗарегистрироватьОшибкиСобытияИсполнения(ИмяСобытия, ОписаниеСобытия, Ошибки);
	
КонецПроцедуры

Процедура ЗарегистрироватьОшибкиСобытияИсполнения(ИмяСобытия, ОписаниеСобытия, Ошибки)
	
	Для Каждого Ошибка Из Ошибки Цикл
		ЮТРегистрацияОшибок.ЗарегистрироватьОшибкуСобытияИсполнения(ИмяСобытия, ОписаниеСобытия, Ошибка);
	КонецЦикла;
	
КонецПроцедуры

Функция ОбработчикСобытияПереопределен(ИмяСобытия)
	
	Возврат ЗначениеЗаполнено(ПереопределенноеИмяСобытия(ИмяСобытия));
	
КонецФункции

Функция ПереопределенноеИмяСобытия(ИмяСобытия)
	
	Если ЭтоСобытиеПеред(ИмяСобытия) Тогда
		Возврат ЮТНастройкиВыполнения.Перед();
	ИначеЕсли ЭтоСобытиеПосле(ИмяСобытия) Тогда
		Возврат ЮТНастройкиВыполнения.После();
	Иначе
		Возврат "";
	КонецЕсли;
	
КонецФункции

Функция ЭтоСобытиеПеред(ИмяСобытия)
	
	Возврат СтрНачинаетсяС(ИмяСобытия, "Перед");
	
КонецФункции

Функция ЭтоСобытиеПосле(ИмяСобытия)
	
	Возврат СтрНачинаетсяС(ИмяСобытия, "После");
	
КонецФункции

#КонецОбласти
