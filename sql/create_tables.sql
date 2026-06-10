-- ==========================================
-- SALES FORECASTING DATABASE SCHEMA
-- ==========================================

DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS sales;
DROP TABLE IF EXISTS holidays_events;
DROP TABLE IF EXISTS stores;

-- ==========================================
-- STORES DIMENSION
-- ==========================================

CREATE TABLE stores (
    store_nbr INTEGER PRIMARY KEY,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(100) NOT NULL,
    type VARCHAR(10) NOT NULL,
    cluster INTEGER NOT NULL
);

-- ==========================================
-- HOLIDAYS DIMENSION
-- ==========================================

CREATE TABLE holidays_events (
    holiday_id SERIAL PRIMARY KEY,
    date DATE NOT NULL,
    type VARCHAR(50) NOT NULL,
    locale VARCHAR(50) NOT NULL,
    locale_name VARCHAR(100) NOT NULL,
    description VARCHAR(255) NOT NULL,
    transferred BOOLEAN NOT NULL
);

-- ==========================================
-- SALES FACT TABLE
-- ==========================================

CREATE TABLE sales (
    date DATE NOT NULL,
    store_nbr INTEGER NOT NULL,
    family VARCHAR(100) NOT NULL,
    sales NUMERIC(12,2) NOT NULL,
    onpromotion INTEGER NOT NULL,

    CONSTRAINT pk_sales
        PRIMARY KEY (date, store_nbr, family),

    CONSTRAINT fk_sales_store
        FOREIGN KEY (store_nbr)
        REFERENCES stores(store_nbr)
);

-- ==========================================
-- TRANSACTIONS FACT TABLE
-- ==========================================

CREATE TABLE transactions (
    date DATE NOT NULL,
    store_nbr INTEGER NOT NULL,
    transactions INTEGER NOT NULL,

    CONSTRAINT pk_transactions
        PRIMARY KEY (date, store_nbr),

    CONSTRAINT fk_transactions_store
        FOREIGN KEY (store_nbr)
        REFERENCES stores(store_nbr)
);

-- ==========================================
-- PERFORMANCE INDEXES
-- ==========================================

CREATE INDEX idx_sales_date
ON sales(date);

CREATE INDEX idx_sales_family
ON sales(family);

CREATE INDEX idx_sales_store
ON sales(store_nbr);

CREATE INDEX idx_transactions_date
ON transactions(date);

CREATE INDEX idx_holidays_date
ON holidays_events(date);