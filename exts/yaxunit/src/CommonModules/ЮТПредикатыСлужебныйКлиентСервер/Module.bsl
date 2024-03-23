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

// Проверить предикат.
//
// Параметры:
//  Значение - Произвольный
//  Предикаты - Массив Из см. ЮТФабрика.ВыражениеПредиката
//  ПараметрыСообщенийОбОшибке - см. ПараметрыСообщенийОбОшибке
//  ПараметрыСравнения - Неопределено
//                     - Структура - Параметры сравнения значений, для разных выражений испльзуются свои параметры
//
// Возвращаемое значение:
//  см. ЮТФабрикаСлужебный.ОписаниеРезультатаПроверки
Функция ПроверитьПредикаты(Знач Значение, Знач Предикаты, Знач ПараметрыСообщенийОбОшибке = Неопределено, ПараметрыСравнения = Неопределено) Экспорт
	
	Результат = ЮТФабрикаСлужебный.ОписаниеРезультатаПроверки();
	
	Если ПараметрыСообщенийОбОшибке = Неопределено Тогда
		ПараметрыСообщенийОбОшибке = ПараметрыСообщенийОбОшибке();
	КонецЕсли;
	
	Предикаты = НаборПредикатов(Предикаты);
	Для Каждого Выражение Из Предикаты Цикл
		
		ЮТСравнениеСлужебныйКлиентСервер.ПроверитьВыражениеПредиката(Значение, Выражение, Результат, ПараметрыСообщенийОбОшибке, ПараметрыСравнения);
		Если НЕ Результат.Успешно Тогда
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
	
КонецФункции

// Набор предикатов.
//
// Параметры:
//  Предикаты - Массив из см. ЮТФабрика.ВыражениеПредиката - Набор утверждений. см. ЮТест.Предикат
//            - см. ЮТФабрика.ВыражениеПредиката
//            - CommonModule.ЮТПредикаты - Модуль настройки предикатов, см. ЮТест.Предикат
//
// Возвращаемое значение:
//  Массив из см. ЮТФабрика.ВыражениеПредиката - Набор предикатов
Функция НаборПредикатов(Знач Предикаты) Экспорт
	
	ТипПараметра = ТипЗнч(Предикаты);
	
	Если ЭтоПредикатОбщийМодуль(ТипПараметра, Предикаты) Тогда
		Результат = ЮТПредикаты.Получить();
	ИначеЕсли ЭтоПредикатМассив(ТипПараметра, Предикаты) Тогда
		Результат = Предикаты;
	ИначеЕсли ЭтоПредикатСтруктура(ТипПараметра, Предикаты) Тогда
		Результат = ЮТКоллекции.ЗначениеВМассиве(Предикаты);
	Иначе
		ВызватьИсключение ЮТИсключения.НекорректныеПараметрыМетода("ЮТПредикатыКлиентСервер.НаборПредикатов");
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

// Это предикат
//
// Параметры:
//  Предикаты - Произвольный - значение, для которого будет определено является ли оно предикатом или нет
//
// Возвращаемое значение:
//  Булево
Функция ЭтоПредикат(Предикаты) Экспорт
	
	ТипПараметра = ТипЗнч(Предикаты);
	
	Возврат ЭтоПредикатОбщийМодуль(ТипПараметра, Предикаты)
		ИЛИ ЭтоПредикатМассив(ТипПараметра, Предикаты)
		ИЛИ ЭтоПредикатСтруктура(ТипПараметра, Предикаты);
	
КонецФункции

Функция ПредставлениеПредикатов(Знач Предикаты, Разделитель, ШаблонСвойства = "содержит свойство `%1`, которое") Экспорт
	
	Представления = Новый Массив();
	Предикаты = НаборПредикатов(Предикаты);
	ИмяРеквизита = Неопределено;
	Для Каждого Выражение Из Предикаты Цикл
		НеДобавлятьИмяРеквизита = ИмяРеквизита = Выражение.ИмяРеквизита;
		ИмяРеквизита = Выражение.ИмяРеквизита;
		Представления.Добавить(ПредставлениеПредиката(Выражение, ШаблонСвойства, НеДобавлятьИмяРеквизита));
	КонецЦикла;
	
	Возврат СтрСоединить(Представления, Разделитель);
	
КонецФункции

Функция ШаблонВыражения(Знач Выражение) Экспорт
	
	Отрицание = СтрНачинаетсяС(Выражение, "Не");
	Если Отрицание Тогда
		Выражение = Сред(Выражение, 3);
	КонецЕсли;
	
	Выражения = ЮТПредикаты.Выражения();
	
	Шаблон = Неопределено;
	Если Выражение = Выражения.Равно Тогда
		Шаблон = "равно %1";
	ИначеЕсли Выражение = Выражения.Заполнено Тогда
		Шаблон = "является заполненным";
	ИначеЕсли Выражение = Выражения.Больше Тогда
		Шаблон = "больше чем %1";
	ИначеЕсли Выражение = Выражения.БольшеРавно Тогда
		Шаблон = "больше или равно %1";
	ИначеЕсли Выражение = Выражения.Меньше Тогда
		Шаблон = "меньше чем %1";
	ИначеЕсли Выражение = Выражения.МеньшеРавно Тогда
		Шаблон = "меньше или равно %1";
	ИначеЕсли Выражение = Выражения.ИмеетТип Тогда
		Шаблон = "имеет тип %1";
	ИначеЕсли Выражение = Выражения.ИмеетДлину Тогда
		Шаблон = "имеет длину (размер) %1";
	ИначеЕсли Выражение = Выражения.ИмеетСвойство Тогда
		Шаблон = "содержит свойство %1";
	ИначеЕсли Выражение = Выражения.Содержит Тогда
		Шаблон = "содержит %1";
	ИначеЕсли Выражение = Выражения.СодержитСтрокуПоШаблону Тогда
		Шаблон = "содержит подстроку соответствующую шаблону %1";
	ИначеЕсли Выражение = Выражения.ВСписке Тогда
		Шаблон = "в списке %1";
	Иначе
		ВызватьИсключение "Не описан шаблон сообщения для выражения предиката " + Выражение;
	КонецЕсли;
	
	Если Отрицание Тогда
		Шаблон = "не " + Шаблон;
	КонецЕсли;
	
	Возврат Шаблон;
	
КонецФункции

Функция ЭтоВыраженияОтрицания(Выражение) Экспорт
	
	Возврат СтрНачинаетсяС(Выражение, "Не");
	
КонецФункции

Функция ВыраженияБезОтрицания(Выражение) Экспорт
	
	Возврат Сред(Выражение, 3);
	
КонецФункции

// Параметры сообщений об ошибке.
//
// Параметры:
//  ОписаниеПроверки - Строка - Описание конкретной проверки
//  ТекстПроверяемоеЗначение - Строка - Человекочитаемое описание проверяемого значения
//  ПредставлениеПроверяемогоЗначения - Неопределено - Представление проверяемого значения
//
// Возвращаемое значение:
//  Структура - Параметры сообщений об ошибке:
// * ОписаниеПроверки - Неопределено, Строка - Описание конкретной проверки
// * ТекстПроверяемоеЗначение - Неопределено, Строка - Человекочитаемое описание проверяемого значения
// * ПредставлениеПроверяемогоЗначения - Неопределено, Строка -
Функция ПараметрыСообщенийОбОшибке(ОписаниеПроверки = Неопределено,
								   ТекстПроверяемоеЗначение = "проверяемое значение",
								   ПредставлениеПроверяемогоЗначения = Неопределено) Экспорт
	
	Параметры = Новый Структура;
	Параметры.Вставить("ОписаниеПроверки", ОписаниеПроверки);
	Параметры.Вставить("ТекстПроверяемоеЗначение", ТекстПроверяемоеЗначение);
	Параметры.Вставить("ПредставлениеПроверяемогоЗначения", ПредставлениеПроверяемогоЗначения);
	
	Возврат Параметры;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПредставлениеПредиката(ВыражениеПредиката, ШаблонСвойства, НеДобавлятьИмяРеквизита)
	
	Если НеДобавлятьИмяРеквизита ИЛИ ВыражениеПредиката.ИмяРеквизита = Неопределено Тогда
		ПроверяемоеЗначение = "";
	Иначе
		ПроверяемоеЗначение = СтрШаблон(ШаблонСвойства, ВыражениеПредиката.ИмяРеквизита) + " ";
	КонецЕсли;
	
	Выражение = ЮТСообщенияСлужебный.ПодставитьПредставлениеЗначенияВШаблон(ШаблонВыражения(ВыражениеПредиката.ВидСравнения),
																			ВыражениеПредиката.Значение);
	
	Возврат СтрШаблон("%1%2", ПроверяемоеЗначение, Выражение);
	
КонецФункции

Функция ЭтоПредикатОбщийМодуль(ТипПредикатов, Предикаты)
	
	Возврат ТипПредикатов = Тип("ОбщийМодуль") И Предикаты = ЮТПредикаты;
	
КонецФункции

Функция ЭтоПредикатМассив(ТипПредикатов, Предикаты)
	
	Возврат ТипПредикатов = Тип("Массив")
			И Предикаты.Количество()
			И ЭтоПредикатСтруктура(ТипЗнч(Предикаты[0]), Предикаты[0]);
	
КонецФункции

Функция ЭтоПредикатСтруктура(ТипПредикатов, Предикаты)
	
	Возврат ТипПредикатов = Тип("Структура") И ЮТОбщий.ТипСтруктуры(Предикаты) = "Предикат";
	
КонецФункции

#КонецОбласти
