CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users {
    user_uid UUID DEFAULT uuid_generate_v4 () NOT NULL PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    UNIQUE(user_uid),
    UNIQUE(user_name)
};

CREATE TABLE decks {
    deck_uid UUID DEFAULT uuid_generate_v4 () NOT NULL PRIMARY KEY,
    deck_name VARCHAR(100) NOT NULL,
    UNIQUE(deck_uid)
};

CREATE TABLE settings {
    deck_uid UUID REFERENCES decks(deck_uid) NOT NULL,
    user_uid UUID REFERENCES users(user_uid) NOT NULL,
    new_cards SMALLINT NOT NULL CHECK (new_cards >= 0),
    current_multiplier NUMERIC(3, 2),
    incorrect_multiplier NUMERIC(3, 2)
}

CREATE TABLE questions (
    question_uid UUID DEFAULT uuid_generate_v4 () NOT NULL PRIMARY KEY,
    question_name VARCHAR(100) NOT NUll,
    deck_uid UUID REFERENCES decks(deck_uid) NOT NULL,
    time_limit INTEGER CHECK (time_limit >= 0)
    question_position SMALLINT NOT NULL CHECK (question_position > 0),
    UNIQUE(question_uid)
);

CREATE TABLE progress {
    question_uid UUID REFERENCES questions(question_uid) NOT NULL,
    deck_uid UUID REFERENCES decks(deck_uid) NOT NULL,
    user_uid UUID REFERENCES users(user_uid) NOT NULL,
    next_due DATE NOT NULL,
    first_attempt DATE NOT NULL,
    interval_days INTEGER NOT NULL CHECK (interval_days >= 0),
    multiplier NUMERIC(3, 2) NOT NULL,
    time_used INTEGER CHECK (time_used >= 0)
};

DO $$

DECLARE today_date DATE;
DECLARE temp_user_uid UUID;
DECLARE temp_deck_uid UUID;
DECLARE temp_question_uid UUID;

BEGIN
    today_date := NOW();
    INSERT INTO users (user_name) VALUES ('test user') RETURNING user_uid INTO temp_user_uid;
    INSERT INTO decks (deck_name) VALUES ('test deck') RETURNING deck_uid INTO temp_deck_uid;
    INSERT INTO settings (deck_uid, user_uid, new_cards, current_multiplier, incorrect_multiplier) VALUES (temp_deck_uid, temp_user_uid, 3, 1.50, 0.75);

    INSERT INTO questions (question_name, deck_uid, time_limit, question_position) VALUES ('test 1', temp_deck_uid, 15, 1) RETURNING question_uid INTO temp_question_uid;
    INSERT INTO progress (question_uid, deck_uid, user_uid, next_due, first_attempt, interval_ms, multiplier, time_used) VALUES (temp_question_uid, temp_deck_uid, temp_user_uid, today_date, today_date, 1, 1.50, 10);

    INSERT INTO questions (question_name, deck_uid, time_limit, question_position) VALUES ('test 2', temp_deck_uid, 15, 1) RETURNING question_uid INTO temp_question_uid;
    INSERT INTO progress (question_uid, deck_uid, user_uid, next_due, first_attempt, interval_ms, multiplier, time_used) VALUES (temp_question_uid, temp_deck_uid, temp_user_uid, today_date, today_date, 1, 1.50, 10);

    INSERT INTO questions (question_name, deck_uid, time_limit, question_position) VALUES ('test 3', temp_deck_uid, 15, 1) RETURNING question_uid INTO temp_question_uid;
    INSERT INTO progress (question_uid, deck_uid, user_uid, next_due, first_attempt, interval_ms, multiplier, time_used) VALUES (temp_question_uid, temp_deck_uid, temp_user_uid, today_date, today_date, 1, 1.50, 10);

END $$;