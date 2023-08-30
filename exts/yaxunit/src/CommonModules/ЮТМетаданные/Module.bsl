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

// Модули подсистемы.
//  Возвращает список модулей подсистемы
//  Подсистема должна находится в подсистеме "ЮТФункциональность"
// Параметры:
//  ИмяПодсистемы - Строка - Имя подсистемы
//  Серверные - Булево - Возвращять модули доступные на сервере
//  Клиентские - Булево - Возвращять модули доступные на клиенте
// Возвращаемое значение:
//  Массив из Строка - Имена модулей входящих в подсистему
Функция МодулиПодсистемы(ИмяПодсистемы, Серверные = Истина, Клиентские = Истина) Экспорт
	
	Возврат ЮТМетаданныеПовтИсп.МодулиПодсистемы(ИмяПодсистемы, Серверные, Клиентские);
	
КонецФункции

// Описание менеджера.
// 
// Параметры:
//  Значение - Произвольный
// 
// Возвращаемое значение:
//  Структура - Описание менеджера:
// * ОписаниеТипа - см. ЮТМетаданныеСервер.ОписаниеТипаМетаданных
// * Реквизиты - Структура из см. ЮТФабрика.ОписаниеРеквизита
// * ТабличныеЧасти - Структура из Структура -
Функция ОписаниеОбъектМетаданных(Знач Значение) Экспорт
	
	ТипЗначения = ТипЗнч(Значение);
	
	Если ТипЗначения <> Тип("Тип") И ТипЗначения <> Тип("Строка") Тогда
		Значение = ТипЗнч(Значение);
		ТипЗначения = Тип("Тип");
	КонецЕсли;
	
	Если ТипЗначения = Тип("Тип") Тогда
		Возврат ЮТМетаданныеСервер.ОписаниеОбъектМетаданных(Значение);
	Иначе
		Возврат ЮТМетаданныеПовтИсп.ОписаниеОбъектМетаданных(Значение);
	КонецЕсли;
	
КонецФункции

Функция ТипыМетаданных() Экспорт
	
	Возврат ЮТМетаданныеСервер.ТипыМетаданных();
	
КонецФункции

#КонецОбласти
