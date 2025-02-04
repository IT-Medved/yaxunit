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

#Область ПрограммныйИнтерфейс

// Инициализирует новый конструктор вариантов
// 
// Параметры:
//  Реквизиты - Строка - Имена реквизитов варианта разделенные запятыми.
// 
// Возвращаемое значение:
//  ОбщийМодуль - см. ЮТКонструкторВариантов.
Функция Варианты(Реквизиты) Экспорт
	
	Попытка
		//@skip-check module-unused-local-variable
		Проверка = Новый Структура(Реквизиты);
	Исключение
		ВызватьИсключение "Некорректные имена реквизитов вариантов: " + Реквизиты;
	КонецПопытки;
	
	Варианты = Новый Структура("СтрокаРеквизиты, Варианты, КоличествоРеквизитов", Реквизиты, Новый Массив());
	Варианты.Вставить("Реквизиты", СтрРазделить(Реквизиты, ", ", Ложь));
	
	Варианты.КоличествоРеквизитов = Варианты.Реквизиты.Количество();
	
	ЮТКонтекстСлужебный.УстановитьЗначениеКонтекста(КлючКонтекста(), Варианты);
	
	Возврат ЮТКонструкторВариантов;
	
КонецФункции

// Добавляет новый вариант
// 
// Параметры:
//  Параметр1 - Произвольный
//  Параметр2 - Произвольный
//  Параметр3 - Произвольный
//  Параметр4 - Произвольный
//  Параметр5 - Произвольный
//  Параметр6 - Произвольный
//  Параметр7 - Произвольный
// 
// Возвращаемое значение:
//  ОбщийМодуль - см. ЮТКонструкторВариантов.
//@skip-check method-too-many-params
Функция Добавить(Параметр1, // BSLLS:NumberOfOptionalParams-off
				 Параметр2 = Неопределено,
				 Параметр3 = Неопределено,
				 Параметр4 = Неопределено,
				 Параметр5 = Неопределено,
				 Параметр6 = Неопределено,
				 Параметр7 = Неопределено) Экспорт
// BSLLS:MagicNumber-off	
// BSLLS:NumberOfValuesInStructureConstructor-off
	Варианты = ЮТКонтекстСлужебный.ЗначениеКонтекста(КлючКонтекста());
	
	Если Варианты.КоличествоРеквизитов = 1 Тогда
		Вариант = Новый Структура(Варианты.СтрокаРеквизиты, Параметр1);
	ИначеЕсли Варианты.КоличествоРеквизитов = 2 Тогда
		Вариант = Новый Структура(Варианты.СтрокаРеквизиты, Параметр1, Параметр2);
	ИначеЕсли Варианты.КоличествоРеквизитов = 3 Тогда
		Вариант = Новый Структура(Варианты.СтрокаРеквизиты, Параметр1, Параметр2, Параметр3);
	ИначеЕсли Варианты.КоличествоРеквизитов = 4 Тогда
		Вариант = Новый Структура(Варианты.СтрокаРеквизиты, Параметр1, Параметр2, Параметр3, Параметр4);
	ИначеЕсли Варианты.КоличествоРеквизитов = 5 Тогда
		Вариант = Новый Структура(Варианты.СтрокаРеквизиты, Параметр1, Параметр2, Параметр3, Параметр4, Параметр5);
	ИначеЕсли Варианты.КоличествоРеквизитов = 6 Тогда
		Вариант = Новый Структура(Варианты.СтрокаРеквизиты, Параметр1, Параметр2, Параметр3, Параметр4, Параметр5, Параметр6);
	ИначеЕсли Варианты.КоличествоРеквизитов = 7 Тогда
		Вариант = Новый Структура(Варианты.СтрокаРеквизиты, Параметр1, Параметр2, Параметр3, Параметр4, Параметр5, Параметр6, Параметр7);
	КонецЕсли;
// BSLLS:NumberOfValuesInStructureConstructor-on
// BSLLS:MagicNumber-on	
	Варианты.Варианты.Добавить(Вариант);
	
	Возврат ЮТКонструкторВариантов;
	
КонецФункции

// Добавляет варианты всех возможных значений, указанных в параметрах.
// 
// Параметры:
//  ЗначенияПараметра1 - Массив из Произвольный - Доступные значения для первого параметры
//  ЗначенияПараметра2 - Массив из Произвольный - Доступные значения для второго параметры
//  ЗначенияПараметра3 - Массив из Произвольный - Доступные значения для третьего параметры
//  ЗначенияПараметра4 - Массив из Произвольный - Доступные значения для четвертого параметры
//  ЗначенияПараметра5 - Массив из Произвольный - Доступные значения для пятого параметры
//  ЗначенияПараметра6 - Массив из Произвольный - Доступные значения для шестого параметры
//  ЗначенияПараметра7 - Массив из Произвольный - Доступные значения для седьмого параметры
// 
// Возвращаемое значение:
//  ОбщийМодуль - см. ЮТКонструкторВариантов.
// Примеры:
//   ЗначенияРеквизита1 = ЮТКоллекции.ЗначениеВМассиве(1, 2, 3);
//   ЗначенияРеквизита2 = ЮТКоллекции.ЗначениеВМассиве(11, 12, 13);
//   Варианты = ЮТКонструкторВариантов.Варианты("Р1, Р2")
//       .ДобавитьКомбинации(ЗначенияРеквизита1, ЗначенияРеквизита2)
//       .СписокВариантов();
//   // В результате получим такой массив вариантов:
//   [{ "Р1: 1, Р2": 11 },
//    { "Р1: 1, Р2": 12 },
//    { "Р1: 1, Р2": 13 },
//    { "Р1: 2, Р2": 11 },
//    { "Р1: 2, Р2": 12 },
//    { "Р1: 2, Р2": 13 },
//    { "Р1: 3, Р2": 11 },
//    { "Р1: 3, Р2": 12 },
//    { "Р1: 3, Р2": 13 }]
//@skip-check method-too-many-params
Функция ДобавитьКомбинации(ЗначенияПараметра1, // BSLLS:NumberOfOptionalParams-off
						   ЗначенияПараметра2 = Неопределено,
						   ЗначенияПараметра3 = Неопределено,
						   ЗначенияПараметра4 = Неопределено,
						   ЗначенияПараметра5 = Неопределено,
						   ЗначенияПараметра6 = Неопределено,
						   ЗначенияПараметра7 = Неопределено) Экспорт
	
	КоличествоПараметров = 7;
	
	ВсеПараметры = Новый Массив(КоличествоПараметров);
	ВсеПараметры[0] = ЗначенияПараметра1;
	ВсеПараметры[1] = ЗначенияПараметра2;
	ВсеПараметры[2] = ЗначенияПараметра3;
	ВсеПараметры[3] = ЗначенияПараметра4;
	ВсеПараметры[4] = ЗначенияПараметра5;
	ВсеПараметры[5] = ЗначенияПараметра6;
	ВсеПараметры[6] = ЗначенияПараметра7;
	
	ПараметрыВариантов = ЮТКонтекстСлужебный.ЗначениеКонтекста(КлючКонтекста());
	ЗначенияПараметров = Новый Массив(ПараметрыВариантов.КоличествоРеквизитов);
	
	Для Инд = 0 По ПараметрыВариантов.КоличествоРеквизитов - 1 Цикл
		ЮТПроверкиСлужебный.ПроверитьТипПараметра(ВсеПараметры[Инд], Тип("Массив"), "ДобавитьКомбинации", "ЗначенияПараметра" + (Инд + 1));
		ЗначенияПараметров[Инд] = ВсеПараметры[Инд];
	КонецЦикла;
	
	ДобавитьВарианты(ПараметрыВариантов.Варианты,
					 ЗначенияПараметров,
					 ПараметрыВариантов.Реквизиты,
					 0,
					 Новый Структура(ПараметрыВариантов.СтрокаРеквизиты));
	
	Возврат ЮТКонструкторВариантов;
	
КонецФункции

// Список вариантов.
// 
// Возвращаемое значение:
//  Массив из Структура
Функция СписокВариантов() Экспорт
	
	Возврат ЮТКонтекстСлужебный.ЗначениеКонтекста(КлючКонтекста()).Варианты;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция КлючКонтекста()
	
	Возврат "ВариантыТеста";
	
КонецФункции

Процедура ДобавитьВарианты(Варианты, ЗначенияПараметров, Ключи, Инд, БазоваяСтруктура)
	
	ПоследняяИтерация = Инд = Ключи.ВГраница();
	Ключ = Ключи[Инд];
	
	Для Каждого Значение Из ЗначенияПараметров[Инд] Цикл
		
		БазоваяСтруктура[Ключ] = Значение;
		
		Если ПоследняяИтерация Тогда
			Вариант = ЮТКоллекции.СкопироватьСтруктуру(БазоваяСтруктура);
			Варианты.Добавить(Вариант);
		Иначе
			ДобавитьВарианты(Варианты, ЗначенияПараметров, Ключи, Инд + 1, БазоваяСтруктура);
		КонецЕсли;
		
	КонецЦикла;
	
КонецПроцедуры

#КонецОбласти
