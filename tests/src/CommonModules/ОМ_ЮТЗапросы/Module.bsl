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

Процедура ИсполняемыеСценарии() Экспорт
	
	ЮТТесты.ВТранзакции().УдалениеТестовыхДанных()
		.ДобавитьТест("ЗначенияРеквизитов")
		.ДобавитьТест("ЗначениеРеквизита")
		.ДобавитьТест("ТаблицаСодержитЗаписи")
		.ДобавитьТест("РезультатЗапроса")
		.ДобавитьТест("РезультатПустой")
		.ДобавитьТест("Запись")
		.ДобавитьТест("Записи")
		.ДобавитьТест("ЗначенияРеквизитовЗаписи")
		.ДобавитьТест("ЗначениеРеквизитаЗаписи")
	;
	
КонецПроцедуры

Процедура ЗначенияРеквизитов() Экспорт
	
	Конструктор = ЮТест.Данные().КонструкторОбъекта("Справочники.Товары")
		.Фикция("Наименование")
		.Фикция("Штрихкод")
		.Фикция("Поставщик");
	Данные = Конструктор.ДанныеОбъекта();
	Ссылка = Конструктор.Записать();
	
	ДанныеСсылки = ЮТЗапросы.ЗначенияРеквизитов(Ссылка, "Наименование");
	ЮТест.ОжидаетЧто(ДанныеСсылки)
		.ИмеетТип("Структура")
		.Заполнено()
		.Свойство("Наименование").Равно(Данные.Наименование);
	
	ДанныеСсылки = ЮТЗапросы.ЗначенияРеквизитов(Ссылка, "Штрихкод, Поставщик");
	ЮТест.ОжидаетЧто(ДанныеСсылки)
		.ИмеетТип("Структура")
		.Заполнено()
		.Свойство("Штрихкод").Равно(Данные.Штрихкод)
		.Свойство("Поставщик").Равно(Данные.Поставщик);
	
	ДанныеСсылки = ЮТЗапросы.ЗначенияРеквизитов(ПредопределенноеЗначение("Справочник.Товары.ПустаяСсылка"), "Код, Поставщик");
	ЮТест.ОжидаетЧто(ДанныеСсылки)
		.ИмеетТип("Структура")
		.Заполнено()
		.Свойство("Код").Равно(Неопределено)
		.Свойство("Поставщик").Равно(Неопределено);
	
КонецПроцедуры

Процедура ЗначениеРеквизита() Экспорт
	
	Конструктор = ЮТест.Данные().КонструкторОбъекта("Справочники.Товары")
		.Фикция("Наименование")
		.Фикция("Поставщик");
	Данные = Конструктор.ДанныеОбъекта();
	Ссылка = Конструктор.Записать();
	
	ЮТест.ОжидаетЧто(ЮТЗапросы.ЗначениеРеквизита(Ссылка, "Наименование"))
		.ИмеетТип("Строка")
		.Заполнено()
		.Равно(Данные.Наименование);
	
	ЮТест.ОжидаетЧто(ЮТЗапросы.ЗначениеРеквизита(Ссылка, "Поставщик"))
		.Равно(Данные.Поставщик);
	
	ЮТест.ОжидаетЧто(ЮТЗапросы.ЗначениеРеквизита(Ссылка, "Наименование, Поставщик"))
		.Равно(Данные.Наименование);
	
	ЮТест.ОжидаетЧто(ЮТЗапросы.ЗначениеРеквизита(ПредопределенноеЗначение("Справочник.Товары.ПустаяСсылка"), "Наименование"))
		.Равно(Неопределено);
	
КонецПроцедуры

Процедура ТаблицаСодержитЗаписи() Экспорт
	
	Конструктор = ЮТест.Данные().КонструкторОбъекта("Справочники.Товары")
		.Фикция("Наименование")
		.Фикция("Поставщик");
	Конструктор.Записать();
	ДанныеСправочника = Конструктор.ДанныеОбъекта();
	
	ЮТест.ОжидаетЧто(ЮТЗапросы.ТаблицаСодержитЗаписи("Справочник.Товары")).ЭтоИстина();
	ЮТест.ОжидаетЧто(ЮТЗапросы.ТаблицаСодержитЗаписи("Справочник.МобильныеУстройства")).ЭтоЛожь();
	
	ЮТест.ОжидаетЧто(
		ЮТЗапросы.ТаблицаСодержитЗаписи("Справочник.Товары",
			ЮТест.Предикат()
				.Реквизит("Наименование").Равно(ДанныеСправочника.Наименование)))
		.ЭтоИстина();
	
	ЮТест.ОжидаетЧто(
		ЮТЗапросы.ТаблицаСодержитЗаписи("Справочник.Товары",
			ЮТест.Предикат()
				.Реквизит("Наименование").Равно(1)))
		.ЭтоЛожь();
	
КонецПроцедуры

Процедура РезультатЗапроса() Экспорт
	
	Конструктор = ЮТест.Данные().КонструкторОбъекта("Справочники.Товары")
		.Фикция("Наименование")
		.Фикция("Поставщик");
	Ссылка = Конструктор.Записать();
	ДанныеСправочника = Конструктор.ДанныеОбъекта();
	
	ОписаниеЗапроса = ЮТЗапросы.ОписаниеЗапроса();
	ОписаниеЗапроса.ИмяТаблицы = "Справочник.Товары";
	ОписаниеЗапроса.Условия.Добавить("Ссылка = &Ссылка");
	ОписаниеЗапроса.Условия.Добавить("НЕ ПометкаУдаления");
	ОписаниеЗапроса.ЗначенияПараметров.Вставить("Ссылка", Ссылка);
	ОписаниеЗапроса.ВыбираемыеПоля.Добавить("Наименование");
	ОписаниеЗапроса.ВыбираемыеПоля.Добавить("1+1 КАК Число");
	
	ЮТест.ОжидаетЧто(ЮТЗапросы.РезультатЗапроса(ОписаниеЗапроса))
		.ИмеетДлину(1)
		.Свойство("[0].Наименование").Равно(ДанныеСправочника.Наименование)
		.Свойство("[0].Число").Равно(2);
	
КонецПроцедуры

Процедура РезультатПустой() Экспорт
	
	Конструктор = ЮТест.Данные().КонструкторОбъекта("Справочники.Товары")
		.Фикция("Наименование")
		.Фикция("Поставщик");
	Ссылка = Конструктор.Записать();
	ДанныеСправочника = Конструктор.ДанныеОбъекта();
	
	ОписаниеЗапроса = ЮТЗапросы.ОписаниеЗапроса();
	ОписаниеЗапроса.ИмяТаблицы = "Справочник.Товары";
	ОписаниеЗапроса.Условия.Добавить("Ссылка = &Ссылка");
	ОписаниеЗапроса.ЗначенияПараметров.Вставить("Ссылка", Ссылка);
	
	ЮТест.ОжидаетЧто(ЮТЗапросы.РезультатПустой(ОписаниеЗапроса)).ЭтоЛожь();
	
	ОписаниеЗапроса.Условия.Добавить("ПометкаУдаления");
	ЮТест.ОжидаетЧто(ЮТЗапросы.РезультатПустой(ОписаниеЗапроса)).ЭтоИстина();
	
КонецПроцедуры

Процедура Запись() Экспорт
	
	// Справочник
	Конструктор = ЮТест.Данные().КонструкторОбъекта("Справочники.Товары")
		.Фикция("Наименование")
		.Фикция("Поставщик");
	Ссылка = Конструктор.Записать();
	ДанныеОбъекта = Конструктор.ДанныеОбъекта();
	
	ДанныеЗаписи = ЮТЗапросы.Запись("Справочник.Товары", ЮТест.Предикат()
		.Реквизит("Ссылка").Равно(Ссылка));
	
	ДанныеЗаписи = ЮТЗапросы.Запись("Справочник.Товары", ЮТест.Предикат()
		.Реквизит("Поставщик").Равно(ДанныеОбъекта.Поставщик));
	
	ЮТест.ОжидаетЧто(ДанныеЗаписи)
		.ИмеетТип("Структура")
		.Заполнено()
		.Свойство("Ссылка").Равно(Ссылка)
		.Свойство("Наименование").Равно(ДанныеОбъекта.Наименование)
		.Свойство("Поставщик").Равно(ДанныеОбъекта.Поставщик);
	
	// Справочник поиск по реквизиту
	ДанныеЗаписи = ЮТЗапросы.Запись("Справочник.Товары", ЮТест.Предикат()
		.Реквизит("Поставщик").Равно(ДанныеОбъекта.Поставщик));
	
	ЮТест.ОжидаетЧто(ДанныеЗаписи)
		.Свойство("Ссылка").Равно(Ссылка);
	
	// Документ, тест на табличную часть
	Конструктор = ЮТест.Данные().КонструкторОбъекта("Документы.ПриходТовара")
		.Фикция("Склад")
		.Фикция("Организация")
		.Фикция("Поставщик")
		.ТабличнаяЧасть("Товары")
			.ДобавитьСтроку()
			.Фикция("Товар")
			.Фикция("Цена");
	
	Ссылка = Конструктор.Записать();
	ДанныеОбъекта = Конструктор.ДанныеОбъекта();
	
	ДанныеЗаписи = ЮТЗапросы.Запись("Документ.ПриходТовара", ЮТест.Предикат()
		.Реквизит("Ссылка").Равно(Ссылка));
	
	ЮТест.ОжидаетЧто(ДанныеЗаписи)
		.Свойство("Ссылка").Равно(Ссылка)
		.Свойство("Поставщик").Равно(ДанныеОбъекта.Поставщик)
		.Свойство("Товары")
			.ИмеетТип("Массив")
			.ИмеетДлину(1)
			.Свойство("Товары[0].НомерСтроки").Равно(1)
			.Свойство("Товары[0].Товар").Равно(ДанныеОбъекта.Товары[0].Товар);
	
	ДанныеЗаписи = ЮТЗапросы.Запись("Документ.ПриходТовара.Товары", ЮТест.Предикат()
		.Реквизит("Товар").Равно(ДанныеОбъекта.Товары[0].Товар));
	ЮТест.ОжидаетЧто(ДанныеЗаписи)
		.Свойство("Ссылка").Равно(Ссылка)
		.Свойство("Товар").Равно(ДанныеОбъекта.Товары[0].Товар);
	
	// Регистры
	Конструктор = ЮТест.Данные().КонструкторОбъекта("РегистрыСведений.КурсыВалют")
		.Фикция("Период")
		.Фикция("Валюта")
		.Фикция("Курс");
	Конструктор.Записать();
	ДанныеОбъекта = Конструктор.ДанныеОбъекта();
	
	ДанныеЗаписи = ЮТЗапросы.Запись("РегистрСведений.КурсыВалют", ЮТест.Предикат()
		.Реквизит("Валюта").Равно(ДанныеОбъекта.Валюта));
	
	ЮТест.ОжидаетЧто(ДанныеЗаписи)
		.Свойство("Валюта").Равно(ДанныеОбъекта.Валюта)
		.Свойство("Курс").Равно(ДанныеОбъекта.Курс);
	
КонецПроцедуры

Процедура Записи() Экспорт
	
	ТоварыПоставщика = Новый Соответствие();
	Поставщик = ЮТест.Данные().СоздатьЭлемент("Справочники.Контрагенты");
	
	Для Инд = 1 По 5 Цикл
		Конструктор = ЮТест.Данные().КонструкторОбъекта("Справочники.Товары")
			.Фикция("Наименование")
			.Установить("Поставщик", Поставщик);
		ТоварыПоставщика.Вставить(Конструктор.Записать(), Конструктор.ДанныеОбъекта());
	КонецЦикла;
	
	Записи = ЮТЗапросы.Записи("Справочник.Товары", ЮТест.Предикат()
		.Реквизит("Поставщик").Равно(Поставщик));
	
	ЮТест.ОжидаетЧто(Записи)
		.ИмеетТип("Массив")
		.ИмеетДлину(5);
	
	Для Каждого Запись Из Записи Цикл
		ЮТест.ОжидаетЧто(Запись)
			.ИмеетТип("Структура")
			.Свойство("Ссылка")
			.Свойство("Поставщик").Равно(Поставщик)
			.Свойство("Код");
	КонецЦикла;
	
КонецПроцедуры

Процедура ЗначенияРеквизитовЗаписи() Экспорт
	
	Конструктор = ЮТест.Данные().КонструкторОбъекта("Справочники.Товары")
		.Фикция("Наименование")
		.Фикция("Штрихкод")
		.Фикция("Поставщик");
	Данные = Конструктор.ДанныеОбъекта();
	Конструктор.Записать();
	
	Предикат = ЮТест.Предикат().Реквизит("Наименование").Равно(Данные.Наименование);
	ДанныеСсылки = ЮТЗапросы.ЗначенияРеквизитовЗаписи("Справочник.Товары", Предикат, "Наименование");
	ЮТест.ОжидаетЧто(ДанныеСсылки)
		.ИмеетТип("Структура")
		.Заполнено()
		.Свойство("Наименование").Равно(Данные.Наименование);
	
	Предикат = ЮТест.Предикат()
		.Реквизит("Штрихкод").Равно(Данные.Штрихкод)
		.Реквизит("Поставщик").Равно(Данные.Поставщик);
	ДанныеСсылки = ЮТЗапросы.ЗначенияРеквизитовЗаписи("Справочник.Товары", Предикат, "Штрихкод, Поставщик, Поставщик.Наименование");
	ЮТест.ОжидаетЧто(ДанныеСсылки)
		.ИмеетТип("Структура")
		.Заполнено()
		.Свойство("Штрихкод").Равно(Данные.Штрихкод)
		.Свойство("Поставщик").Равно(Данные.Поставщик)
		.Свойство("ПоставщикНаименование").Равно(Строка(Данные.Поставщик));
	
	Предикат = ЮТест.Предикат().Реквизит("Ссылка").Равно(ПредопределенноеЗначение("Справочник.Товары.ПустаяСсылка"));
	ДанныеСсылки = ЮТЗапросы.ЗначенияРеквизитовЗаписи("Справочник.Товары", Предикат, "Код, Поставщик");
	ЮТест.ОжидаетЧто(ДанныеСсылки)
		.ИмеетТип("Структура")
		.Заполнено()
		.Свойство("Код").Равно(Неопределено)
		.Свойство("Поставщик").Равно(Неопределено);
	
КонецПроцедуры

Процедура ЗначениеРеквизитаЗаписи() Экспорт
	
	Конструктор = ЮТест.Данные().КонструкторОбъекта("Справочники.Товары")
		.Фикция("Наименование")
		.Фикция("Поставщик");
	Данные = Конструктор.ДанныеОбъекта();
	Конструктор.Записать();
	
	Предикат = ЮТест.Предикат().Реквизит("Наименование").Равно(Данные.Наименование);
	ЮТест.ОжидаетЧто(ЮТЗапросы.ЗначениеРеквизитаЗаписи("Справочник.Товары", Предикат, "Наименование"))
		.ИмеетТип("Строка")
		.Заполнено()
		.Равно(Данные.Наименование);
	
	Предикат = ЮТест.Предикат().Реквизит("Поставщик").Равно(Данные.Поставщик);
	ЮТест.ОжидаетЧто(ЮТЗапросы.ЗначениеРеквизитаЗаписи("Справочник.Товары", Предикат, "Поставщик"))
		.Равно(Данные.Поставщик);
	
	Предикат = ЮТест.Предикат()
		.Реквизит("Наименование").Равно(Данные.Наименование)
		.Реквизит("Поставщик").Равно(Данные.Поставщик);
	ЮТест.ОжидаетЧто(ЮТЗапросы.ЗначениеРеквизитаЗаписи("Справочник.Товары", Предикат, "Наименование, Поставщик"))
		.Равно(Данные.Наименование);
	
	Предикат = ЮТест.Предикат().Реквизит("Ссылка").Равно(ПредопределенноеЗначение("Справочник.Товары.ПустаяСсылка"));
	ЮТест.ОжидаетЧто(ЮТЗапросы.ЗначениеРеквизитаЗаписи("Справочник.Товары", Предикат, "Наименование"))
		.Равно(Неопределено);
	
КонецПроцедуры

#КонецОбласти
