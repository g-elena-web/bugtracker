CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	password VARCHAR(30) NOT NULL
);

CREATE TYPE issue_status AS ENUM('Новая', 'Открытая', 'Решенная', 'Закрытая');
CREATE TYPE issue_urgency AS ENUM('Очень срочно', 'Срочно', 'Несрочно', 'Совсем несрочно');
CREATE TYPE issue_severity AS ENUM('Авария', 'Критичная', 'Некритичная', 'Запрос на изменение');

CREATE TABLE issues (
	id SERIAL PRIMARY KEY,
	created_on TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	summary VARCHAR(128) NOT NULL,
	description VARCHAR(1024),
	user_id INT NOT NULL REFERENCES users (id),
	status issue_status NOT NULL,
	urgency issue_urgency NOT NULL,
	severity issue_severity NOT NULL
);

CREATE TYPE action_type AS ENUM('Ввод', 'Открытие', 'Решение', 'Закрытие');

CREATE TABLE history (
	id SERIAL PRIMARY KEY,
	issue_id INT NOT NULL REFERENCES issues (id),
	date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	action action_type NOT NULL,
	comment VARCHAR(1024),
	user_id INT NOT NULL REFERENCES users (id)
);