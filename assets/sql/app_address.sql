Create Table app_address
(
    id        INTEGER PRIMARY KEY AUTOINCREMENT,
    userId    INTEGER,
    street1   TEXT,
    street2   TEXT,
    mp_vdc    TEXT,
    district  TEXT,
    zone      TEXT,
    state     TEXT,
    createdAt REAL,
    createdBy INTEGER,
    updatedBy INTEGER,
    updatedAt REAL
);

