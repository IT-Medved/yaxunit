---
tags: [Начало, Тестовые данные]
---
# Тестовые данные

Почти в каждом тесте разработчику необходимы данные, которые он будет использовать при тестировании: элементы справочников, документы, остатки и тд.

Есть разные подходы к работе с тестовыми данными:

1. Ручное наполнение тестовой базы (мы предварительно создаем все что необходимо для тестов в базе, а потом используем её для прогона тестов)
2. Использование файлов с данными (макеты - сгенерированные в нужном формате файлы с описанием тестовых данных, загружаемые при выполнении тестов)
3. Программное создание нужных данных внутри теста

У каждого из вариантов есть свои плюсы и минусы, и при грамотной компоновке можно достичь наилучшего результата.

Например:

* Ручное наполнение базы не учитывает последующие доработки системы, нужна миграция на новые алгоритмы и структуру, и, если таких данных будет много, то миграция будет занимать большое время. А также в этом случае нам необходимо завязываться на конкретные записи в системе, и при их изменении тестом мы можем сломать другие тесты. Поэтому, предварительное наполнение базы должно быть минимальным.
* В случае использования макетов данных возникают некоторые трудности с их доработкой и вариативностью, например, в новом тесте нужны данные из макета, но с некоторыми изменениями. В этом случае нам потребуется создавать новый макет или проверять, не сломают ли наши изменения другие тесты. Также при таком подходе сложно контролировать и искать какие макеты используются и кем.
* Программное создание тестовых данных увеличивает время и сложность теста.

Если грамотно распределить тестовые данные на способы создания, мы можем добиться оптимального результата.
Например, можно статичные данные создать вручную, сложные кейсы данных засунуть в макеты, а для программного создания реализовать методы-конструкторы, которые будем переиспользовать. Таким образом, сможем уйти от минусов данного подхода или минимизировать их вред.

В текущей версии тестовый движок предоставляет api для программного создания тестовых данных. За это отвечает общий модуль `ЮТТестовыеДанные`, к которому можно обратиться через метод `ЮТест.Данные()`.

:::tip 
Не рекомендуется обращаться к модулю `ЮТТестовыеДанные` напрямую, используйте `ЮТест.Данные()`
:::

Он позволяет:

* Создавать данные информационной базы
* Генерировать случайные значения
* Автоматически удалять созданные данные (для этого необходимо включить настройку теста `УдалениеТестовыхДанных()`)
* Работать с файлами
* Использовать таблицы markdown в качестве макетов данных
* Генерировать таблицы значений из табличных документов и таблиц markdown

Примеры

1. Генерация фейкового документа

    ```bsl
    #Если Сервер Тогда
        Конструктор = ЮТест.Данные().КонструкторОбъекта(Документы.ПриходТовара);
    #Иначе
        Конструктор = ЮТест.Данные().КонструкторОбъекта("Документы.ПриходТовара");
    #КонецЕсли

        Конструктор
            .Фикция("Поставщик")
            .Фикция("Склад")
            .Фикция("Валюта")
            .Установить("Организация", ЮТест.Данные().КонструкторОбъекта("Справочники.Организации").Установить("КакойТоТамУчет", Истина))
            .ТабличнаяЧасть("Товары");
        
        Для Инд1 = 1 По ЮТест.Данные().СлучайноеЧисло(1, 5) Цикл
            Конструктор.ДобавитьСтроку()
                .Фикция("Товар")
                .Установить("Цена", ЮТест.Данные().СлучайноеПоложительноеЧисло(9999, 2))
                .Установить("Количество", ЮТест.Данные().СлучайноеПоложительноеЧисло(20))
                .Установить("Сумма", Конструктор.ДанныеСтроки().Цена * Конструктор.ДанныеСтроки().Количество)
        КонецЦикла;

        Ссылка = Конструктор.Провести();
    ```

2. Генерация произвольных фейковых данных

    ```bsl
    Функция ОписаниеСервера(Знач Идентификатор = Неопределено) Экспорт
        
        Описание = БазовоеОписаниеОбъекта(Идентификатор, "СРВ");
        
        Описание.Вставить("Адрес", ЮТТестовыеДанные.СлучайныйIPАдрес());
        Описание.Вставить("ЧастотаЯдра", ЮТТестовыеДанные.СлучайноеПоложительноеЧисло(4, 3));
        Описание.Вставить("КоличествоЯдер", ЮТТестовыеДанные.СлучайноеПоложительноеЧисло(10));
        Описание.Вставить("КоличествоПотоков", Описание.КоличествоЯдер * 2);
        Описание.Вставить("ПроизводительностьПроцессора", Описание.ЧастотаЯдра * Описание.КоличествоЯдер);
        Описание.Вставить("ОбъемПамяти", ЮТТестовыеДанные.СлучайноеПоложительноеЧисло(1024, 3));
        Описание.Вставить("Диски", Новый Массив());
        Описание.Вставить("Кластер");
        
        Для Инд = 1 По ЮТТестовыеДанные.СлучайноеЧисло(1, 3) Цикл
            Описание.Диски.Добавить(ОписаниеДиска());
        КонецЦикла;
        
        Возврат Описание;
        
    КонецФункции

    Функция ОписаниеЗаявкиНаСозданиеВМ() Экспорт
        
        Описание = Новый Структура();
        
        Описание.Вставить("Наименование",         "req-" + ЮТТестовыеДанные.СлучайнаяСтрока());
        Описание.Вставить("ДатаДобавления",       глПолучитьМосковскоеВремя());
        Описание.Вставить("ДатаОкончанияАренды",  глДобавитьКДате(глПолучитьМосковскоеВремя(), "ДЕНЬ", 2));
        Описание.Вставить("Адрес",                ЮТТестовыеДанные.СлучайныйIPАдрес());
        
        Описание.Вставить("Проект",               Проект());
        Описание.Вставить("Мейнтейнер",           ПараметрыСеанса.Сотрудник);
        
        Описание.Вставить("КоличествоCPU",        ЮТТестовыеДанные.СлучайноеЧисло(1, 4));
        Описание.Вставить("КоличествоПамяти",     ЮТТестовыеДанные.СлучайноеЧисло(1, 16));
        Описание.Вставить("КоличествоДисков",     ЮТТестовыеДанные.СлучайноеЧисло(1, 16));
        Описание.Вставить("ОперационнаяСистема",  ЮТТестовыеДанные.СоздатьЭлемент(Справочники.ОперационныеСистемы));
        
        Описание.Вставить("СредаЭксплуатации",    "");
        Описание.Вставить("Назначение",           ЮТТестовыеДанные.СоздатьЭлемент(Справочники.НазначенияВиртуальныхМашин));
        Описание.Вставить("ТипСреды",             Справочники.ТипыИнформационныхСред.BETA);
        Описание.Вставить("КодСервиса",           ЮТТестовыеДанные.СлучайнаяСтрока(1));
        
        Возврат Описание;
        
    КонецФункции

    Функция НовыйОбразDocker(Версия, ПоУмолчанию = Истина) Экспорт
        
        Данные = Новый Структура("Адрес, ВерсияПлатформы, ТипПлатформы, ИспользоватьПоУмолчанию");
        Данные.Адрес = "gitlab.ru/orais/ci_cd/1cws-apache24:" + Версия;
        Данные.ВерсияПлатформы = Версия;
        Данные.ТипПлатформы = Перечисления.ТипыСоединенияИсточникаДанных.Соединение1СПредприятие83Сервер;
        Данные.ИспользоватьПоУмолчанию = ПоУмолчанию;
        
        Возврат ЮТТестовыеДанные.СоздатьЭлемент(Справочники.ОбразыDocker, Версия, Данные);
        
    КонецФункции
    ```

3. Чтение из таблицы Markdown

```bsl
    Макет = 
    "| Имя                    | ИмяКоллекции            | Конструктор          | Группы | Ссылочный | Реквизиты | Измерения | Ресурсы | РеквизитыАдресации | ТабличныеЧасти |
    ||------------------------|-------------------------|----------------------|--------|-----------|-----------|-----------|---------|--------------------|----------------|
    || Справочник             | Справочники             | СоздатьЭлемент       | +      | +         | +         |           |         |                    | +              |
    || Документ               | Документы               | СоздатьДокумент      |        | +         | +         |           |         |                    | +              |
    || ПланВидовХарактеристик | ПланыВидовХарактеристик | СоздатьЭлемент       | +      | +         | +         |           |         |                    | +              |
    || ПланСчетов             | ПланыСчетов             | СоздатьСчет          |        | +         | +         |           |         |                    | +              |
    || ПланВидовРасчета       | ПланыВидовРасчета       | СоздатьВидРасчета    |        | +         | +         |           |         |                    | +              |
    || ПланОбмена             | ПланыОбмена             | СоздатьУзел          |        | +         | +         |           |         |                    | +              |
    || РегистрСведений        | РегистрыСведений        | СоздатьНаборЗаписей  |        |           | +         | +         | +       |                    |                |
    || РегистрНакопления      | РегистрыНакопления      | СоздатьНаборЗаписей  |        |           | +         | +         | +       |                    |                |
    || РегистрБухгалтерии     | РегистрыБухгалтерии     | СоздатьНаборЗаписей  |        |           | +         | +         | +       |                    |                |
    || РегистрРасчета         | РегистрыРасчета         | СоздатьНаборЗаписей  |        |           | +         | +         | +       |                    |                |
    || БизнесПроцесс          | БизнесПроцессы          | СоздатьБизнесПроцесс |        | +         | +         |           |         |                    | +              |
    || Задача                 | Задачи                  | СоздатьЗадачу        |        | +         | +         |           |         | +                  | +              |
    |";
    КоллекцияОписаний = ЮТТестовыеДанные.ТаблицаMarkDown(Макет);

    ТипыМетаданных = Новый Структура();

    Для Каждого Запись Из КоллекцияОписаний Цикл
        
        Описание = Новый Структура();
        Описание.Вставить("Имя", Запись.Имя);
        Описание.Вставить("ИмяКоллекции", Запись.ИмяКоллекции);
        Описание.Вставить("Конструктор", Запись.Конструктор);
        Описание.Вставить("Группы", Запись.Группы = "+");
        Описание.Вставить("Ссылочный", Запись.Ссылочный = "+");
        Описание.Вставить("Реквизиты", Запись.Реквизиты = "+");
        Описание.Вставить("Измерения", Запись.Измерения = "+");
        Описание.Вставить("Ресурсы", Запись.Ресурсы = "+");
        Описание.Вставить("РеквизитыАдресации", Запись.РеквизитыАдресации = "+");
        Описание.Вставить("ТабличныеЧасти", Запись.ТабличныеЧасти = "+");
        
        ТипыМетаданных.Вставить(Описание.Имя, Описание);
        ТипыМетаданных.Вставить(Описание.ИмяКоллекции, Описание);
        
    КонецЦикла;

    Возврат ТипыМетаданных;
```

4. Таблица значений из табличного документа (или таблицы markdown)

**Пример № 1**

В качестве источника данных можно использовать весь табличный документ. В этом случае будет получена таблица значений, начиная с 1-ой строки и 1-ой колонки табличного документа до первой пустой строки.

Пример табличного документа:

| Товар   | Товар.Поставщик | Товар.Вид | Цена  | Количество | Сумма |
|---------|-----------------|-----------|-------|------------|-------|
| Товар 1 | Поставщик 1     | Товар     | 100   | 1          | 100   |
| Товар 1 |                 |           | 100   | 2          | 200   |
| Товар 1 | Поставщик 2     | Товар     | 100   | 3          | 300   |
| Товар 2 | Поставщик 1     | Товар     | 2 000 | 1          | 2000  |
| Услуга  |                 | Услуга    | 300,5 | 1          | 300.5 |

Значение в колонке "Товар" является идентификатором ссылки. Для справочника значение этой колонки по умолчанию записывается в реквизит "Наименование" или "Код", в зависимости от того, какой из этих реквизитов является основным представлением. Для документа это значение никуда не записывается, оно лишь является идентификатором. Таким образом, если одному значению в колонке "Товар" соответствуют различные значения в других колонках, то в элемент справочника запишутся реквизиты из первой строки, а для других строк ссылка на этот элемент будет проставлена по соответствующему идентификатору:

```bsl
ИсходныеДанные = ПолучитьОбщийМакет("ЮТ_МакетТестовыхДанных");
	
ОписанияТипов = Новый Соответствие;
ОписанияТипов.Вставить("Товар", Новый ОписаниеТипов("СправочникСсылка.Товары"));
ОписанияТипов.Вставить("Цена", Новый ОписаниеТипов("Число"));
ОписанияТипов.Вставить("Количество", Новый ОписаниеТипов("Число"));
ОписанияТипов.Вставить("Сумма", Новый ОписаниеТипов("Число"));
	
ТаблицаТоваров = ЮТест.Данные().ТаблицаЗначенийИзТабличногоДокумента(
    ИсходныеДанные, 
    ОписанияТипов
);

Ютест.ОжидаетЧто(ТаблицаТоваров)
	.ИмеетТип("ТаблицаЗначений")
	.ИмеетДлину(5)
    .Свойство("[0].Товар.Наименование").Равно("Товар 1")
	.Свойство("[0].Товар.Поставщик.Наименование").Равно("Поставщик")
	.Свойство("[0].Товар.Вид").Равно(Перечисления.ВидыТоваров.Товар)
	.Свойство("[0].Количество").Равно(1)
	.Свойство("[0].Цена").Равно(100)
	.Свойство("[0].Сумма").Равно(100)
    .Свойство("[1].Товар").Равно(ТаблицаТоваров[0].Товар)
	.Свойство("[1].Количество").Равно(2)
	.Свойство("[1].Цена").Равно(100)
	.Свойство("[1].Сумма").Равно(200)
    .Свойство("[2].Товар").Равно(ТаблицаТоваров[0].Товар)
	.Свойство("[2].Количество").Равно(3)
	.Свойство("[2].Цена").Равно(100)
	.Свойство("[2].Сумма").Равно(300)
    .Свойство("[3].Товар.Наименование").Равно("Товар 2")
	.Свойство("[3].Товар.Поставщик.Наименование").Равно("Поставщик")
	.Свойство("[3].Товар.Вид").Равно(Перечисления.ВидыТоваров.Товар)
	.Свойство("[3].Количество").Равно(1)
	.Свойство("[3].Цена").Равно(2000)
	.Свойство("[3].Сумма").Равно(2000)
    .Свойство("[4].Товар.Наименование").Равно("Услуга")
	.Свойство("[4].Товар.Поставщик").НеЗаполнено()
	.Свойство("[4].Товар.Вид").Равно(Перечисления.ВидыТоваров.Услуга)
	.Свойство("[4].Количество").Равно(1)
	.Свойство("[4].Цена").Равно(300.5)
	.Свойство("[4].Сумма").Равно(300.5);
```

**Пример № 2**

Можно получить отдельную область из табличного документа и использовать ее в качестве источника данных для таблицы значений. Таким образом в одном табличном документе можно хранить несколько таблиц. 

Пример юнит-теста для проверки работы метода. На входе он получает таблицу значений, которую заполняет и/или возвращает. В одной области табличного документа - исходные данные, передаваемые в качестве входящего параметра, а в другой - таблица с ожидаемым значением.

_Исходные данные_:

| Товар   | Товар.Поставщик | Товар.Вид | Количество |
|---------|-----------------|-----------|------------|
| Товар 1 | Поставщик 1     | Товар     | 1          |
| Товар 2 | Поставщик 1     | Товар     | 1          |
| Услуга  |                 | Услуга    | 1          |

_Ожидаемое значение_:

| Товар   | Цена  | Количество | Сумма |
|---------|-------|------------|-------|
| Товар 1 | 100   | 1          | 100   |
| Товар 2 | 2 000 | 1          | 2000  |
| Услуга  | 300,5 | 1          | 300.5 |

```bsl
ТабличныйДокумент = ПолучитьОбщийМакет("ЮТ_МакетТестовыхДанных");
	
ИсходныеДанные = ТабличныйДокумент.ПолучитьОбласть(2, 1, 5, 4);
ОжидаемоеЗначение = ТабличныйДокумент.ПолучитьОбласть(7, 1, 10, 4);
	
ОписанияТипов = Новый Соответствие;
ОписанияТипов.Вставить("Товар", Новый ОписаниеТипов("СправочникСсылка.Товары"));
ОписанияТипов.Вставить("Цена", Новый ОписаниеТипов("Число"));
ОписанияТипов.Вставить("Количество", Новый ОписаниеТипов("Число"));
ОписанияТипов.Вставить("Сумма", Новый ОписаниеТипов("Число"));
	
// Для общего использования созданных значений используется переменная КешЗначений.
// В двух табличных документах одинаковый состав товаров. 
// Чтобы в обеих таблицах этому товару соответствовало одно значение справочника - 
// нужно передавать в параметре функции переменную, в которой будут храниться соответствия
// наименований к ссылкам на объекты. 
КэшЗначений = Новый Соответствие;
	
ТаблицаИсходныхДанных = ЮТест.Данные().ТаблицаЗначенийИзТабличногоДокумента(
	ИсходныеДанные, 
	ОписанияТипов,
	КэшЗначений
);
	
ТаблицаОжидаемыхЗначений = ЮТест.Данные().ТаблицаЗначенийИзТабличногоДокумента(
	ОжидаемоеЗначение, 
	ОписанияТипов,
	КэшЗначений
);
	
ТаблицаРезультата = ОбщийМодуль1.ТаблицаТоваровСЦенамиИзОстатков(ТаблицаИсходныхДанных);
	
Ютест.ОжидаетЧто(ТаблицаРезультата)
    .Равно(ТаблицаОжидаемыхЗначений);
```

**Пример № 3**

Интеграционный-тест для проверки формирования движений документа по некоторому регистру. В первой таблице - табличная часть документа. Во второй - реквизиты самого документа. В третьей - ожидаемые движения по регистру, который нужно протестировать.

_Реквизиты документа_:
| ПриходТовара | Дата | Поставщик   | Валюта | Склад | Организация |
|--------------|------|-------------|--------|-------|-------------|
| Документ 1   | Дата | Поставщик 1 | Валюта | Склад | Организация |

_Табличная часть документа_:
| Документ   | Товар   | Товар.Поставщик | Товар.Вид | Цена  | Количество | Сумма |
|------------|---------|-----------------|-----------|-------|------------|-------|
| Документ 1 | Товар 1 | Поставщик 1     | Товар     | 100   | 1          | 100   |
| Документ 1 | Товар 2 | Поставщик 1     | Товар     | 2 000 | 1          | 2000  |
| Документ 1 | Услуга  |                 | Услуга    | 300,5 | 1          | 300.5 |

_Ожидаемые движения_:
| Период | Активность | ВидДвижения | Регистратор | Склад | Товар   | Количество |
|--------|------------|-------------|-------------|-------|---------|------------|
| Дата   | Истина     | Приход      | Документ 1  | Склад | Товар 1 | 1          |
| Дата   | Истина     | Приход      | Документ 1  | Склад | Товар 2 | 1          |
| Дата   | Истина     | Приход      | Документ 1  | Склад | Услуга  | 1          |

```bsl
ДанныеДокументов = ТабличныйДокумент.ПолучитьОбласть("Документы");
ДанныеТоваров = ТабличныйДокумент.ПолучитьОбласть("Товары");
ОжидаемыеДвижения = ТабличныйДокумент.ПолучитьОбласть("Движения");
		
КэшЗначений = Новый Соответствие;

Организация = Ютест.КонтекстМодуля().Организация;
Поставщик = ЮТест.Данные().СоздатьЭлемент(Справочники.Контрагенты, "Поставщик");
ДатаДокумента = НачалоДня(ТекущаяДатаСеанса());

// Если нужно не создавать новое значение, а использовать существующее, 
// например, созданное ранее, то можно использовать соответствие - 
// значение из табличного документа к нужному значению.    
ЗаменяемыеЗначения = Новый Соответствие;
ЗаменяемыеЗначения.Вставить("Организация", Организация);
ЗаменяемыеЗначения.Вставить("Поставщик 1", Поставщик);
ЗаменяемыеЗначения.Вставить("Дата", ДатаДокумента);

ОписанияТипов = Новый Соответствие;
ОписанияТипов.Вставить("ПриходТовара", Новый ОписаниеТипов("ДокументСсылка.ПриходТовара"));
ОписанияТипов.Вставить("Дата", Новый ОписаниеТипов("Дата"));
ОписанияТипов.Вставить("Организация", Новый ОписаниеТипов("СправочникСсылка.Организации"));
ОписанияТипов.Вставить("Поставщик", Новый ОписаниеТипов("СправочникСсылка.Контрагенты"));
ОписанияТипов.Вставить("Склад", Новый ОписаниеТипов("СправочникСсылка.Склады"));
ОписанияТипов.Вставить("Валюта", Новый ОписаниеТипов("СправочникСсылка.Валюты"));

ТаблицаДокументов = ЮТест.Данные().ТаблицаЗначенийИзТабличногоДокумента(
	ДанныеДокументов, 
	ОписанияТипов,
	КэшЗначений,
	ЗаменяемыеЗначения
);
	
ОписанияТипов = Новый Соответствие;
ОписанияТипов.Вставить("Документ", Новый ОписаниеТипов("ДокументСсылка.ПриходТовара"));
ОписанияТипов.Вставить("Товар", Новый ОписаниеТипов("СправочникСсылка.Товары"));
ОписанияТипов.Вставить("Цена", Новый ОписаниеТипов("Число"));
ОписанияТипов.Вставить("Количество", Новый ОписаниеТипов("Число"));
ОписанияТипов.Вставить("Сумма", Новый ОписаниеТипов("Число"));

ТаблицаТоваров = ЮТест.Данные().ТаблицаЗначенийИзТабличногоДокумента(
	ДанныеТоваров, 
	ОписанияТипов,
	КэшЗначений,
	ЗаменяемыеЗначения
);

ОписанияТипов = Новый Соответствие;
ОписанияТипов.Вставить("Период", Новый ОписаниеТипов("Дата"));
ОписанияТипов.Вставить("Активность", Новый ОписаниеТипов("Булево"));
ОписанияТипов.Вставить("ВидДвижения", Новый ОписаниеТипов("ВидДвиженияНакопления"));
ОписанияТипов.Вставить("Регистратор", Новый ОписаниеТипов("ДокументСсылка.ПриходТовара"));
ОписанияТипов.Вставить("Склад", Новый ОписаниеТипов("СправочникСсылка.Склады"));
ОписанияТипов.Вставить("Товар", Новый ОписаниеТипов("СправочникСсылка.Товары"));
ОписанияТипов.Вставить("Количество", Новый ОписаниеТипов("Число"));

ТаблицаДвижений = ЮТест.Данные().ТаблицаЗначенийИзТабличногоДокумента(
	ОжидаемыеДвижения, 
	ОписанияТипов,
	КэшЗначений,
	ЗаменяемыеЗначения
);
	
Для Каждого ДанныеДокументов Из ТаблицаДокументов Цикл

    Отбор = Новый Структура("Документ", ДанныеДокументов.ПриходТовара);	
	ТоварыДокумента = ТаблицаТоваров.Скопировать(Отбор);
		
	ДокументОбъект = ДанныеДокументов.Документ.ПолучитьОбъект();
	ДокументОбъект.Товары.Загрузить(ТоварыДокумента);
	ДокументОбъект.Записать(РежимЗаписиДокумента.Проведение);
		
	ТоварныеЗапасы = ДокументОбъект.Движения.ТоварныеЗапасы;
	ТоварныеЗапасы.Прочитать();
	ТаблицаТоварныхЗапасов = ТоварныеЗапасы.Выгрузить();

    Отбор = Новый Структура("Регистратор", ДанныеДокументов.ПриходТовара);	
	ОжидаемыеТоварныеЗапасы = ТаблицаДвижений.Скопировать(Отбор);
		
	Ютест.ОжидаетЧто(ТаблицаТоварныхЗапасов)
		.Равно(ОжидаемыеТоварныеЗапасы);
		
КонецЦикла;
```

**Пример № 4**

Создание и заполнение объектов двойной вложенности и более (например, "Товар.Поставщик.ВидКонтрагента") не поддерживается. Если есть такая потребность, следует использовать переменную "ЗаменяемыеЗначения". Т.е. следует создать и заполнять нужный объект перед преобразованием табличного документа в таблицу значений, а затем передать его в функцию получения таблицы значений.

```bsl
Поставщик = ЮТест.Данные().КонструкторОбъекта(Справочники.Контрагенты)
   .Установить("ВидКонтрагента", ВидКонтрагента)
   .Записать();
		
// В табличном документе должна быть колонка [Товар.Поставщик] со значением "Некий поставщик".
// В этом случае в таблицу значений проставится значение, полученное из соответствия
ЗаменяемыеЗначения = Новый Соответствие;
ЗаменяемыеЗначения.Вставить("Некий поставщик", Поставщик);
		
ТаблицаЗначений = ЮТест.Данные().ТаблицаЗначенийИзТабличногоДокумента(
   ТабличныйДокумент, 
   ОписанияТипов, 
   Неопределено, 
   ЗаменяемыеЗначения
);

ЮТест.ОжидаетЧто(ТаблицаЗначений)
   .Свойство("[0].Товар.Поставщик.ВидКонтрагента").Равно(ВидКонтрагента);
```

**Пример № 5**

Можно использовать составные типы в колонках таблицы значений, но создание объектов метаданных для такой колонки не поддерживается. Можно воспользоваться соответствием "ЗаменяемыеЗначения", если потребуется в одну колонку записать значения разных типов.

```bsl
ТипАналитики = Новый ОписаниеТипов("СправочникСсылка.Товары,СправочникСсылка.Контрагенты");

ОписанияТипов = Новый Соответствие;
ОписанияТипов.Вставить("Аналитика", ТипАналитики);

Поставщик = ЮТест.Данные().СоздатьЭлемент(Справочники.Контрагенты);
Товар = ЮТест.Данные().СоздатьЭлемент(Справочники.Товары);
	
ЗаменяемыеЗначения = Новый Соответствие;
ЗаменяемыеЗначения.Вставить("Аналитика (Поставщик)", Поставщик);
ЗаменяемыеЗначения.Вставить("Аналитика (Товар)", Товар);
		
ТаблицаЗначений = ЮТест.Данные().ТаблицаЗначенийИзТабличногоДокумента(
   ТабличныйДокумент, 
   ОписанияТипов, 
   Неопределено, 
   ЗаменяемыеЗначения
);
	
ЮТест.ОжидаетЧто(ТаблицаЗначений)
   .Свойство("[0].Аналитика").Равно(Поставщик)
   .Свойство("[1].Аналитика").Равно(Товар)
;
```

**Некоторые особенности функционала**

При преобразовании табличного документа в таблицу значений существующие объекты метаданных не изменяются, только создаются новые. Нужно проявлять внимательность в случаях, если в базе уже имеются данные с тем же кодом/наименованием (и по ним используется контроль уникальности), что и в табличном документе.
