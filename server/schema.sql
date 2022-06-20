CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE questions (
    question_uid UUID DEFAULT uuid_generate_v4 () NOT NULL PRIMARY KEY
);