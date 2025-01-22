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

// см. Мокито.Проверить
Функция Проверить(Объект, Описание = Неопределено) Экспорт
	
	УстановитьПараметрыПроверки(Объект, Описание);
	Возврат МокитоПроверки;
	
КонецФункции

// Начинает утверждение для проверки количества вызовов метода.
// 
// Устанавливает параметры поиска вызовов.
// Параметры:
//  ИмяМетода - Строка - Имя метода проверяемого объекта
//            - Произвольный - Вызов метода проверяемого объекта
//  ПараметрыВызова - Массив из Произвольный - Параметры вызова метода проверяемого объекта, необходим при указании имени метода
// Возвращаемое значение:
//  ОбщийМодуль - см. МокитоПроверки
Функция КоличествоВызовов(ИмяМетода = Неопределено, ПараметрыВызова = Неопределено) Экспорт
	
	ПозиционированиеНаМетоде(ИмяМетода, ПараметрыВызова);
	
	Возврат МокитоПроверки;
	
КонецФункции

// Возвращает информацию о вызовах метода.
// 
// Параметры:
//  ИмяМетода - Строка - Имя метода проверяемого объекта
//            - Произвольный - Вызов метода проверяемого объекта
//  ПараметрыВызова - Массив из Произвольный - Параметры вызова метода проверяемого объекта, необходим при указании имени метода
// Возвращаемое значение:
//  Массив из см. МокитоСлужебный.СтруктураВызоваМетода - Вызовы метода
Функция Вызовы(ИмяМетода = Неопределено, ПараметрыВызова = Неопределено) Экспорт
	
	ПозиционированиеНаМетоде(ИмяМетода, ПараметрыВызова);
	
	Возврат СтатистикаВызовов();
	
КонецФункции

//  Проверяет вызовы метода (см. КоличествоВызовов). 
//  Их количество должно быть равно переданному значение, иначе будет выброшено исключение.
//  
// Параметры:
//  Количество - Число - Ожидаемое количество вызовов
//  Описание - Строка - Описание проверки, необходимо для идентификации упавшей проверки
// 
// Возвращаемое значение:
//  ОбщийМодуль - см. МокитоПроверки
Функция Равно(Количество, Знач Описание = Неопределено) Экспорт
	
	Настройки = ПараметрыПроверки();
	
	Статистика = СтатистикаВызовов();
	ЮТУтверждения
		.Что(Статистика, Настройки.Описание)
		.ИмеющееПредставление(ОписаниеПроверяемогоОбъекта())
		.ИмеетДлину(Количество, Описание);
	
	Возврат МокитоПроверки;
	
КонецФункции

// Проверяет вызовы метода (см. КоличествоВызовов).
// Их количество должно быть больше переданного значения,, иначе будет выброшено исключение.
// Параметры:
//  Количество - Число
//  Описание - Строка - Описание проверки, необходимо для идентификации упавшей проверки
// 
// Возвращаемое значение:
//  ОбщийМодуль - см. МокитоПроверки
Функция Больше(Количество, Знач Описание = Неопределено) Экспорт
	
	Статистика = СтатистикаВызовов();
	ЮТУтверждения
		.Что(Статистика, Описание)
		.ИмеющееПредставление(ОписаниеПроверяемогоОбъекта())
		.ИмеетДлинуБольше(Количество);
	
	Возврат МокитоПроверки;
	
КонецФункции

// Проверяет вызовы метода (см. КоличествоВызовов). 
// Их количество должно быть меньше переданного значения, иначе будет выброшено исключение.
// Параметры:
//  Количество - Число
//  Описание - Строка - Описание проверки, необходимо для идентификации упавшей проверки
// 
// Возвращаемое значение:
//  ОбщийМодуль - см. МокитоПроверки
Функция Меньше(Количество, Знач Описание = Неопределено) Экспорт
	
	Статистика = СтатистикаВызовов();
	ЮТУтверждения
		.Что(Статистика, Описание)
		.ИмеющееПредставление(ОписаниеПроверяемогоОбъекта())
		.ИмеетДлинуМеньше(Количество);
	
	Возврат МокитоПроверки;
	
КонецФункции

// Проверяет, что есть вызовы метода (см. КоличествоВызовов), соответствующие условию.
// Параметры:
//  Описание - Строка - Описание проверки, необходимо для идентификации упавшей проверки
// 
// Возвращаемое значение:
//  ОбщийМодуль - см. МокитоПроверки
Функция Заполнено(Знач Описание = Неопределено) Экспорт
	
	Статистика = СтатистикаВызовов(Истина);
	ЮТУтверждения
		.Что(Статистика, Описание)
		.ИмеющееПредставление(ОписаниеПроверяемогоОбъекта())
		.Заполнено();
	
	Возврат МокитоПроверки;
	
КонецФункции

// Проверяет, что нет вызовов метода (см. КоличествоВызовов), соответствующих условию.
// Параметры:
//  Описание - Строка - Описание проверки, необходимо для идентификации упавшей проверки
// 
// Возвращаемое значение:
//  ОбщийМодуль - см. МокитоПроверки
Функция Пусто(Знач Описание = Неопределено) Экспорт
	
	Статистика = СтатистикаВызовов(Истина);
	ЮТУтверждения
		.Что(Статистика, Описание)
		.ИмеющееПредставление(ОписаниеПроверяемогоОбъекта())
		.НеЗаполнено();
	
	Возврат МокитоПроверки;
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#Область Параметры

// Параметры проверки.
// 
// Возвращаемое значение:
//  Структура:
//  * ПроверяемыйОбъект - Произвольный
//  * СтруктураВызоваМетода - см. МокитоСлужебный.СтруктураВызоваМетода
//  * Описание - Строка
Функция ПараметрыПроверки()
	
	//@skip-check constructor-function-return-section
	Возврат МокитоСлужебный.Настройки().ПараметрыПроверки;
	
КонецФункции

Процедура УстановитьПараметрыПроверки(Объект, Описание)
	
	ПараметрыПроверки = Новый Структура("ПроверяемыйОбъект, Описание, СтруктураВызоваМетода", Объект, Описание);
	МокитоСлужебный.Настройки().ПараметрыПроверки = ПараметрыПроверки;
	
КонецПроцедуры

#КонецОбласти

Функция СтатистикаВызовов(Первый = Ложь)
	
	Параметры = ПараметрыПроверки();
	СтруктураВызоваМетода = Параметры.СтруктураВызоваМетода;
	
	ВызовыМетода = МокитоСлужебный.СтатистикаВызовов(СтруктураВызоваМетода.Объект, СтруктураВызоваМетода.ИмяМетода);
	
	Если ВызовыМетода = Неопределено Тогда
		Возврат Новый Массив();
	КонецЕсли;
	
	Если НЕ ЗначениеЗаполнено(СтруктураВызоваМетода.Параметры) Тогда
		Возврат ВызовыМетода;
	КонецЕсли;
		
	УсловияПроверки = МокитоСлужебный.УсловиеИзПараметров(СтруктураВызоваМетода.Параметры);
	Результат = Новый Массив();
		
	Для Каждого ВызовМетода Из ВызовыМетода Цикл
			
		Если ВызовМетода.Параметры.Количество() < СтруктураВызоваМетода.Параметры.Количество() Тогда
			ВызватьИсключение "Сигнатура метода содержит меньше параметров";
		КонецЕсли;
			
		КоличествоУсловий = УсловияПроверки.Количество();
		Успешно = Истина;
			
		Для Инд = 0 По КоличествоУсловий - 1 Цикл
				
			Параметр = ВызовМетода.Параметры[Инд];
			Условие = УсловияПроверки[Инд];
				
			Успешно = МокитоСлужебный.ПроверитьПараметр(Параметр, Условие);
				
			Если НЕ Успешно Тогда
				Прервать;
			КонецЕсли;
				
		КонецЦикла;
			
		Если Успешно Тогда
			Результат.Добавить(ВызовМетода);
			Если Первый Тогда
				Прервать;
			КонецЕсли;
		КонецЕсли;
			
	КонецЦикла;
		
	Возврат Результат;
	
КонецФункции

Функция ОписаниеПроверяемогоОбъекта()
	
	СтруктураВызоваМетода = ПараметрыПроверки().СтруктураВызоваМетода;
	Объект = СтруктураВызоваМетода.Объект;
	ПредставлениеТипа = ЮТТипыДанныхСлужебный.ПредставлениеТипа(ТипЗнч(Объект));
	Возврат СтрШаблон(" - вызовы метода `%1(%2).%3`,", Объект, ПредставлениеТипа, СтруктураВызоваМетода.ИмяМетода);
	
КонецФункции

Процедура ПозиционированиеНаМетоде(ИмяМетода = Неопределено, ПараметрыВызова = Неопределено)
	
	Параметры = ПараметрыПроверки();
	
	Если МокитоСлужебный.ЭтоСтруктураВызоваМетода(ИмяМетода) Тогда
		СтруктураВызоваМетода = ИмяМетода;
	Иначе
		Условия = МокитоСлужебный.УсловиеИзПараметров(ПараметрыВызова);
		СтруктураВызоваМетода = МокитоСлужебный.СтруктураВызоваМетода(Параметры.ПроверяемыйОбъект, ИмяМетода, Условия);
	КонецЕсли;
	
	Если СтруктураВызоваМетода.Объект <> Параметры.ПроверяемыйОбъект Тогда
		ВызватьИсключение "Установлен другой проверяемый объект";
	КонецЕсли;
	
	Параметры.СтруктураВызоваМетода = СтруктураВызоваМетода;
	
КонецПроцедуры

#КонецОбласти
