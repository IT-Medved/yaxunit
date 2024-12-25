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

#Область ОписаниеПеременных

&НаКлиенте
Перем ПараметрыЗапускаТестирования;

#КонецОбласти

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
//	Данные = ПолучитьОбщийМакет("ЮТMonacoEditor");
//	ЧтениеZip = Новый ЧтениеZipФайла(Данные.ОткрытьПотокДляЧтения);
//	ИмяВременногоФайла = ПолучитьИмяВременногоФайла();
//	ЧтениеZip.Извлечь(ЧтениеZip.Элементы[0], ИмяВременногоФайла);
//	Данные = Новый ДвоичныеДанные(ИмяВременногоФайла);
//	УдалитьФайлы(ИмяВременногоФайла);
//	
//	EditorURL = ПолучитьНавигационнуюСсылкуИнформационнойБазы() + "/" + ПоместитьВоВременноеХранилище(Данные, УникальныйИдентификатор);
	EditorURL = "http://localhost:5173/";
	Сервер = Истина;
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	Если ПараметрыЗапускаТестирования = Неопределено Тогда
		ПараметрыЗапускаТестирования = ЮТПараметрыЗапускаСлужебный.ПараметрыТестированияПоУмолчанию();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура EditorURLПриНажатии(Элемент, ДанныеСобытия, СтандартнаяОбработка)
	
	Обработчик = Новый ОписаниеОповещения("ОбработатьСообщение", ЭтотОбъект);
	ЮТРеактивныйКлиент.ОбработатьСообщение(ЭтотОбъект, Элементы.EditorURL, ДанныеСобытия, СтандартнаяОбработка, Обработчик);
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаКлиенте
Процедура ОбработатьСообщение(Сообщение, Контекст) Экспорт
	
	Если СтрСравнить(Сообщение.ИмяСобытия, "runTest") = 0 Тогда
		ЗапуститьТесты(Сообщение);
	КонецЕсли;
	
КонецПроцедуры

&НаКлиенте
Процедура ЗапуститьТесты(Сообщение)
	
	ПоказатьОповещениеПользователя("Прогон тестов", , "Запушено выполнение тестов", БиблиотекаКартинок.ЮТПодсистема);
	ОписаниеМодуля = ЮТИсполнительСлужебныйКлиент.ОписаниеВременногоМодуля();
	ОписаниеМодуля.Текст = Сообщение.Значение.module;
	ОписаниеМодуля.КлиентУправляемое = КлиентУправляемоеПриложение;
	ОписаниеМодуля.КлиентОбычное = КлиентОбычноеПриложение;
	ОписаниеМодуля.Сервер = Сервер;
	
	Обработчик = Новый ОписаниеОповещения("ПослеВыполненияТестирования", ЭтотОбъект, Сообщение);
	ЮТИсполнительСлужебныйКлиент.ВыполнитьТестыВременногоМодуля(ПараметрыЗапускаТестирования, ОписаниеМодуля, Неопределено, Обработчик);
	
КонецПроцедуры

&НаКлиенте
Процедура ПослеВыполненияТестирования(Результат, Сообщение) Экспорт
	
	ПоказатьОповещениеПользователя("Прогон тестов", , "Завершено выполнение тестов", БиблиотекаКартинок.ЮТПодсистема);
	Ответ = Новый Структура("tests, errors", Новый Массив, Новый Массив);
	
	Для Каждого Набор Из Результат[0].НаборыТестов Цикл
		
		Для Каждого ОписаниеОшибки Из Набор.Ошибки Цикл
			
			Если ЗначениеЗаполнено(ОписаниеОшибки.Стек) Тогда
				Ответ.errors.Добавить(ОписаниеОшибки.Стек);
			КонецЕсли;
			
		КонецЦикла;
		
		Для Каждого Тест Из Набор.Тесты Цикл
		
			ОписаниеТеста = Новый Структура;
			ОписаниеТеста.Вставить("status", Тест.Статус);
			ОписаниеТеста.Вставить("present", Тест.Имя);
			ОписаниеТеста.Вставить("method", Тест.Метод);
			ОписаниеТеста.Вставить("duration", Тест.Длительность);
			ОписаниеТеста.Вставить("message", "");
			
			Ответ.tests.Добавить(ОписаниеТеста);
			
			Для Каждого ОписаниеОшибки Из Тест.Ошибки Цикл
				
				Если ЗначениеЗаполнено(ОписаниеОшибки.Стек) Тогда
					Ответ.errors.Добавить(ОписаниеОшибки.Стек);
				КонецЕсли;
				
				ОписаниеТеста.message = ОписаниеТеста.message + Символы.ПС + ОписаниеОшибки.Сообщение;
				
			КонецЦикла;
			
		КонецЦикла;
		
	КонецЦикла;
	
	ЮТРеактивныйКлиент.ОтправитьОтвет(Элементы.EditorURL, Сообщение, Ответ);
	
КонецПроцедуры

#КонецОбласти
