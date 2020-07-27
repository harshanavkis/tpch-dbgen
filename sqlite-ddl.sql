PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE NATION (  N_NATIONKEY INTEGER PRIMARY KEY NOT NULL,  N_NAME      TEXT NOT NULL,  N_REGIONKEY INTEGER NOT NULL,  N_COMMENT   TEXT,  FOREIGN KEY (N_REGIONKEY) REFERENCES REGION(R_REGIONKEY));
CREATE TABLE REGION (  R_REGIONKEY INTEGER PRIMARY KEY NOT NULL,  R_NAME      TEXT NOT NULL,  R_COMMENT   TEXT);
CREATE TABLE PART (  P_PARTKEY     INTEGER PRIMARY KEY NOT NULL,  P_NAME        TEXT NOT NULL,  P_MFGR        TEXT NOT NULL,  P_BRAND       TEXT NOT NULL,  P_TYPE        TEXT NOT NULL,  P_SIZE        INTEGER NOT NULL,  P_CONTAINER   TEXT NOT NULL,  P_RETAILPRICE INTEGER NOT NULL,  P_COMMENT     TEXT NOT NULL);
CREATE TABLE SUPPLIER (  S_SUPPKEY   INTEGER PRIMARY KEY NOT NULL,  S_NAME      TEXT NOT NULL,  S_ADDRESS   TEXT NOT NULL,  S_NATIONKEY INTEGER NOT NULL,  S_PHONE     TEXT NOT NULL,  S_ACCTBAL   INTEGER NOT NULL,  S_COMMENT   TEXT NOT NULL,  FOREIGN KEY (S_NATIONKEY) REFERENCES NATION(N_NATIONKEY));
CREATE TABLE PARTSUPP (  PS_PARTKEY    INTEGER NOT NULL,  PS_SUPPKEY    INTEGER NOT NULL,  PS_AVAILQTY   INTEGER NOT NULL,  PS_SUPPLYCOST INTEGER NOT NULL,  PS_COMMENT    TEXT NOT NULL,  PRIMARY KEY (PS_PARTKEY, PS_SUPPKEY),  FOREIGN KEY (PS_SUPPKEY) REFERENCES SUPPLIER(S_SUPPKEY),  FOREIGN KEY (PS_PARTKEY) REFERENCES PART(P_PARTKEY));
CREATE TABLE CUSTOMER (  C_CUSTKEY    INTEGER PRIMARY KEY NOT NULL,  C_NAME       TEXT NOT NULL,  C_ADDRESS    TEXT NOT NULL,  C_NATIONKEY  INTEGER NOT NULL,  C_PHONE      TEXT NOT NULL,  C_ACCTBAL    INTEGER   NOT NULL,  C_MKTSEGMENT TEXT NOT NULL,  C_COMMENT    TEXT NOT NULL,  FOREIGN KEY (C_NATIONKEY) REFERENCES NATION(N_NATIONKEY));
CREATE TABLE ORDERS (  O_ORDERKEY      INTEGER PRIMARY KEY NOT NULL,  O_CUSTKEY       INTEGER NOT NULL,  O_ORDERSTATUS   TEXT NOT NULL,  O_TOTALPRICE    INTEGER NOT NULL,  O_ORDERDATE     DATE NOT NULL,  O_ORDERPRIORITY TEXT NOT NULL,  O_CLERK         TEXT NOT NULL,  O_SHIPPRIORITY  INTEGER NOT NULL,  O_COMMENT       TEXT NOT NULL,  FOREIGN KEY (O_CUSTKEY) REFERENCES CUSTOMER(C_CUSTKEY));
CREATE TABLE LINEITEM (  L_ORDERKEY      INTEGER NOT NULL,  L_PARTKEY       INTEGER NOT NULL,  L_SUPPKEY       INTEGER NOT NULL,  L_LINENUMBER    INTEGER NOT NULL,  L_QUANTITY      INTEGER NOT NULL,  L_EXTENDEDPRICE INTEGER NOT NULL,  L_DISCOUNT      INTEGER NOT NULL,  L_TAX           INTEGER NOT NULL,  L_RETURNFLAG    TEXT NOT NULL,  L_LINESTATUS    TEXT NOT NULL,  L_SHIPDATE      DATE NOT NULL,  L_COMMITDATE    DATE NOT NULL,  L_RECEIPTDATE   DATE NOT NULL,  L_SHIPINSTRUCT  TEXT NOT NULL,  L_SHIPMODE      TEXT NOT NULL,  L_COMMENT       TEXT NOT NULL,  PRIMARY KEY (L_ORDERKEY, L_LINENUMBER),  FOREIGN KEY (L_ORDERKEY) REFERENCES ORDERS(O_ORDERKEY),  FOREIGN KEY (L_PARTKEY, L_SUPPKEY) REFERENCES PARTSUPP(PS_PARTKEY, PS_SUPPKEY));
