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

Функция СоздатьЗапись(Знач Менеджер, Знач Данные, Знач ПараметрыЗаписи, Знач ВернутьОбъект) Экспорт
	
	Менеджер = ЮТОбщий.Менеджер(Менеджер);
	
	Если ПараметрыЗаписи = Неопределено Тогда
		ПараметрыЗаписи = ЮТОбщий.ПараметрыЗаписи();
	Иначе
		ПереданныеПараметрыЗаписи = ПараметрыЗаписи;
		ПараметрыЗаписи = ЮТОбщий.ПараметрыЗаписи();
		ЗаполнитьЗначенияСвойств(ПараметрыЗаписи, ПереданныеПараметрыЗаписи);
	КонецЕсли;
	
	Объект = НовыйОбъект(Менеджер, Данные, ПараметрыЗаписи.ДополнительныеСвойства);
	
	ОписаниеОбъектаМетаданных = ЮТМетаданные.ОписаниеОбъектМетаданных(ТипЗнч(Менеджер));
	
	РежимЗаписи = ?(СтрСравнить(ОписаниеОбъектаМетаданных.ОписаниеТипа.Имя, "Документ") = 0, ПараметрыЗаписи.РежимЗаписи, Неопределено);
	КлючЗаписи = ЗаписатьОбъект(Объект, ПараметрыЗаписи.ОбменДаннымиЗагрузка, РежимЗаписи);
	
	Если ВернутьОбъект Тогда
		Возврат Объект;
	Иначе
		Возврат КлючЗаписи;
	КонецЕсли;
	
КонецФункции

// Создает новый объект и заполняет его данными
// 
// Параметры:
//  Менеджер - Произвольный
//  Данные - Структура - Данные заполнения объекта
//  ДополнительныеСвойства - Структура - Дополнительные свойства объекта
// 
// Возвращаемое значение:
//  Произвольный - Созданный объект
Функция НовыйОбъект(Знач Менеджер, Знач Данные, Знач ДополнительныеСвойства = Неопределено) Экспорт
	
	Менеджер = ЮТОбщий.Менеджер(Менеджер);
	
	ОписаниеОбъектаМетаданных = ЮТМетаданные.ОписаниеОбъектМетаданных(ТипЗнч(Менеджер));
	
	Объект = СоздатьОбъект(Менеджер, ОписаниеОбъектаМетаданных.ОписаниеТипа, Данные);
	ЗаполнитьЗначенияСвойств(Объект, Данные);
	
	Если ОписаниеОбъектаМетаданных.ОписаниеТипа.ТабличныеЧасти Тогда
		
		Для Каждого ОписаниеТабличнойЧасти Из ОписаниеОбъектаМетаданных.ТабличныеЧасти Цикл
			
			ИмяТабличнойЧасти = ОписаниеТабличнойЧасти.Ключ;
			Если НЕ Данные.Свойство(ИмяТабличнойЧасти) Тогда
				Продолжить;
			КонецЕсли;
			
			Для Каждого Запись Из Данные[ИмяТабличнойЧасти] Цикл
				Строка = Объект[ИмяТабличнойЧасти].Добавить();
				ЗаполнитьЗначенияСвойств(Строка, Запись);
			КонецЦикла;
			
		КонецЦикла;
		
	КонецЕсли;
	
	ЗаполнитьБазовыеРеквизиты(Объект, ОписаниеОбъектаМетаданных);
	
	Если ОписаниеОбъектаМетаданных.ОписаниеТипа.Ссылочный И ДополнительныеСвойства <> Неопределено Тогда
		ЮТОбщий.ОбъединитьВСтруктуру(Объект.ДополнительныеСвойства, ДополнительныеСвойства);
	КонецЕсли;
	
	Возврат Объект;
	
КонецФункции

Процедура Удалить(Знач Ссылки) Экспорт
	
	Если ТипЗнч(Ссылки) <> Тип("Массив") Тогда
		Ссылки = ЮТОбщий.ЗначениеВМассиве(Ссылки);
	КонецЕсли;
	
	СсылочныеТипы = ЮТОбщий.ОписаниеТиповЛюбаяСсылка();
	Ошибки = Новый Массив;
	
	Для Каждого Ссылка Из Ссылки Цикл
		
		ТипЗначения = ТипЗнч(Ссылка);
		Если Ссылка = Неопределено ИЛИ СтрНачинаетсяС(ЮТОбщий.ПредставлениеТипа(ТипЗначения), "Enum") Тогда
			Продолжить;
		КонецЕсли;
		
		Попытка
			Если СсылочныеТипы.СодержитТип(ТипЗначения) Тогда
				Объект = Ссылка.ПолучитьОбъект();
				Если Объект <> Неопределено Тогда
					Объект.Удалить();
				КонецЕсли;
			Иначе
				Менеджер = Менеджер(ЮТМетаданныеСервер.ОписаниеОбъектМетаданных(ТипЗначения, Ложь));
				Запись = Менеджер.СоздатьМенеджерЗаписи();
				ЗаполнитьЗначенияСвойств(Запись, Ссылка);
				Запись.Прочитать();
				Запись.Удалить();
			КонецЕсли;
		Исключение
			
			Ошибки.Добавить(ЮТРегистрацияОшибок.ПредставлениеОшибки("Удаление " + Ссылка, ИнформацияОбОшибке()));
			
		КонецПопытки;
		
	КонецЦикла;
	
	ОбновитьНумерациюОбъектов();
	
	Если ЗначениеЗаполнено(Ошибки) Тогда
		ВызватьИсключение СтрСоединить(Ошибки, Символы.ПС);
	КонецЕсли;
	
КонецПроцедуры

Функция ФикцияЗначенияБазы(Знач ТипЗначения, Знач РеквизитыЗаполнения = Неопределено) Экспорт
	
	ОбъектМетаданных = Метаданные.НайтиПоТипу(ТипЗначения);
	
	Если ОбъектМетаданных = Неопределено Тогда
		Возврат Неопределено;
	КонецЕсли;
	
	Если Метаданные.Перечисления.Содержит(ОбъектМетаданных) Тогда
		
		Менеджер = Новый ("ПеречислениеМенеджер." + ОбъектМетаданных.Имя);
		НомерЗначения = ЮТТестовыеДанные.СлучайноеПоложительноеЧисло(Менеджер.Количество());
		Возврат Менеджер.Получить(НомерЗначения - 1);
		
	КонецЕсли;
	
	ОписаниеОбъектаМетаданных = ЮТМетаданныеСервер.ОписаниеОбъектМетаданных(ОбъектМетаданных);
	ОписаниеТипа = ОписаниеОбъектаМетаданных.ОписаниеТипа;
	
	ИмяТипаМенеджера = СтрШаблон("%1Менеджер.%2", ОписаниеТипа.Имя, ОбъектМетаданных.Имя);
	Менеджер = Новый (ИмяТипаМенеджера);
	
	Объект = СоздатьОбъект(Менеджер, ОписаниеТипа, РеквизитыЗаполнения);
	
	Если ЗначениеЗаполнено(РеквизитыЗаполнения) Тогда
		ЗаполнитьЗначенияСвойств(Объект, РеквизитыЗаполнения);
	КонецЕсли;
	
	ЗаполнитьБазовыеРеквизиты(Объект, ОписаниеОбъектаМетаданных);
	
	Возврат ЗаписатьОбъект(Объект);
	
КонецФункции

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Создать объект.
// 
// Параметры: ОписаниеМенеджера - 
// См. ОписаниеМенеджера
//  Менеджер - Произвольный - Менеджер
//  ОписаниеТипа - см. ЮТМетаданные.ОписаниеОбъектМетаданных
//  Данные - Структура
// Возвращаемое значение:
//  Произвольный - Создать объект
Функция СоздатьОбъект(Менеджер, ОписаниеТипа, Данные)
	
	Если ОписаниеТипа.Конструктор = "СоздатьЭлемент" Тогда
		
		ЭтоГруппа = ?(Данные = Неопределено, Ложь, ЮТОбщий.ЗначениеСтруктуры(Данные, "ЭтоГруппа", Ложь));
		Если ЭтоГруппа Тогда
			Результат = Менеджер.СоздатьГруппу();
		Иначе
			Результат = Менеджер.СоздатьЭлемент();
		КонецЕсли;
		
	ИначеЕсли ОписаниеТипа.Конструктор = "СоздатьДокумент" Тогда
		Результат = Менеджер.СоздатьДокумент();
	ИначеЕсли ОписаниеТипа.Конструктор = "СоздатьСчет" Тогда
		Результат = Менеджер.СоздатьСчет();
	ИначеЕсли ОписаниеТипа.Конструктор = "СоздатьВидРасчета" Тогда
		Результат = Менеджер.СоздатьВидРасчета();
	ИначеЕсли ОписаниеТипа.Конструктор = "СоздатьУзел" Тогда
		Результат = Менеджер.СоздатьУзел();
	ИначеЕсли ОписаниеТипа.Конструктор = "СоздатьНаборЗаписей" Тогда
		Результат = Менеджер.СоздатьНаборЗаписей();
	ИначеЕсли ОписаниеТипа.Конструктор = "СоздатьМенеджерЗаписи" Тогда
		Результат = Менеджер.СоздатьМенеджерЗаписи();
	ИначеЕсли ОписаниеТипа.Конструктор = "СоздатьБизнесПроцесс" Тогда
		Результат = Менеджер.СоздатьБизнесПроцесс();
	ИначеЕсли ОписаниеТипа.Конструктор = "СоздатьЗадачу" Тогда
		Результат = Менеджер.СоздатьЗадачу();
	Иначе
		ВызватьИсключение СтрШаблон("Для %1 не поддерживается создание записей ИБ", ОписаниеТипа.Имя);
	КонецЕсли;
	
	Возврат Результат;
	
КонецФункции

Функция ЗаписатьОбъект(Объект, ОбменДаннымиЗагрузка = Ложь, РежимЗаписи = Неопределено)
	
	Если ОбменДаннымиЗагрузка Тогда
		Объект.ОбменДанными.Загрузка = Истина;
	КонецЕсли;
	
	Попытка
		
		Если РежимЗаписи <> Неопределено Тогда
			Объект.Записать(РежимЗаписи);
		Иначе
			Объект.Записать();
		КонецЕсли;
		
		Если ОбменДаннымиЗагрузка Тогда
			Объект.ОбменДанными.Загрузка = Ложь;
		КонецЕсли;
		
		Возврат КлючЗаписи(Объект);
		
	Исключение
		
		Сообщение = СтрШаблон("Не удалось записать объект `%1` (%2)
		|%3", Объект, ТипЗнч(Объект), ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		ВызватьИсключение Сообщение;
		
	КонецПопытки;
	
КонецФункции

Процедура ЗаполнитьБазовыеРеквизиты(Объект, ОписаниеОбъектаМетаданных)
	
	ОписаниеТипа = ОписаниеОбъектаМетаданных.ОписаниеТипа;
	Если ОписаниеТипа.Имя = "Документ" Тогда
		Если НЕ ЗначениеЗаполнено(Объект.Дата) Тогда
			Объект.Дата = ТекущаяДатаСеанса();
		КонецЕсли;
		Если НЕ ЗначениеЗаполнено(Объект.Номер) Тогда
			Объект.УстановитьНовыйНомер();
		КонецЕсли;
	КонецЕсли;
	
	Если ОписаниеОбъектаМетаданных.Реквизиты.Свойство("Код")
		И ОписаниеОбъектаМетаданных.Реквизиты.Код.Обязательный
		И Не ЗначениеЗаполнено(Объект.Код) Тогда
		Объект.УстановитьНовыйКод();
	КонецЕсли;
	
	Если ОписаниеОбъектаМетаданных.Реквизиты.Свойство("Наименование")
		И ОписаниеОбъектаМетаданных.Реквизиты.Наименование.Обязательный
		И Не ЗначениеЗаполнено(Объект.Наименование) Тогда
		Объект.Наименование = ЮТТестовыеДанные.СлучайнаяСтрока();
	КонецЕсли;
	
КонецПроцедуры

Функция КлючЗаписи(Объект)
	
	ПредставлениеТипа = ЮТОбщий.ПредставлениеТипа(ТипЗнч(Объект));
	Если СтрНайти(ПредставлениеТипа, "Object.") Тогда
		
		Возврат Объект.Ссылка;
		
	ИначеЕсли СтрНайти(ПредставлениеТипа, "менеджер записи:") Тогда // TODO
		
		Описание = ЮТМетаданныеСервер.ОписаниеОбъектМетаданных(ТипЗнч(Объект));
		
		КлючевыеРеквизиты = Новый Структура();
		Для Каждого Реквизит Из Описание.Реквизиты Цикл
			Если Реквизит.Значение.ЭтоКлюч Тогда
				КлючевыеРеквизиты.Вставить(Реквизит.Ключ, Объект[Реквизит.Ключ]);
			КонецЕсли;
		КонецЦикла;
		
		Менеджер = Менеджер(Описание);
		Возврат Менеджер.СоздатьКлючЗаписи(КлючевыеРеквизиты);
		
	Иначе
		
		Сообщение = ЮТОбщий.НеподдерживаемыйПараметрМетода("ЮТТестовыеДанныеВызовСервера.КлючЗаписи", Объект);
		ВызватьИсключение Сообщение;
		
	КонецЕсли;
	
КонецФункции

Функция Менеджер(ОписаниеОбъектМетаданных)
	Возврат Новый(СтрШаблон("%1Менеджер.%2", ОписаниеОбъектМетаданных.ОписаниеТипа.Имя, ОписаниеОбъектМетаданных.Имя));
КонецФункции

#КонецОбласти
