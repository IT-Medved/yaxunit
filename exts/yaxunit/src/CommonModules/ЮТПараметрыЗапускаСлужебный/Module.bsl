//©///////////////////////////////////////////////////////////////////////////©//
//
//  Copyright 2021-2025 BIA-Technologies Limited Liability Company
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

// ПараметрыЗапуска
//  Возвращает загруженные параметры запуска тестирования
// Параметры:
//  ПараметрыЗапускаСтрокой - Строка - Строка с параметрами запуска. 
//                                     Содержит ключ запуска и строку с конфигурационным файлом. 
//                                     Формат строки "RunUnitTests=/путь/к/конфигурационному/файлу", 
//                                     где ключ указывается обязательно, а путь - по желанию
//  Обработчик - ОписаниеОповещения
// 
// Возвращаемое значение:
//  см. ЮТФабрика.ПараметрыЗапуска
Функция ПараметрыЗапуска(Знач ПараметрыЗапускаСтрокой, Обработчик) Экспорт
	
	Попытка
		
		ПараметрыЗапускаПредприятия = ПараметрыЗапускаПредприятия(ПараметрыЗапускаСтрокой);
		Параметры = ПрочитатьПараметрыЗапуска(ПараметрыЗапускаПредприятия, Обработчик);
		
	Исключение
		
		ЮТРегистрацияОшибокСлужебный.ЗарегистрироватьОшибкуИнициализацииДвижка(ИнформацияОбОшибке(), "Ошибка чтения параметров запуска");
		Параметры = ЮТФабрика.ПараметрыЗапуска();
		
	КонецПопытки;
	
	Возврат Параметры;
	
КонецФункции

Функция ПараметрыТестированияПоУмолчанию() Экспорт
	
	ПараметрыТестирования = ЮТФабрика.ПараметрыЗапуска();
	ЮТСобытияСлужебный.УстановитьПараметрыЗапускаПоУмолчанию(ПараметрыТестирования);
	
	Возврат ПараметрыТестирования;
	
КонецФункции

Функция КлючЗапуска() Экспорт
	
	Возврат "RunUnitTests";
	
КонецФункции

Функция ЕстьПараметрыЗапускаТестов() Экспорт
	
	Если ПустаяСтрока(ПараметрЗапуска) Тогда
		Возврат Ложь;
	КонецЕсли;
	
	ПараметрыЗапускаПредприятия = ПараметрыЗапускаПредприятия(ПараметрЗапуска);
	Возврат ПараметрыЗапускаПредприятия.Получить(КлючЗапускаНРег()) <> Неопределено;
	
КонецФункции

Функция ПараметрыЗапускаИзФайла(ИмяФайла, Обработчик) Экспорт
	
	Параметры = Новый Соответствие;
	Параметры.Вставить(КлючЗапускаНРег(), ИмяФайла);
	Возврат ПрочитатьПараметрыЗапуска(Параметры, Обработчик);
	
КонецФункции

Функция ФайлПараметровЗапускаТестирования() Экспорт
	
	ПараметрыЗапускаПредприятия = ПараметрыЗапускаПредприятия(ПараметрЗапуска);
	ИмяФайла = ПараметрыЗапускаПредприятия.Получить(КлючЗапускаНРег());
	
	Если ЗначениеЗаполнено(ИмяФайла) И ТипЗнч(ИмяФайла) = Тип("Строка") Тогда
		Возврат ИмяФайла;
	Иначе
		Возврат Неопределено;
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// ПрочитатьПараметрыЗапуска
// 	Читает параметры из строки запуска
// Параметры:
//  ПараметрыЗапускаПредприятия - Соответствие из Произвольный - Соответствие параметров запуска предприятия полученные из `ПараметрЗапуска`
//  Обработчик - ОписаниеОповещения
// 
// Возвращаемое значение:
//  см. ЮТФабрика.ПараметрыЗапуска
Функция ПрочитатьПараметрыЗапуска(ПараметрыЗапускаПредприятия, Обработчик)
	
	ПараметрыТестирования = ЮТФабрика.ПараметрыЗапуска();
	ЗагруженныеПараметрыТестирования = ПереданныеПараметрыТестирования(ПараметрыЗапускаПредприятия);
	
	ВыполнятьТестирование = ЮТКоллекции.ЗначениеСтруктуры(ЗагруженныеПараметрыТестирования, "ВыполнятьМодульноеТестирование", Ложь);
	
	Если ВыполнятьТестирование Тогда
		ЮТСобытияСлужебный.УстановитьПараметрыЗапускаПоУмолчанию(ПараметрыТестирования);
		ДополнитьПараметрыПрочитанными(ПараметрыТестирования, ЗагруженныеПараметрыТестирования);
	КонецЕсли;
	
	ЮТАсинхроннаяОбработкаСлужебныйКлиент.ВызватьОбработчик(Обработчик, Параметрытестирования);
	Возврат Параметрытестирования;
	
КонецФункции

Функция ПереданныеПараметрыТестирования(ПараметрыЗапускаПредприятия)
	
	ПараметрЗапускаТестов = ЮТКоллекции.ЗначениеСоответствия(ПараметрыЗапускаПредприятия, КлючЗапускаНРег(), Ложь);
	
	ТипПараметра = ТипЗнч(ПараметрЗапускаТестов);
	
	Если ТипПараметра = Тип("Булево") Тогда
		
		Параметры = Новый Структура("ВыполнятьМодульноеТестирование, showReport, closeAfterTests");
		Параметры.ВыполнятьМодульноеТестирование = ПараметрЗапускаТестов;
		Параметры.showReport = Истина;
		Параметры.closeAfterTests = Ложь;
		
	ИначеЕсли ТипПараметра <>  Тип("Строка") Или НЕ ЗначениеЗаполнено(ПараметрЗапускаТестов) Тогда
		
		Параметры = Новый Структура;
		
	Иначе
		
		Параметры = ПрочитатьКонфигурационныйФайл(ПараметрЗапускаТестов);
		Параметры.Вставить("ВыполнятьМодульноеТестирование", Истина);
		
	КонецЕсли;
	
	Возврат Параметры;
	
КонецФункции

Функция ПараметрыЗапускаПредприятия(ПараметрыЗапускаСтрокой)
	
	ПарыКлючЗначение = ЮТСтроки.РазделитьСтроку(ПараметрыЗапускаСтрокой, ";");
	
	ПараметрыЗапускаПредприятия = Новый Соответствие;
	
	Для Каждого Пара Из ПарыКлючЗначение Цикл
		
		Если ПустаяСтрока(Пара) Тогда
			Продолжить;
		КонецЕсли;
		
		КлючЗначение = ЮТСтроки.РазделитьСтроку(Пара, "=");
		Ключ = НРег(КлючЗначение[0]);
		
		Если КлючЗначение.Количество() = 1 Тогда
			ПараметрыЗапускаПредприятия.Вставить(Ключ, Истина);
		Иначе
			ПараметрыЗапускаПредприятия.Вставить(Ключ, КлючЗначение[1]);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат ПараметрыЗапускаПредприятия;
	
КонецФункции

Функция ПрочитатьКонфигурационныйФайл(ПутьКФайлу)
	
#Если НЕ ВебКлиент Тогда
	
	Если ЮТОбщий.УстановленБезопасныйРежим() Тогда
		ВызватьИсключение "Расширение подключено в безопасном режиме. Чтение конфигурационного файла недоступно";
	КонецЕсли;
	
	ДанныеФайла = Неопределено;
	
	Попытка
		
		Текст = ЮТФайлы.ДанныеТекстовогоФайла(ПутьКФайлу);
		
		Если ЗначениеЗаполнено(Текст) Тогда
			ДанныеФайла = ЮТОбщий.ЗначениеИзJSON(Текст);
		КонецЕсли;
		
	Исключение
		
		ВызватьИсключение;
		
	КонецПопытки;
	
	Возврат ДанныеФайла;
	
#Иначе
	// будут использованы параметры по умолчанию
	Возврат Новый Структура;
#КонецЕсли

КонецФункции

Процедура ДополнитьПараметрыПрочитанными(Параметры, ДанныеДополнения)
	
	Для Каждого Параметр Из ДанныеДополнения Цикл
		
		Если НЕ Параметры.Свойство(Параметр.Ключ) Тогда
			Продолжить;
		КонецЕсли;
		
		Параметры[Параметр.Ключ] = Параметр.Значение;
		
	КонецЦикла;
	
КонецПроцедуры

Функция КлючЗапускаНРег()
	
	Возврат НРег(КлючЗапуска());
	
КонецФункции

#КонецОбласти
