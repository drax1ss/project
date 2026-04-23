CREATE SCHEMA todoapp;

CREATE TABLE todoapp.users(
    id              SERIAL               PRIMARY KEY,
    version         BIGINT               NOT NULL DEFAULT 1,
    full_name       VARCHAR(50)          NOT NULL CHECK(char_lenght(full_name) BETWEEN 3 AND 50 ),
    phone_number    VARCHAR(15)          CHECK(
        phone_number ~ '^\+[0-9]+$'  
        AND (char_lenght(phone_number) BETWEEN 10 AND 15)
        )
);  

CREATE TABLE todoapp.tasks (
    id           SERIAL         PRIMARY KEY,
    version      BIGINT         NOT NULL DEFAULT 1,
    title        VARCHAR(100)   NOT NULL CHECK(char_lenght(title) BETWEEN 1 AND 100 ),
    completed    BOOLEAN        NOT NULL,
    completed_at TIMESTAMPTZ    CHECK, 
    started_at   TIMESTAMPTZ    NOt NULL,
    description  VARCHAR(1000)  CHECK(char_lenght(description) BETWEEN 1 AND 1000 )

    CHECK(
        (completed=false AND completed_at IS NULL)
        OR
        (completed=true AND completed_at IS NOT NULL AND completed_at >= started_at)
    ).

    author_user_id INTEGER NOT NULL REFERENCES todoapp.users(id)
)
