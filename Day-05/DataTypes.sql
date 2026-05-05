                          -- SQL DATA TYPES ARCHITECTURE REFERENCE
                          ----------------------------------------

--===============================
-- SECTION 01: NUMERIC DATA TYPES
--===============================
---- 1.1: INTEGER (Whole Numbers)
---------------------------------
-- TINYINT   : 1 byte  | Range: -128 to 127
-- SMALLINT  : 2 bytes | Range: -32,768 to 32,767
-- INT       : 4 bytes | Range: ~2 Billion (Standard for IDs)
-- BIGINT    : 8 bytes | Range: For massive datasets/global IDs

---- 1.2: Fixed-Point (High Precision)
--------------------------------------
-- DECIMAL(p, s) / NUMERIC(p, s)
-- p : precision (total digits), s : scale (digits after decimal)
-- USE CASE: Financial data, currency, and accounting
-- Example: DECIMAL(10, 2) can store values up to 99999999.99

---- 1.3: Floating-Point (Approximate Values)
---------------------------------------------
-- FLOAT       : 4 bytes | Approximate, less precision
-- DOUBLE      : 8 bytes | More precision than FLOAT
-- REAL        : 4 bytes | Similar to FLOAT, but implementation-specific
-- USE CASE: Scientific calculations, measurements, and when precision is not critical


--===============================
-- SECTION 02: STRING & CHARACTER
--===============================
---- 2.1: Fixed-Length Strings
------------------------------
-- CHAR(n) : n is the length (1 to 255)
-- USE CASE: Codes, abbreviations, and when data length is consistent
-- Example: CHAR(10) will always store 10 characters, padding with spaces if needed

---- 2.2: Variable-Length Strings
---------------------------------
-- VARCHAR(n) : n is the maximum length (1 to 255)
-- USE CASE: Text data with varying lengths
-- Example: VARCHAR(100) can store up to 100 characters

---- 2.3: Text (Large Variable-Length)
--------------------------------------
-- TEXT / CLOB : For large text data (up to 2GB)
-- USE CASE: Articles, descriptions, and any large text content


--===============================
-- SECTION 03: DATE & TIME
--===============================
-- DATE      : YYYY-MM-DD (e.g., '2026-05-05')
-- TIME      : HH:MM:SS   (e.g., '14:30:00')
-- DATETIME  : Combined Date & Time.
-- TIMESTAMP : Tracks timezone-aware moments (Essential for 'Created_At' logs).


--===============================
-- SECTION 04: SPECIALIZED TYPES
--===============================
-- BOOLEAN   : True/False (Stored as 1/0 or BIT).
-- BLOB      : Binary Large Object (Images, PDFs, Compiled Files).
-- JSON      : (Modern DBs) Stores structured JSON for NoSQL capabilities.


--==================================================
-- SECTION 05: PERFORMANCE & OPTIMIZATION GUIDELINES
--===================================================
/*
    1. PRECISION RULE:
       Always use DECIMAL for money. Never use FLOAT for financial balances.

    2. STORAGE RULE:
       Choose the smallest integer type that fits your data to save RAM/Disk.
       (e.g., Use TINYINT for Age, not BIGINT).

    3. INDEXING RULE:
       Primary Keys should ideally be Integers (INT/BIGINT) for maximum
       join performance and indexing speed.

    4. CHARACTER SETS:
       Use VARCHAR with UTF-8 encoding if you need to support multi-language
       characters (like Arabic or Emojis).
*/
