CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE questions (
    question_uid UUID DEFAULT uuid_generate_v4 () NOT NULL PRIMARY KEY,
    question_name VARCHAR(100) NOT NUll,
    deck_uid UUID REFERENCES decks(deck_uid) NOT NULL,
    question_position SMALLINT NOT NULL CHECK (question_position > 0),
    UNIQUE(question_uid)
);

CREATE TABLE decks {
    deck_uid UUID DEFAULT uuid_generate_v4 () NOT NULL PRIMARY KEY,
    deck_name VARCHAR(100) NOT NULL,
    UNIQUE(deck_uid)
};

CREATE TABLE users {
    user_uid UUID DEFAULT uuid_generate_v4 () NOT NULL PRIMARY KEY,
    user_name VARCHAR(100) NOT NULL,
    UNIQUE(user_uid),
    UNIQUE(user_name)
};

CREATE TABLE progress {
    question_uid UUID REFERENCES questions(question_uid) NOT NULL,
    deck_uid UUID REFERENCES decks(deck_uid) NOT NULL,
    user_uid UUID REFERENCES users(user_uid) NOT NULL,
    next_due TIMESTAMP NOT NULL,
    first_attempt TIMESTAMP NOT NULL,
    interval_ms INTEGER NOT NULL CHECK (current_interval_ms >= 0),
    multiplier NUMERIC(3, 2) NOT NULL
};

CREATE TABLE settings {
    deck_uid UUID REFERENCES decks(deck_uid) NOT NULL,
    user_uid UUID REFERENCES users(user_uid) NOT NULL,
    new_cards SMALLINT NOT NULL CHECK (new_cards >= 0),
    currect_multiplier NUMERIC(3, 2),
    incorrect_multiplier NUMERIC(3, 2)
}

DO $$

DECLARE today_date DATE;
DECLARE temp_user_uid UUID;
DECLARE temp_deck_uid UUID;

BEGIN

    INSERT INTO users (user_name) VALUES ('test user') RETURNING user_uid INTO temp_user_uid;
    INSERT INTO decks (deck_name) VALUES ('test deck') RETURNING deck_uid INTO temp_deck_uid;

    today_date := NOW();




END $$;