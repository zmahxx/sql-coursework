/*╔══════════════════════════════════════════════════════════════════════╗
  ║                     UTSA — Lab 4 SQL Answers                         ║
  ║  Student: Zane Mullinax                                        ║
  ║  Course: Databases - 3743-001                                        ║             ║
  ╚══════════════════════════════════════════════════════════════════════╝*/

USE lab4_retail_store_db;

/* 〖Q1〗  */
SELECT customer_first_name, customer_last_name, customer_balance
FROM customers;

/* 〖Q2〗  */
SELECT *
FROM invoices
WHERE YEAR(invoice_date) = 2024;

/* 〖Q3〗 */
SELECT COUNT(*) AS total_products
FROM products;

/* 〖Q4〗  */
SELECT product_description, product_price
FROM products
ORDER BY product_price DESC
LIMIT 1;

/* 〖Q5〗  */
SELECT customer_code,
       customer_last_name,
       customer_first_name,
       customer_initial,
       customer_area_code,
       customer_phone,
       customer_email,
       customer_balance
FROM customers
WHERE customer_balance > 100
ORDER BY customer_code;

/* 〖Q6〗  */
SELECT COUNT(*) AS `customers with a balance over $100`
FROM customers
WHERE customer_balance > 100;

/* 〖Q7〗 */
SELECT DISTINCT vendor_state
FROM vendors;

/* 〖Q8〗 */
SELECT COUNT(*) AS total_invoices
FROM invoices;

/* 〖Q9〗  */
SELECT c.customer_code,
       i.invoice_number,
       i.invoice_date,
       p.product_description,
       li.line_units,
       li.line_price
FROM customers  AS c
JOIN invoices   AS i  ON c.customer_code = i.customer_code
JOIN line_items AS li ON i.invoice_number = li.invoice_number
JOIN products   AS p  ON li.product_code = p.product_code
ORDER BY c.customer_code, i.invoice_number, p.product_description;

/* 〖Q10〗  */
SELECT c.customer_code,
       i.invoice_number,
       p.product_description,
       li.line_units        AS `units bought`,
       li.line_price        AS `unit price`,
       (li.line_units * li.line_price) AS `sub total`
FROM customers  AS c
JOIN invoices   AS i  ON c.customer_code = i.customer_code
JOIN line_items AS li ON i.invoice_number = li.invoice_number
JOIN products   AS p  ON li.product_code = p.product_code
ORDER BY c.customer_code, i.invoice_number, p.product_description;

/* 〖Q11〗  */
SELECT c.customer_code,
       c.customer_balance,
       SUM(li.line_units * li.line_price) AS total_purchases
FROM customers  AS c
JOIN invoices   AS i  ON c.customer_code = i.customer_code
JOIN line_items AS li ON i.invoice_number = li.invoice_number
GROUP BY c.customer_code, c.customer_balance
ORDER BY c.customer_code;

/* 〖Q12〗  */
SELECT c.customer_code,
       c.customer_balance,
       SUM(li.line_units * li.line_price) AS total_purchases,
       COUNT(*)                            AS `number_of_purchases`
FROM customers  AS c
JOIN invoices   AS i  ON c.customer_code = i.customer_code
JOIN line_items AS li ON i.invoice_number = li.invoice_number
GROUP BY c.customer_code, c.customer_balance
ORDER BY c.customer_code;

/* 〖Q13〗 */
SELECT c.customer_code,
       c.customer_balance,
       SUM(li.line_units * li.line_price) AS total_purchases,
       COUNT(*)                            AS `number_of_purchases`,
       AVG(li.line_units * li.line_price)  AS `average_purchase_amount`
FROM customers  AS c
JOIN invoices   AS i  ON c.customer_code = i.customer_code
JOIN line_items AS li ON i.invoice_number = li.invoice_number
GROUP BY c.customer_code, c.customer_balance
ORDER BY c.customer_code;

/* 〖Q14〗  */
SELECT i.invoice_number,
       SUM(li.line_units * li.line_price) AS invoice_total
FROM invoices   AS i
JOIN line_items AS li ON i.invoice_number = li.invoice_number
GROUP BY i.invoice_number
ORDER BY i.invoice_number;

/* 〖Q15〗  */
SELECT c.customer_code,
       i.invoice_number,
       SUM(li.line_units * li.line_price) AS invoice_total
FROM customers  AS c
JOIN invoices   AS i  ON c.customer_code = i.customer_code
JOIN line_items AS li ON i.invoice_number = li.invoice_number
GROUP BY c.customer_code, i.invoice_number
ORDER BY c.customer_code, i.invoice_number;

/* 〖Q16〗  */
SELECT c.customer_code,
       COUNT(DISTINCT i.invoice_number)    AS `number_of_invoices`,
       SUM(li.line_units * li.line_price)  AS `total_purchases`
FROM customers  AS c
JOIN invoices   AS i  ON c.customer_code = i.customer_code
JOIN line_items AS li ON i.invoice_number = li.invoice_number
GROUP BY c.customer_code
ORDER BY c.customer_code;

/* 〖Q17〗*/
SELECT
  (SELECT COUNT(DISTINCT invoice_number) FROM invoices) AS total_invoices,
  (SELECT SUM(li.line_units * li.line_price)
     FROM invoices i
     JOIN line_items li ON i.invoice_number = li.invoice_number) AS total_sales,
  MIN(ct.customer_purchase) AS smallest_customer_purchase,
  MAX(ct.customer_purchase) AS largest_customer_purchase,
  AVG(ct.customer_purchase) AS average_customer_purchase
FROM (
  SELECT c.customer_code,
         SUM(li.line_units * li.line_price) AS customer_purchase
  FROM customers c
  JOIN invoices i  ON i.customer_code = c.customer_code
  JOIN line_items li ON li.invoice_number = i.invoice_number
  GROUP BY c.customer_code
) AS ct;



/* 〖Q18〗*/
SELECT DISTINCT c.customer_code, c.customer_balance
FROM customers c
JOIN invoices  i ON c.customer_code = i.customer_code
ORDER BY c.customer_code;

/* 〖Q19〗 */
SELECT 
    SUM(customer_balance) AS `Total Balance`,
    MIN(customer_balance) AS `Minimum Balance`,
    MAX(customer_balance) AS `Maximum Balance`,
    AVG(customer_balance) AS `Average Balance`
FROM customers;

/* 〖Q20〗 */
SELECT 
    MIN(customer_balance) AS `Minimum Balance`,
    MAX(customer_balance) AS `Maximum Balance`,
    AVG(customer_balance) AS `Average Balance`
FROM customers;

/* 〖Q21〗  */
SELECT
  SUM(c.customer_balance) AS `Total Balance`,
  MIN(c.customer_balance) AS `Minimum Balance`,
  MAX(c.customer_balance) AS `Maximum Balance`,
  AVG(c.customer_balance) AS `Average Balance`
FROM customers c
LEFT JOIN invoices i
  ON i.customer_code = c.customer_code
WHERE i.invoice_number IS NULL;

/* 〖Q22〗 */
SELECT c.customer_code, c.customer_balance
FROM customers c
LEFT JOIN invoices i ON c.customer_code = i.customer_code
WHERE i.invoice_number IS NULL
ORDER BY c.customer_code;

/* 〖Q23〗 */
SELECT product_description,
       product_qoh,
       product_price,
       (product_qoh * product_price) AS `sub total`
FROM products
ORDER BY `sub total` DESC;

/* 〖Q24〗*/
SELECT SUM(product_qoh * product_price) AS total_value_of_inventory
FROM products;
