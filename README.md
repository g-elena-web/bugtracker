![экран списка ошибок](https://github.com/g-elena-web/bugtracker/blob/master/src/screenshots/index.jpg)

# Описание

Прототип системы учета ошибок, написанный на ColdFusion

# База данных

База данных PostgreSQL.
Скрип создания таблиц БД в pgadmin включен в репозиторий.
Используемое имя dataSource в ColdFusion: golovlevadb

# Подробнее

![редактирование существующей ошибки](https://github.com/g-elena-web/bugtracker/blob/master/src/screenshots/issueedit.jpg)

![история ошибки](https://github.com/g-elena-web/bugtracker/blob/master/src/screenshots/issuehistory.jpg)

- При нажатии на строку таблицы списка ошибок осуществляется переход на страницу редактирования и просмотра соответствующей ошибки, включая подробное описание и историю ошибки

- Изменение статуса ошибки возможно только в соответствии в заявленным жизненным циклом ошибки. Добавление комментария обязательно

- Все таблицы приложения сортируемы. Для того, чтобы отсортировать таблицу, требуется нажать на любой из ее заголовков

- В правом верхнем углом отображается элемент, содержащий имя и фамилию авторизованного пользователя. При нажатии на данный элемент происходит переход на страницу редактировании информации пользователя

- Приложение предназначено для просмотра на устройствах с шириной экрана 1100px и выше

![добавление новой ошибки](https://github.com/g-elena-web/bugtracker/blob/master/src/screenshots/addissue.jpg)

