Create Table app_users
(
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    username  TEXT,
    password  TEXT,
    name      TEXT,
    phone     TEXT,
    email     TEXT,
    roles     TEXT,
    address   INTEGER,
    createdAt REAL,
    createdBy INTEGER,
    updatedBy INTEGER,
    updatedAt REAL
);

