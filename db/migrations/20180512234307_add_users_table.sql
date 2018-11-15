-- +micrate Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE users(
  id SERIAL PRIMARY KEY,
  email VARCHAR NOT NULL,
  created_at TIMESTAMP NOT NULL,
  updated_at TIMESTAMP NOT NULL
);


-- +micrate Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE users;
