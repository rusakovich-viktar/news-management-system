# Система управления новостями - News Management System

## RESTful web-service, реализующей функционал для работы с системой управления новостями.
<details>
 <summary><strong>
 подробнее - раскрывающийся список заданий
</strong></summary>


## ЗАДАНИЕ: 
### Основные сущности:
-	news (новость) содержит поля: id, time, title, text и comments (list).
-	comment содержит поля: id, time, text, username и news_id.

### Требования:
1.	Использовать Spring Boot 3.x, Java 17, Gradle и PostgreSQL. 
2.	Разработать API согласно подходам REST (UI не надо):
       - CRUD для работы с новостью
       - CRUD для работы с комментарием
       - просмотр списка новостей (с пагинацией)
       - просмотр новости с комментариями относящимися к ней (с пагинацией)
         - /news
         -	/news/{newsId}
         -	/news/{newsId}/comments
       - полнотекстовый поиск по различным параметрам (для новостей и комментариев). Для потенциально объемных запросов реализовать постраничность
3.	Разместить проект в любом из публичных git-репозиториев (Bitbucket, github, gitlab)
4.	Код должен быть легко читаемый и понятный, с использованием паттернов проектирования
5.	Реализовать на основе Spring @Profile (e.g. test & prod) подключение к базам данных. 
6.	Подключить liquibase: 
      - при запуске сервиса накатываются скрипты на рабочую БД (генерируются необходимые таблицы из одного файла и наполняются таблицы данными из другого файла, 20 новостей и 10 комментариев, связанных с каждой новостью
      - при запуске тестов должен подхватываться скрипт по генерации необходимых таблиц + накатить данные по заполнению таблиц (третий файл)
7.	Создать реализацию кэша, для хранения сущностей. Реализовать два алгоритма  LRU и LFU. Алгоритм и максимальный размер коллекции должны читаться из файла application.yml. Алгоритм работы с кешем:
      -	GET - ищем в кеше и если там данных нет, то достаем объект из dao, сохраняем в кеш и возвращаем
      -	POST - сохраняем в dao и потом сохраняем в кеше
      -	DELETE - удаляем из dao и потом удаляем в кеша
      -	PUT - обновление/вставка в dao и потом обновление/вставка в кеше.
8.	Весь код должен быть покрыт юнит-тестами (80%) (сервисный слой – 100%)
9.	Реализовать логирование запрос-ответ в аспектном стиле (для слоя Controlles), а также логирование по уровням в отдельных слоях приложения, используя logback
10.	Предусмотреть обработку исключений и интерпретацию их согласно REST (см. https://spring.io/blog/2013/11/01/exception-handling-in-spring-mvc)
11.	Все настройки должны быть вынесены в *.yml
12.	Код должен быть документирован @JavaDoc, а назначение приложения и его интерфейс и настройки должны быть описаны в README.md файле
13.	Использовать Spring REST Docs или другие средства автоматического документирования (например asciidoctor https://asciidoctor.org/docs/asciidoctor-gradle-plugin/ и т.д) и/или Swagger (OpenAPI 3.0)
14.	Использовать testcontainers в тестах на persistence layer (для БД)
15.	Написать интеграционные тесты
16.	Использовать WireMock в тестах для слоя clients (разбиение на микросервисы)
17.	Использовать Docker (написать Dockerfile – для spring boot приложения, docker-compose.yml для поднятия БД и приложения в контейнерах и настроить взаимодействие между ними)

18. <sup>*</sup> Подключить кэш провайдер Redis (в docker) (в случае реализации, использовать @Profile для переключения между LRU/LFU и Redis)
19.	<sup>*</sup> Spring Security:
       -	API для регистрации пользователей с ролями admin/journalist/subscriber
       -	Администратор (role admin) может производить CRUD-операции со всеми сущностями
       -	Журналист (role journalist) может добавлять и изменять/удалять только свои новости 
       -	Подписчик (role subscriber) может добавлять и изменять/удалять только свои комментарии
       -	Незарегистрированные пользователи могут только просматривать новости и комментарии
Создать отдельный микросервис с реляционной базой (postgreSQL) хранящей
информацию о пользователях/ролях. Из главного микросервиса (отвечающего за
новости) запрашивать эту информацию по  REST с использованием spring-cloud-
feign-client.
20. <sup>*</sup> Настроить Spring Cloud Config (вынести в отдельный сервис и настроить разрабатываемый сервис на получение их в зависимости от профиля)
21.	<sup>*</sup> Реализацию логирования п.9 и обработку исключений п.10 вынести в отдельные
spring-boot-starter-ы.
22.	<sup>**</sup> Сущности веб интерфейса (DTO) должны генерироваться при сборке проекта из .proto файлов (см. https://github.com/google/protobuf-gradle-plugin)

“*” – необходимо минимум выполнить два задания со звёздочкой, больше заданий будет существенным плюсом. К этим пунктам лучше приступать после качественного решения базовых задач с применением принципов SOLID, декларативных подходов, оптимальных алгоритмов.
</details>

## Структура основного репозитория:
1. Основной репозиторий включает в себя ссылки все микросервисы, а также docker-compose файл и скрипт для запуска:
   - [ОСНОВНОЙ РЕПОЗИТОРИЙ - News Management System](https://github.com/rusakovich-viktar/news-management-system/tree/develop)
2. Репозиторий с общей точкой доступа в сервис с API для клиентов:
   - [micro-gateway](https://github.com/rusakovich-viktar/micro-gateway/tree/develop)
3. Репозиторий с микросервисом новостей:
   - [micro-news](https://github.com/rusakovich-viktar/micro-news/tree/develop)
4. Репозиторий с микросервисом комментариев:
   - [micro-comments](https://github.com/rusakovich-viktar/micro-comments/tree/develop)
5. Репозиторий с микросервисом для полнотекстового поиска в базе данных:
   - [micro-search](https://github.com/rusakovich-viktar/micro-search/tree/develop)
6. Репозиторий с сервером конфигураций для микросервисов:
   - [micro-config-server-cloud](https://github.com/rusakovich-viktar/micro-config-server-cloud/tree/develop)
7. Репозиторий со стартером для логирования действий контроллеров:
   - [logger-aspect-starter](https://github.com/rusakovich-viktar/logger-aspect-starter/tree/develop)
8. Репозиторий со стартером для глобальной обработки исключений:
   - [exception-handler-starter](https://github.com/rusakovich-viktar/exception-handler-starter/tree/develop)
9. Также отдельно находится репозиторий хранящий сами файлы конфигураций:
   - [cloud-yml](https://github.com/rusakovich-viktar/cloud-yml/tree/develop)

## Архитектура News Management System
	Использованы Spring Boot 3.2.3, Java 17, Gradle 8.5 и PostgreSQL 15.1. 
 ![структура](https://github.com/rusakovich-viktar/NMS-resourses/raw/rusakovich-viktar-patch-1/spring_cloud_gateway.png)

## Реализация. Общие пояснения к деталям

Здесь расположена общая информация по взаимодействию между микросервисами, а также общие пояснения к заданию.
Детали реализации по каждому микросервису будут в репозитории конкретного микросервиса.

### Используется одна база данных, к каждой таблице которой обращается свой микросервис
![структура](https://github.com/rusakovich-viktar/NMS-resourses/raw/rusakovich-viktar-patch-1/Снимок%20экрана%202024-03-04%20151246.jpg)

### Созданы 5 микросервисов на основе Spring Boot. Микросервисы между собой взаимодействуют посредством Spring Cloud OpenFeign

1. Микросервис новостей micro-news. Реализует работу с новостями, CRUD операции с новостями, взаимодействие с БД.
2. Микросервис комментариев micro-comments. Реализует работу с комментариями, CRUD операции с комментариями, взаимодействие с БД.
3. Микросервис micro-search для полнотекстового поиска. Реализует поиск информации в базе данных. Реализован совместно с ElasticSearch, который поднимается в докер-контейнере.
4. Микросервис micro-gateway предоставляющий единую точку входа для клиентов (API). Реализован на Spring Cloud Gateway.
5. Микросервис micro-config-server-cloud обеспечивает поддержку внешней конфигурации в распределенной системе на стороне сервера. Реализован на Spring Cloud Config

### Реализованы и подключены два Spring Boot Starter:

- logger-aspect-starter реализует логирование запрос-ответ в аспектном стиле (для слоя Controlles)
- exception-handler-starter реализует глобальную обработку исключений и интерпретацию их согласно REST.
Стартеры при сборке загружаются первыми, далее из локального репозитория .m2 как зависимости подключаются к другим микросервисам.


### Реализована поддержка @Profile prod и dev. Конфиги вынесены в Spring Cloud Config:

- В контексте приложения условно будем считать что профиль prod будет применяться для запуска и взаимодействия микосервисов в docker сети.
Для локальной разработки, а также для тестирования будем использовать профиль dev.
- Профили конфигурируются через micro-config-server-cloud, поэтому он должен быть запущен или в контейнере для профиля prod или локально для профиля dev.
- Для смены профиля dev(локально и тесты) и prod(в докере) **необходимо в папках каждого проекта в application.yml сменить активный профиль** на 
profiles: active: dev 
или 
profiles: active: prod
___
Если будет необходимость запустить проект локально (не в докер контейнере) создайте у себя базу данных
с параметрами
- url: jdbc:postgresql://localhost:5432/news_comments
- username: postgres
- password: postgres
- смените  @Profile на dev в проектах news comments search gateway в файле application.yml
    - profiles: active: dev
___

### Подключен Liquibase — система управления миграциями базы данных. Настроены контексты и профили:

- При запуске сервиса news накатываются скрипты на рабочую БД (генерируются необходимые таблицы из одного файла и наполняются таблицы данными из другого файла, 20 новостей и 10 комментариев, связанных с каждой новостью.
при запуске тестов подхватывается скрипт по генерации необходимых таблиц + дополнительно из sql файлов заполняются таблицы во время тестирования.
- Реализовано - через разные changelog и контексты Liquibase. Для тестов подхватывается еще скрипт наполнения таблиц.


### Создана и подключена реализация кэша, для хранения сущностей:

- Самописный кеш реализован согласно заданию через Proxy с использованием AOP. 
- Подключен для микросервисов новостей и комментариев в _@Profile dev._

### Подключен кэш провайдер Redis (в docker):

Подключен для микросервисов новостей и комментариев в _@Profile prod._


### Документация swagger доступна по пути `/api`
```
Код документирован @JavaDoc, подключен Swagger (OpenAPI 3.0)
```

### Логирование 

- Логи пишутся в папки с проектами cd /logs. 
- разделил логи на два потока - они пишутся в разные файлы: 
  - Обшие 
  - и важные от WARN и выше 


### Тестирование. Сервисный слой покрыт на 100%, весь код 85-90%. Скрины по микросервисам под катом.
<details>
  <summary><strong>Скрины покрытия</strong></summary>

![news-coverage](https://github.com/rusakovich-viktar/NMS-resourses/raw/rusakovich-viktar-patch-1/news-coverage.jpg)
![comments-coverage](https://github.com/rusakovich-viktar/NMS-resourses/raw/rusakovich-viktar-patch-1/com-coverage.jpg)
![search-coverage](https://github.com/rusakovich-viktar/NMS-resourses/raw/rusakovich-viktar-patch-1/search-coverage.jpg)
![gateway-coverage](https://github.com/rusakovich-viktar/NMS-resourses/raw/rusakovich-viktar-patch-1/gate-coverage.jpg)
</details>

	Весь код покрыт юнит-тестами от 80% (сервисный слой – 100%)
    Использованы testcontainers в тестах на persistence layer (для БД)
 	Написаны интеграционные тесты
    Использован WireMock в тестах для слоя clients (разбиение на микросервисы)

    Для работы нужны работающие сервис elastic в контейнере и postgres локально.    
    Все порты должны быть свободны, чтобы не мешать поднятию контекста.    
    Также для тестирования база данных поднималась локально. Тестирование проводится в @Profile dev.

### Использован Docker
<details>
  <summary><strong>Скрины работающих контейнеров</strong></summary>

![docker](https://github.com/rusakovich-viktar/NMS-resourses/raw/rusakovich-viktar-patch-1/Снимок%20экрана%202024-03-06%20012000.jpg)

</details>


Написаны Dockerfile – для каждого spring boot приложения, создан общий docker-compose.yml для поднятия всех сервисов в контейнерах, настроено взаимодействие между ними)


# Как запустить приложение
У вас должен быть установлен [Gradle](https://gradle.org/next-steps/?version=8.5&format=all) для сборки проектов и [Docker](https://www.docker.com/products/docker-desktop/) для создания контейнеров.

В данном проекте все микросервисы расположены как подмодули репозитория News Management System. Несмотря на то, что они называются подмодулями, это абсолютно самостоятельные проекты, никак не связанные между собой зависимостями и не являющие подмодулями один для одного. Это сделано для удобства их хранения и управления, а также для упрощения ссылок друг на друга.
1. **Чтобы склонировать репозиторий с GitHub вместе со всеми его подмодулями, вы можете использовать следующую команду:**

```bash
git clone --recurse-submodules https://github.com/rusakovich-viktar/news-management-system.git
```

или же можно пойти стандартным путем склонировав его себе, а после синхронизировать подмодули двумя последующими командами:
 ```
git clone https://github.com/rusakovich-viktar/news-management-system.git
 ```
 ```
git submodule update --init --recursive
 ```
2. **Перейти в созданную папку**
	 `cd news-management-system`
3. **Запустить команду**

`./init.sh`

или

`/init.sh`

в зависимости от типа системы.
Данная команда запустит баш скрипт из корня проекта, который сам по очереди зайдет в каждый проект и соберет его командой `gradle build`, начав со стартеров, зарегистрирует стартеры в локальном репозитории `gradle build publish`, чтобы прочие микросервисы могли использовать зависимости при сборке своих проектов, а также по завершении автоматически выполнится команда  `docker-compose up`, которая запустит в работу инструкции по сборке проекта, описанные в *docker-compose* файле. Причем запуск начнется с сервера конфигураций, чтобы он раздал конфигурации прочим микросервисам.

4. **Немного подождать**
на этом этапе пройдет сборка каждого проекта и регистрация стартеров. Далее Docker-compose файл выкачает необходимые image из докерхаб и соберет image наших микросервисов из инструкции в докерфайлах и докер-компоуз файле. Контейнеры будут запускаться в строгой зависимости, друг за другом, убедившись в доступности нужных зависимостей по healthcheck.

`В данном случае я отказался от двухфазной сборки проектов, потому что иначе сложно зарегистрировать стартеры и начать сборку одной командой.`

### Документация swagger доступна по пути `/api`

```
Код документирован @JavaDoc, подключен Swagger (OpenAPI 3.0)
```

