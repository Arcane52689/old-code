CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  FOREIGN KEY (question_id) REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  reply_id INTEGER,
  body TEXT NOT NULL,
  FOREIGN KEY(question_id) REFERENCES questions(id),
  FOREIGN KEY(reply_id) REFERENCES replies(id),
  FOREIGN KEY(user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
  user_id INTEGER NOT NULL,
  question_id INTEGER NOT NULL,
  FOREIGN KEY(user_id) REFERENCES users(id),
  FOREIGN KEY(question_id) REFERENCES questions(id)
);

INSERT INTO
  users(fname, lname)
VALUES
  ('Dylan', 'Nelson'), ('Thomas','Jenkins');

INSERT INTO
  questions(title, body, user_id)
VALUES
  ('JOINS', 'WTF?', (SELECT id FROM users WHERE lname = 'Nelson')),
  ('QUESTIONS', 'WTF?', (SELECT id FROM users WHERE lname = 'Jenkins'));


INSERT INTO
  replies(user_id, question_id, body, reply_id)
VALUES
  (1,1,'WTF?', NULL),
  (1,1,'WTF?', 1);

INSERT INTO
  question_follows (question_id, user_id)
VALUES
  (1,1),
  (2,1),
  (1,2);


INSERT INTO
  question_likes (question_id, user_id)
VALUES
  (1,1),
  (2,2);
