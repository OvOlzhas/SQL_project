-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--              DDL SCRIPTS
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE SCHEMA IF NOT EXISTS project;

-- USERS TABLE
CREATE TABLE project.users (
    user_id     serial      PRIMARY KEY,
    nickname    text        NOT NULL,
    level       decimal     CHECK (level >= 1),
    cash        decimal     CHECK (cash >= 0)
);

-- USERS SCD 4-type
CREATE TABLE project.users_hist (
    id          serial      PRIMARY KEY,
    user_id     integer     NOT NULL,
    nickname    text        NOT NULL,
    level       decimal     CHECK (level >= 1),
    cash        decimal     CHECK (cash >= 0),
    efct_at     timestamp   NOT NULL,
    end_at      timestamp   NOT NULL
);

ALTER TABLE project.users ADD COLUMN efct_at timestamp NOT NULL;

-- GAMES TABLE
CREATE TABLE project.games (
    game_id     serial      PRIMARY KEY,
    name        text        UNIQUE NOT NULL,
    price       decimal     CHECK (price >= 0),
    reviews     decimal     CHECK (0 <= reviews AND reviews <= 100),
    discount    integer     CHECK (0 <= discount AND discount <= 100)
);

-- STATISTICS TABLE
CREATE TABLE project.statistics (
    user_id     integer     NOT NULL REFERENCES project.users(user_id),
    game_id     integer     NOT NULL REFERENCES project.games(game_id),
    buy_at      timestamp   NOT NULL,
    spend_time  integer     NOT NULL,
    achievements_count integer CHECK (achievements_count >= 0),
    PRIMARY KEY (user_id, game_id)
);

-- ITEMS TABLE
CREATE TABLE project.items (
    item_id     serial      PRIMARY KEY,
    user_id     integer     NOT NULL REFERENCES project.users(user_id),
    game_id     integer     NOT NULL REFERENCES project.games(game_id),
    name        text        NOT NULL,
    item_type   integer     NOT NULL
);

-- COMMUNITY MARKET TABLE
CREATE TABLE project.market (
    item_id     integer     NOT NULL REFERENCES project.items(item_id),
    price       decimal     CHECK (price >= 0),
    publish_at  timestamp   NOT NULL,
    PRIMARY KEY (item_id)
);

-- DEALS TABLE
CREATE TABLE project.deals (
    deal_id     serial      PRIMARY KEY,
    item_id     integer     NOT NULL REFERENCES project.items(item_id),
    seller_id   integer     NOT NULL REFERENCES project.users(user_id),
    buyer_id    integer     NOT NULL REFERENCES project.users(user_id),
    price       decimal     CHECK (price >= 0),
    buy_at      timestamp   NOT NULL
);

-- PURCHASE HISTORY TABLE
CREATE TABLE project.history (
    user_id     integer     NOT NULL REFERENCES project.users(user_id),
    game_id     integer     NOT NULL REFERENCES project.games(game_id),
    price       decimal     CHECK (price >= 0),
    PRIMARY KEY (user_id, game_id)
);

-- ACHIEVEMENTS TABLE
CREATE TABLE project.achievements (
    user_id     integer     NOT NULL REFERENCES project.users(user_id),
    game_id     integer     NOT NULL REFERENCES project.games(game_id),
    name        text        NOT NULL,
    requirements text,
    PRIMARY KEY (user_id, game_id, name)
);







-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--               INSERTIONS
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- USERS INSERTIONS
INSERT INTO project.users (nickname, level, cash, efct_at)
VALUES ('tetatet', 40.10, 288.09, '2016-02-02 13:37:00');
INSERT INTO project.users (nickname, level, cash, efct_at)
VALUES ('Relayx', 18.32, 10000, '2017-05-09 15:36:00');
INSERT INTO project.users (nickname, level, cash, efct_at)
VALUES ('Volshebniy', 6.24, 472.00, '2016-04-12 02:28:00');
INSERT INTO project.users (nickname, level, cash, efct_at)
VALUES ('Писич', 9.14, 666.00, '2014-04-05 15:36:00');
INSERT INTO project.users (nickname, level, cash, efct_at)
VALUES ('Шрек', 1.01, 0.00, '2020-03-17 12:12:00');
INSERT INTO project.users (nickname, level, cash, efct_at)
VALUES ('KOLAA', 8.54, 293.46, '2013-03-15 01:01:00');
INSERT INTO project.users (nickname, level, cash, efct_at)
VALUES ('diamond', 2.43, 0.01, '2020-05-08 22:12:00');
INSERT INTO project.users (nickname, level, cash, efct_at)
VALUES ('bul''bul''ator3000', 5.82, 103.12, '2019-05-03 12:35:00');
INSERT INTO project.users (nickname, level, cash, efct_at)
VALUES ('Tryapka', 99.99, 9999.99, '2001-02-05 00:00:00');
INSERT INTO project.users (nickname, level, cash, efct_at)
VALUES ('Heinz', 5.00, 20.22, '1869-05-04 21:54:00');

-- GAMES INSERTIONS
INSERT INTO project.games (name, price, reviews, discount)
VALUES ('Elden Ring', 3999, 94, 0);
INSERT INTO project.games (name, price, reviews, discount)
VALUES ('Hollow Knight', 349, 87, 60);
INSERT INTO project.games (name, price, reviews, discount)
VALUES ('Poppy Playtime', 0, 78, 0);
INSERT INTO project.games (name, price, reviews, discount)
VALUES ('RimWorld', 619, 87, 0);
INSERT INTO project.games (name, price, reviews, discount)
VALUES ('Among Us', 133, 85, 0);
INSERT INTO project.games (name, price, reviews, discount)
VALUES ('Serious Sam HD: The First Encounter', 49, 81, 0);
INSERT INTO project.games (name, price, reviews, discount)
VALUES ('Omori', 435, 87, 0);
INSERT INTO project.games (name, price, reviews, discount)
VALUES ('Celeste', 419, 88, 0);
INSERT INTO project.games (name, price, reviews, discount)
VALUES ('The Binding of Isaac: Rebirth', 449, 86, 0);
INSERT INTO project.games (name, price, reviews, discount)
VALUES ('Everlasting Summer', 0, 90, 0);

-- STATISTICS INSERTIONS
INSERT INTO project.statistics (user_id, game_id, buy_at, spend_time, achievements_count)
VALUES (1, 1, '2022-03-04', 152000, 3);
INSERT INTO project.statistics (user_id, game_id, buy_at, spend_time, achievements_count)
VALUES (1, 3, '2022-05-08', 8000, 0);
INSERT INTO project.statistics (user_id, game_id, buy_at, spend_time, achievements_count)
VALUES (2, 2, '2020-06-03', 364000, 1);
INSERT INTO project.statistics (user_id, game_id, buy_at, spend_time, achievements_count)
VALUES (3, 4, '2021-03-23', 160000, 0);
INSERT INTO project.statistics (user_id, game_id, buy_at, spend_time, achievements_count)
VALUES (3, 8, '2021-11-20', 90000, 1);
INSERT INTO project.statistics (user_id, game_id, buy_at, spend_time, achievements_count)
VALUES (4, 5, '2020-10-12', 36000, 2);
INSERT INTO project.statistics (user_id, game_id, buy_at, spend_time, achievements_count)
VALUES (6, 6, '2017-03-24', 18000, 0);
INSERT INTO project.statistics (user_id, game_id, buy_at, spend_time, achievements_count)
VALUES (8, 5, '2019-07-30', 40000, 1);
INSERT INTO project.statistics (user_id, game_id, buy_at, spend_time, achievements_count)
VALUES (9, 9, '2022-05-08', 999000, 1);
INSERT INTO project.statistics (user_id, game_id, buy_at, spend_time, achievements_count)
VALUES (10, 7, '2020-02-10', 10000, 1);

-- ITEMS INSERTIONS
INSERT INTO project.items (user_id, game_id, name, item_type)
VALUES (1, 1, 'Коллекционная карточка Рая Лукария', 1233);
INSERT INTO project.items (user_id, game_id, name, item_type)
VALUES (1, 1, 'Deathbed Smalls', 666);
INSERT INTO project.items (user_id, game_id, name, item_type)
VALUES (2, 2, 'Гвоздь душ', 666);
INSERT INTO project.items (user_id, game_id, name, item_type)
VALUES (3, 8, 'Коллекционная карточка Бабки', 1337);
INSERT INTO project.items (user_id, game_id, name, item_type)
VALUES (4, 5, 'Нож в спине', 1212);
INSERT INTO project.items (user_id, game_id, name, item_type)
VALUES (6, 6, 'Огнемет', 321);
INSERT INTO project.items (user_id, game_id, name, item_type)
VALUES (8, 5, 'Нож в руке', 6436);
INSERT INTO project.items (user_id, game_id, name, item_type)
VALUES (9, 9, 'Сердце матери', 555);
INSERT INTO project.items (user_id, game_id, name, item_type)
VALUES (9, 9, 'Sacred heart', 9943);
INSERT INTO project.items (user_id, game_id, name, item_type)
VALUES (9, 9, 'God head', 9943);
INSERT INTO project.items (user_id, game_id, name, item_type)
VALUES (10, 7, 'Скрипка', 4039);
INSERT INTO project.items (user_id, game_id, name, item_type)
VALUES (10, 7, 'Нож', 1);

-- COMMUNITY MARKET INSERTIONS
INSERT INTO project.market (item_id, price, publish_at)
VALUES (1, 160.01, '2022-04-20');
INSERT INTO project.market (item_id, price, publish_at)
VALUES (3, 92.23, '2022-02-03');
INSERT INTO project.market (item_id, price, publish_at)
VALUES (4, 0.00, '2022-01-10');
INSERT INTO project.market (item_id, price, publish_at)
VALUES (5, 0.00, '2022-01-01');
INSERT INTO project.market (item_id, price, publish_at)
VALUES (7, 10.00, '2022-03-30');
INSERT INTO project.market (item_id, price, publish_at)
VALUES (8, 5000.99, '2022-02-25');
INSERT INTO project.market (item_id, price, publish_at)
VALUES (9, 4500.12, '2022-02-28');
INSERT INTO project.market (item_id, price, publish_at)
VALUES (10, 10000.00, '2022-03-05');
INSERT INTO project.market (item_id, price, publish_at)
VALUES (11, 10000.00, '2022-01-23');
INSERT INTO project.market (item_id, price, publish_at)
VALUES (12, 100.00, '2022-05-05');

-- DEALS INSERTIONS
INSERT INTO project.deals (item_id, seller_id, buyer_id, price, buy_at)
VALUES (1, 2, 1, 100, '2022-04-04');
INSERT INTO project.deals (item_id, seller_id, buyer_id, price, buy_at)
VALUES (3, 4, 1, 150, '2022-01-30');
INSERT INTO project.deals (item_id, seller_id, buyer_id, price, buy_at)
VALUES (3, 1, 3, 120, '2022-02-01');
INSERT INTO project.deals (item_id, seller_id, buyer_id, price, buy_at)
VALUES (8, 4, 8, 3000, '2022-02-10');
INSERT INTO project.deals (item_id, seller_id, buyer_id, price, buy_at)
VALUES (8, 8, 9, 3999, '2022-02-15');
INSERT INTO project.deals (item_id, seller_id, buyer_id, price, buy_at)
VALUES (10, 2, 1, 5432, '2022-02-15');
INSERT INTO project.deals (item_id, seller_id, buyer_id, price, buy_at)
VALUES (10, 1, 4, 5000, '2022-02-15');
INSERT INTO project.deals (item_id, seller_id, buyer_id, price, buy_at)
VALUES (10, 4, 3, 7499, '2022-02-15');
INSERT INTO project.deals (item_id, seller_id, buyer_id, price, buy_at)
VALUES (10, 3, 9, 7999, '2022-02-15');
INSERT INTO project.deals (item_id, seller_id, buyer_id, price, buy_at)
VALUES (10, 9, 10, 8999, '2022-02-15');

-- PURCHASE HISTORY INSERTIONS
INSERT INTO project.history (user_id, game_id, price)
VALUES (1, 1, 1999);
INSERT INTO project.history (user_id, game_id, price)
VALUES (1, 3, 159);
INSERT INTO project.history (user_id, game_id, price)
VALUES (2, 2, 349);
INSERT INTO project.history (user_id, game_id, price)
VALUES (3, 4, 309);
INSERT INTO project.history (user_id, game_id, price)
VALUES (3, 8, 419);
INSERT INTO project.history (user_id, game_id, price)
VALUES (4, 5, 133);
INSERT INTO project.history (user_id, game_id, price)
VALUES (6, 6, 49);
INSERT INTO project.history (user_id, game_id, price)
VALUES (8, 5, 99);
INSERT INTO project.history (user_id, game_id, price)
VALUES (9, 9, 399);
INSERT INTO project.history (user_id, game_id, price)
VALUES (10, 7, 435);

-- ACHIVEMENTS INSERTIONS
INSERT INTO project.achievements (user_id, game_id, name, requirements)
VALUES (1, 1, 'Крепость Круглого стола', 'Вы прибыли в крепость Круглого стола');
INSERT INTO project.achievements (user_id, game_id, name, requirements)
VALUES (1, 1, 'Хозяин осколка Годрик', 'Хозяин осколка Годрик повержен');
INSERT INTO project.achievements (user_id, game_id, name, requirements)
VALUES (1, 1, 'Драконий солдат Нокстеллы', 'Драконий солдат Нокстеллы повержен');
INSERT INTO project.achievements (user_id, game_id, name, requirements)
VALUES (2, 2, 'Чистый сосуд', 'Убить чистый сосуд');
INSERT INTO project.achievements (user_id, game_id, name, requirements)
VALUES (3, 8, 'Не так уж и сложно', 'Собрать все клубники');
INSERT INTO project.achievements (user_id, game_id, name, requirements)
VALUES (4, 5, 'Боль в спине', 'Умереть от рук Imposter-a будучи Imposter-ом');
INSERT INTO project.achievements (user_id, game_id, name, requirements)
VALUES (4, 5, 'Безвыходная ситуация', 'Остаться одному против Imposter-ов');
INSERT INTO project.achievements (user_id, game_id, name, requirements)
VALUES (8, 5, 'Не лучший напарник', 'Убить Imposter-a будучи Imposter-ом');
INSERT INTO project.achievements (user_id, game_id, name, requirements)
VALUES (9, 9, 'Платинум голд', 'Открыть все предметы в игре');
INSERT INTO project.achievements (user_id, game_id, name, requirements)
VALUES (10, 7, 'Хорошая концовка', 'Убить себя');









-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--    <= 10 UPDATE, SELECT, INSERT, DELETE queries
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- CRUD - {Create, Read, Update, Delete}
-- 
-- Create - INSERT
-- Read   - SELECT
-- Update - UPDATE
-- DELETE - DELETE

-- ~~~~~~
-- SELECT
-- ~~~~~~

-- Все достижения пользователя ('tetatet')
SELECT games.name as game, ach.name as achivement
FROM project.achievements as ach, project.users as users, project.games as games
WHERE users.user_id = ach.user_id AND games.game_id = ach.game_id AND nickname = 'tetatet';

-- Список покупок игр (покупатель, игра, цена, дата)
SELECT nickname, games.name, hist.price, stat.buy_at
FROM project.history as hist, project.users as users, project.games as games, project.statistics as stat
WHERE hist.user_id = users.user_id AND hist.game_id = games.game_id
  AND hist.game_id = stat.game_id AND hist.user_id = stat.user_id;

-- Список сделок на торговой площадке (продавец, покупатель, предмет, цена, дата)
SELECT users1.nickname as seller, users2.nickname as buyer, items.name as item, price, buy_at
FROM project.deals as deals, project.users as users1, project.users as users2, project.items as items
WHERE deals.seller_id = users1.user_id AND deals.buyer_id = users2.user_id AND
      deals.item_id = items.item_id;

-- Статистика в играх у игрока (игра, дата покупки, проведенное время в секундах, количество достижений)
SELECT games.name, stat.buy_at, stat.spend_time, stat.achievements_count
FROM project.statistics as stat, project.users as users, project.games as games
WHERE users.user_id = stat.user_id AND stat.game_id = games.game_id AND nickname = 'tetatet';

-- ~~~~~~
-- INSERT
-- ~~~~~~

-- Добавление игры
INSERT INTO project.games (name, price, reviews, discount)
VALUES ('Симулятор сдачи проекта по БД', 0.00, 100, 0);

-- Добавление пользователя
INSERT INTO project.users (nickname, level, cash, efct_at)
VALUES ('SAS', 1, 0.00, CURRENT_TIMESTAMP);

-- ~~~~~~
-- UPDATE
-- ~~~~~~

-- Скидка на игру
UPDATE project.games SET discount = 10 WHERE game_id = 1;

-- Пользователь провел в игре 10 секунд
UPDATE project.statistics SET spend_time = spend_time + 10 WHERE user_id = 1 AND game_id = 1;

-- ~~~~~~
-- DELETE
-- ~~~~~~

-- Удаление игры
DELETE FROM project.games WHERE game_id = 11;

-- Удаления предмета из игры
DELETE FROM project.items WHERE name = 'Название предмета' AND game_id = 1;







-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-- Write at least  meaningful SELECT queries using:
-- 1. GROUP_BY + HAVING
-- 2. ORDER_BY
-- 3. <func>(...) OVER(...):
--    1. PARTITION BY
--    2. ORDER BY
--    3. PARTITION BY + ORDER_BY
--    4. <func> - all three kinds of functions:
--                aggregate, range, offset
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- [GROUP_BY + HAVING] Суммарное количество проведенного времени в игре 
SELECT g.name, SUM(spend_time)
FROM project.statistics JOIN project.games g on g.game_id = statistics.game_id
GROUP BY g.name
HAVING g.name = 'Among Us';

-- [ORDER_BY] Список игр в убывающем порядке отзывов
SELECT g.name, g.reviews, g.price
FROM project.games g
ORDER BY g.reviews DESC;

-- [PARTITION BY] Суммарное количество проведенного времени в играх
SELECT DISTINCT g.name, SUM(spend_time) OVER(partition by g.name)
FROM project.statistics JOIN project.games g on g.game_id = statistics.game_id
GROUP BY g.name, spend_time;

-- [ORDER_BY] Все игры с самыми высокоми отзывами, где различных отзывов 5
SELECT newt.name, newt.reviews
FROM (
SELECT games.name, games.reviews, dense_rank() OVER(ORDER BY games.reviews DESC) as rank
FROM project.games as games
ORDER BY games.reviews DESC) as newt
WHERE rank <= 5;

-- [PARTITION BY + ORDER_BY] Список предметов со столбцом, который содержит nickname предыдущего владельца
WITH hist_items AS (
    SELECT item_id, seller_id as user_id, buy_at
    FROM project.deals
    UNION
    SELECT item_id, user_id, '9999-12-31'
    FROM project.items
    ), items_with_last_id AS (
    SELECT item_id, user_id, LAG(user_id) OVER(PARTITION BY item_id ORDER BY buy_at) as last_id
    FROM hist_items
    ORDER BY item_id, buy_at
)

SELECT DISTINCT items.item_id, name, user1.nickname as current, CASE WHEN it_last.last_id IS NULL
                                                                     THEN NULL
                                                                     ELSE user2.nickname END as last
FROM project.items as items, items_with_last_id as it_last, project.users as user1, project.users as user2
WHERE items.item_id = it_last.item_id AND items.user_id = it_last.user_id AND
      items.user_id = user1.user_id AND (it_last.last_id = user2.user_id OR it_last.last_id IS NULL);

-- [PARTITION BY + ORDER_BY] Добавлен столбец, где максимальное количество проведенного времени игроком в игре
SELECT g.name, nickname, spend_time,
       first_value(spend_time) over (PARTITION BY g.game_id ORDER BY spend_time DESC) as max_spend_time
FROM project.statistics JOIN project.games g on g.game_id = statistics.game_id
    JOIN project.users u on u.user_id = statistics.user_id;






-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--              CREATE INDEX
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- Выбрал эти столбцы для быстрого поиска по nickname и name, 
-- так как это нам часто будет пригождаться
CREATE UNIQUE INDEX users_ind1 ON project.users(nickname);

CREATE UNIQUE INDEX game_ind1 ON project.games(name);






-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--             at least 6 views:
--  * 2-3 should be made with dynamic masking
--  * 3-4 should be sensible summary tables
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 1) Таблица с пользователями со скрытием данных об их счете
CREATE OR REPLACE VIEW users_without_cash AS
    SELECT user_id, nickname, level, '***' as cash, efct_at
    FROM project.users;

-- 2) Таблица со статистикой, но без информации о пользователе
CREATE OR REPLACE VIEW statistics_hidden AS
    SELECT '***' as user_id, game_id, buy_at, spend_time, achievements_count
    FROM project.statistics;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- 3) Полная информация о продаваемых предметах
CREATE OR REPLACE VIEW market_info AS
    SELECT i.item_id, i.name, i.user_id, i.game_id, i.item_type, m.price, m.publish_at
    FROM project.market m JOIN project.items i on i.item_id = m.item_id;

-- 4) Таблица владельцев предмета со временем ее передачи
CREATE OR REPLACE VIEW hist_items AS
    SELECT item_id, seller_id as user_id, buy_at
    FROM project.deals
    UNION
    SELECT item_id, user_id, '9999-12-31'
    FROM project.items;

-- 5) Таблица предметов с nickname-ами пользователей и названии игр
CREATE OR REPLACE VIEW items_plus AS
    SELECT i.item_id, u.nickname, g.name as game, i.name as item, i.item_type
    FROM project.items i JOIN project.users u on u.user_id = i.user_id
        JOIN project.games g on g.game_id = i.game_id;

-- 6) Таблица достижении с nickname-ами пользователей и названии игр
CREATE OR REPLACE VIEW achievements_plus AS
    SELECT u.nickname, g.name as game, ach.name, requirements
    FROM project.achievements ach JOIN project.users u on u.user_id = ach.user_id
        JOIN project.games g on g.game_id = ach.game_id;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~





-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--           TWO TRIGGERS
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- Добавление в users_hist при изменениях users
CREATE OR REPLACE FUNCTION add_to_users_hist() RETURNS TRIGGER AS
$$
    DECLARE
        curr_time timestamp := CURRENT_TIMESTAMP;
    BEGIN
        INSERT INTO project.users_hist (user_id, nickname, level, cash, efct_at, end_at)
        VALUES (old.user_id, old.nickname, old.level, old.cash, old.efct_at, curr_time);
        NEW.efct_at = curr_time;
        RETURN new;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_update_users
    BEFORE UPDATE ON project.users
    FOR EACH ROW
    EXECUTE PROCEDURE add_to_users_hist();

-- Добавление в users_hist перед удалением пользователя
CREATE OR REPLACE FUNCTION delete_user() RETURNS TRIGGER AS
$$
    DECLARE
        curr_time timestamp := CURRENT_TIMESTAMP;
    BEGIN
        INSERT INTO project.users_hist (user_id, nickname, level, cash, efct_at, end_at)
        SELECT user_id, nickname, level, cash, efct_at, curr_time FROM OLD;
        return new;
    END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_delete_user
    BEFORE DELETE ON project.users
    FOR EACH ROW
    EXECUTE PROCEDURE delete_user();






-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--         TWO PROCEDURES
-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-- Покупка игры
CREATE OR REPLACE PROCEDURE buy_game(user_id_ integer,
                                     game_id_ integer)
LANGUAGE plpgsql AS
$$
    DECLARE
        cur_time timestamp := CURRENT_TIMESTAMP;
        price_ integer := (SELECT price FROM project.games WHERE game_id = game_id_);
        cash_ integer := (SELECT cash FROM project.users WHERE user_id = user_id_);
    BEGIN
        IF price_ > cash_ THEN
            RAISE EXCEPTION 'Не хватает денег';
        END IF;

        IF game_id_ in (SELECT game_id FROM project.statistics WHERE user_id = user_id_) THEN
            RAISE EXCEPTION 'Игру нельзя купить два раза';
        END IF;

        UPDATE project.users SET cash = cash_ - price_ WHERE user_id = user_id_;

        INSERT INTO project.statistics (user_id, game_id, buy_at, spend_time, achievements_count)
        VALUES (user_id_, game_id_, cur_time, 0, 0);
    END;
$$;

-- Покупка предмета у игрока
CREATE OR REPLACE PROCEDURE deal(seller_  integer,
                                 buyer_   integer,
                                 item_id_ integer)
LANGUAGE plpgsql AS
$$
    DECLARE
        cur_time timestamp := CURRENT_TIMESTAMP;
        cash_ decimal := (SELECT cash FROM project.users WHERE user_id = buyer_);
        price_ decimal := (SELECT price FROM project.market WHERE item_id = item_id_);
    BEGIN
        IF item_id_ NOT IN (SELECT user_id FROM project.items WHERE item_id = item_id_) THEN
            RAISE EXCEPTION 'Этого предмета нет у пользователя';
        END IF;

        IF price_ IS NULL THEN
            RAISE EXCEPTION 'Этот предмет не продается';
        end if;

        UPDATE project.items SET user_id = buyer_ WHERE item_id = item_id_;


        UPDATE project.users SET cash = cash - price_ WHERE user_id = buyer_;


        UPDATE project.users SET cash = cash + price_ WHERE user_id = seller_;


        DELETE FROM project.market WHERE item_id = item_id_;
    END;
$$;
