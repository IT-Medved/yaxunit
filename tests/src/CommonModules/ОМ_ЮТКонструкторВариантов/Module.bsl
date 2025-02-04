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

Процедура ИсполняемыеСценарии() Экспорт
	
	ЮТТесты
		.ДобавитьТест("Варианты")
		.ДобавитьТест("ДобавитьКомбинации_2х3").Представление("Комбинация двух реквизитов по 3 значения")
		.ДобавитьТест("ДобавитьКомбинации_3х2").Представление("Комбинация трех реквизитов по 2 значения")
		.ДобавитьТест("ДобавитьКомбинации_1х1").Представление("Комбинация из одного реквизита ")
		.ДобавитьТест("ДобавитьКомбинации_РазнаяРазмерность").Представление("Комбинация трех реквизитов с разным количество значений")
		.ДобавитьТест("ДобавитьКомбинации_ПроверкаТипаПараметра")
		.ДобавитьТест("Добавить")
		.ДобавитьТест("СписокВариантов")
	;
	
КонецПроцедуры

Процедура Варианты() Экспорт
	
	ЮТКонструкторВариантов.Варианты("Р1, Р2, Р3");
	
	КонтекстВариантов = ЮТКонтекстСлужебный.ЗначениеКонтекста("ВариантыТеста");
	ЮТест.ОжидаетЧто(КонтекстВариантов)
		.Заполнено()
		.ИмеетТип("Структура")
		.Свойство("СтрокаРеквизиты")
			.Равно("Р1, Р2, Р3")
		.Свойство("Реквизиты")
			.Равно(ЮТКоллекции.ЗначениеВМассиве("Р1", "Р2", "Р3"))
		.Свойство("Варианты")
			.ИмеетТип("Массив")
			.НеЗаполнено()
		.Свойство("КоличествоРеквизитов")
			.Равно(3)
	;
	
КонецПроцедуры

Процедура ДобавитьКомбинации_2х3() Экспорт
	
	ЗначенияРеквизита1 = ЮТКоллекции.ЗначениеВМассиве(1, 2, 3);
	ЗначенияРеквизита2 = ЮТКоллекции.ЗначениеВМассиве(11, 12, 13);
	
	ОжидаемыйРезультат = Новый Массив(9);
	ОжидаемыйРезультат[0] = Новый Структура("Р1, Р2", 1, 11);
	ОжидаемыйРезультат[1] = Новый Структура("Р1, Р2", 1, 12);
	ОжидаемыйРезультат[2] = Новый Структура("Р1, Р2", 1, 13);
	ОжидаемыйРезультат[3] = Новый Структура("Р1, Р2", 2, 11);
	ОжидаемыйРезультат[4] = Новый Структура("Р1, Р2", 2, 12);
	ОжидаемыйРезультат[5] = Новый Структура("Р1, Р2", 2, 13);
	ОжидаемыйРезультат[6] = Новый Структура("Р1, Р2", 3, 11);
	ОжидаемыйРезультат[7] = Новый Структура("Р1, Р2", 3, 12);
	ОжидаемыйРезультат[8] = Новый Структура("Р1, Р2", 3, 13);
	
	Варианты = ЮТКонструкторВариантов.Варианты("Р1, Р2")
		.ДобавитьКомбинации(ЗначенияРеквизита1, ЗначенияРеквизита2)
		.СписокВариантов();
	
	ЮТест.ОжидаетЧто(Варианты)
		.ИмеетТип("Массив")
		.ИмеетДлину(9)
		.Равно(ОжидаемыйРезультат)
	;
	
КонецПроцедуры

Процедура ДобавитьКомбинации_3х2() Экспорт
	
	ЗначенияРеквизита1 = ЮТКоллекции.ЗначениеВМассиве(1, 2);
	ЗначенияРеквизита2 = ЮТКоллекции.ЗначениеВМассиве(11, 12);
	ЗначенияРеквизита3 = ЮТКоллекции.ЗначениеВМассиве(21, 22);
	
	ОжидаемыйРезультат = Новый Массив(8);
	ОжидаемыйРезультат[0] = Новый Структура("Р1, Р2, Р3", 1, 11, 21);
	ОжидаемыйРезультат[1] = Новый Структура("Р1, Р2, Р3", 1, 11, 22);
	ОжидаемыйРезультат[2] = Новый Структура("Р1, Р2, Р3", 1, 12, 21);
	ОжидаемыйРезультат[3] = Новый Структура("Р1, Р2, Р3", 1, 12, 22);
	ОжидаемыйРезультат[4] = Новый Структура("Р1, Р2, Р3", 2, 11, 21);
	ОжидаемыйРезультат[5] = Новый Структура("Р1, Р2, Р3", 2, 11, 22);
	ОжидаемыйРезультат[6] = Новый Структура("Р1, Р2, Р3", 2, 12, 21);
	ОжидаемыйРезультат[7] = Новый Структура("Р1, Р2, Р3", 2, 12, 22);
	
	Варианты = ЮТКонструкторВариантов.Варианты("Р1, Р2, Р3")
		.ДобавитьКомбинации(ЗначенияРеквизита1, ЗначенияРеквизита2, ЗначенияРеквизита3)
		.СписокВариантов();
	
	ЮТест.ОжидаетЧто(Варианты)
		.ИмеетТип("Массив")
		.ИмеетДлину(8)
		.Равно(ОжидаемыйРезультат)
	;
	
КонецПроцедуры

Процедура ДобавитьКомбинации_1х1() Экспорт
	
	ЗначенияРеквизита1 = ЮТКоллекции.ЗначениеВМассиве(1);
	
	ОжидаемыйРезультат = Новый Массив(1);
	ОжидаемыйРезультат[0] = Новый Структура("Р1", 1);
	
	Варианты = ЮТКонструкторВариантов.Варианты("Р1")
		.ДобавитьКомбинации(ЗначенияРеквизита1)
		.СписокВариантов();
	
	ЮТест.ОжидаетЧто(Варианты)
		.ИмеетТип("Массив")
		.ИмеетДлину(1)
		.Равно(ОжидаемыйРезультат)
	;
	
КонецПроцедуры

Процедура ДобавитьКомбинации_РазнаяРазмерность() Экспорт
	
	ЗначенияРеквизита1 = ЮТКоллекции.ЗначениеВМассиве(1);
	ЗначенияРеквизита2 = ЮТКоллекции.ЗначениеВМассиве(11, 12);
	ЗначенияРеквизита3 = ЮТКоллекции.ЗначениеВМассиве(21, 22, 23);
	
	ОжидаемыйРезультат = Новый Массив(6);
	ОжидаемыйРезультат[0] = Новый Структура("Р1, Р2, Р3", 1, 11, 21);
	ОжидаемыйРезультат[1] = Новый Структура("Р1, Р2, Р3", 1, 11, 22);
	ОжидаемыйРезультат[2] = Новый Структура("Р1, Р2, Р3", 1, 11, 23);
	ОжидаемыйРезультат[3] = Новый Структура("Р1, Р2, Р3", 1, 12, 21);
	ОжидаемыйРезультат[4] = Новый Структура("Р1, Р2, Р3", 1, 12, 22);
	ОжидаемыйРезультат[5] = Новый Структура("Р1, Р2, Р3", 1, 12, 23);
	
	Варианты = ЮТКонструкторВариантов.Варианты("Р1, Р2, Р3")
		.ДобавитьКомбинации(ЗначенияРеквизита1, ЗначенияРеквизита2, ЗначенияРеквизита3)
		.СписокВариантов();
	
	ЮТест.ОжидаетЧто(Варианты)
		.ИмеетТип("Массив")
		.ИмеетДлину(6)
		.Равно(ОжидаемыйРезультат)
	;
	
КонецПроцедуры

Процедура Добавить() Экспорт
	
	Варианты = ЮТКонструкторВариантов.Варианты("Р1, Р2, Р3")
		.Добавить(1, , 3, 4)
		.СписокВариантов();
	
	ЮТест.ОжидаетЧто(Варианты)
		.ИмеетТип("Массив")
		.ИмеетДлину(1)
		.Равно(ЮТКоллекции.ЗначениеВМассиве(Новый Структура("Р1, Р2, Р3", 1, Неопределено, 3)))
	;

КонецПроцедуры

Процедура СписокВариантов() Экспорт
	
	Варианты = ЮТКонструкторВариантов.Варианты("Р1, Р2, Р3")
		.СписокВариантов();
	
	ЮТест.ОжидаетЧто(Варианты)
		.ИмеетТип("Массив")
		.ИмеетДлину(0)
	;
	
КонецПроцедуры

Процедура ДобавитьКомбинации_ПроверкаТипаПараметра() Экспорт
	
	Варианты = ЮТКонструкторВариантов.Варианты("Р1, Р2, Р3");
	
	ТекстИсключения = СтрШаблон("Некорректный тип параметра `ЗначенияПараметра2` метода `ДобавитьКомбинации`. Метод принимает `%1`, а получили `%2`",
								Тип("Массив"),
								Тип("Число"));
	ЮТест.ОжидаетЧто(Варианты)
		.Метод("ДобавитьКомбинации", ЮТКоллекции.ЗначениеВМассиве(Новый Массив, 2, 3))
		.ВыбрасываетИсключение(ТекстИсключения)
	;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
