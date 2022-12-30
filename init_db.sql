﻿CREATE TABLE "Currencies" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "Name" text NOT NULL,
    CONSTRAINT "PK_Currencies" PRIMARY KEY ("Id")
);


CREATE TABLE "Customers" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "IdentityUserId" text NOT NULL,
    "Name" text NOT NULL,
    "DateOfBirth" timestamp without time zone NOT NULL,
    CONSTRAINT "PK_Customers" PRIMARY KEY ("Id")
);


CREATE TABLE "Exchanges" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "Name" text NULL,
    "RegistrationDate" timestamp without time zone NOT NULL,
    CONSTRAINT "PK_Exchanges" PRIMARY KEY ("Id")
);


CREATE TABLE "Pairs" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "FirstCryptoId" integer NOT NULL,
    "SecondCryptoId" integer NOT NULL,
    CONSTRAINT "PK_Pairs" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Pairs_Currencies_FirstCryptoId" FOREIGN KEY ("FirstCryptoId") REFERENCES "Currencies" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_Pairs_Currencies_SecondCryptoId" FOREIGN KEY ("SecondCryptoId") REFERENCES "Currencies" ("Id") ON DELETE CASCADE
);


CREATE TABLE "ExchangePairs" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "ExchangeId" integer NOT NULL,
    "PairId" integer NOT NULL,
    "Price" numeric NOT NULL,
    CONSTRAINT "PK_ExchangePairs" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_ExchangePairs_Exchanges_ExchangeId" FOREIGN KEY ("ExchangeId") REFERENCES "Exchanges" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_ExchangePairs_Pairs_PairId" FOREIGN KEY ("PairId") REFERENCES "Pairs" ("Id") ON DELETE CASCADE
);


CREATE TABLE "Orders" (
    "Id" integer GENERATED BY DEFAULT AS IDENTITY,
    "Date" timestamp without time zone NOT NULL,
    "Volume" numeric NOT NULL,
    "ExchangePairId" integer NOT NULL,
    "CustomerId" integer NOT NULL,
    CONSTRAINT "PK_Orders" PRIMARY KEY ("Id"),
    CONSTRAINT "FK_Orders_Customers_CustomerId" FOREIGN KEY ("CustomerId") REFERENCES "Customers" ("Id") ON DELETE CASCADE,
    CONSTRAINT "FK_Orders_ExchangePairs_ExchangePairId" FOREIGN KEY ("ExchangePairId") REFERENCES "ExchangePairs" ("Id") ON DELETE CASCADE
);


CREATE UNIQUE INDEX "IX_Currencies_Name" ON "Currencies" ("Name");


CREATE UNIQUE INDEX "IX_Customers_IdentityUserId" ON "Customers" ("IdentityUserId");


CREATE INDEX "IX_ExchangePairs_ExchangeId" ON "ExchangePairs" ("ExchangeId");


CREATE INDEX "IX_ExchangePairs_PairId" ON "ExchangePairs" ("PairId");


CREATE INDEX "IX_Orders_CustomerId" ON "Orders" ("CustomerId");


CREATE INDEX "IX_Orders_ExchangePairId" ON "Orders" ("ExchangePairId");


CREATE UNIQUE INDEX "IX_Pairs_FirstCryptoId_SecondCryptoId" ON "Pairs" ("FirstCryptoId", "SecondCryptoId");


CREATE INDEX "IX_Pairs_SecondCryptoId" ON "Pairs" ("SecondCryptoId");

