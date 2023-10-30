SELECT o.customerNumber
FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    JOIN products p ON od.productCode = p.productCode
    JOIN productlines pl ON p.productLine = pl.productLine
WHERE
    pl.productLine = 'Classic Cars'
GROUP BY o.customerNumber
HAVING
    COUNT(DISTINCT p.productCode) > 23;