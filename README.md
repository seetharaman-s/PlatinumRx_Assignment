# PlatinumRx Data Analyst Assignment

## Folder Structure

```
PlatinumRx_Assignment/
├── SQL/
│   ├── 01_Hotel_Schema_Setup.sql
│   ├── 02_Hotel_Queries.sql
│   ├── 03_Clinic_Schema_Setup.sql
│   └── 04_Clinic_Queries.sql
├── Spreadsheets/
│   └── Ticket_Analysis.xlsx
├── Python/
│   ├── 01_Time_Converter.py
│   └── 02_Remove_Duplicates.py
└── README.md
```

## Phase 1 – SQL

### Hotel System

- **Q1** – Last booked room per user using `MAX(booking_date)`
- **Q2** – Total billing in Nov 2021 using `SUM(item_quantity * item_rate)`
- **Q3** – Bills greater than 1000 in Oct 2021 using `HAVING`
- **Q4** – Most and least ordered item per month using `RANK()`
- **Q5** – Second highest bill per month using `DENSE_RANK()`

### Clinic System

- **Q1** – Revenue by sales channel using `GROUP BY sales_channel`
- **Q2** – Top 10 customers by total spend using `ORDER BY DESC LIMIT 10`
- **Q3** – Month-wise revenue, expense, profit and status using two CTEs
- **Q4** – Most profitable clinic per city using `RANK() OVER (PARTITION BY city)`
- **Q5** – Second least profitable clinic per state using `DENSE_RANK()`

## Phase 2 – Spreadsheets

- **Q1** – `ticket_created_at` populated using `INDEX-MATCH` on `cms_id`
- **Q2a** – Same Day tickets counted using `INT()` to strip time from datetime
- **Q2b** – Same Hour tickets counted using `HOUR()` with `COUNTIFS` per outlet

## Phase 3 – Python

- **01_Time_Converter.py** – Takes user input in minutes, converts to hrs and minutes using `//` and `%`
- **02_Remove_Duplicates.py** – Takes user input string, removes duplicate characters using a `for` loop

## Tools Used

- MySQL Workbench
- Microsoft Excel
- Python 3.12.7
