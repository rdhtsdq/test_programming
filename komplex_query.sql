USE classicmodels;

/* no 1  */

SELECT o.customerNumber
FROM orders o
    JOIN orderdetails od ON o.orderNumber = od.orderNumber
    JOIN products p ON od.productCode = p.productCode
    JOIN productlines pl ON p.productLine = pl.productLine
WHERE
    pl.productLine = 'Classic Cars'
GROUP BY o.customerNumber
HAVING
    COUNT(DISTINCT p.productCode) > 13;

/* no 2 */

DELIMITER //

CREATE FUNCTION FINDMINDATE(INPUT TEXT) RETURNS DATE 
BEGIN DECLARE 
	DECLARE DECLARE minDate DATE;
	DECLARE minDateFound BOOLEAN DEFAULT FALSE;
	DECLARE currentToken TEXT;
	DECLARE currentDate DATE;
	SET input = TRIM(BOTH ',' FROM input);
	WHILE LENGTH(input) > 0
	DO
	SET
	    currentToken = TRIM(SUBSTRING_INDEX(input, ',', 1));
	SET input = TRIM(
	        BOTH ','
	        FROM
	            SUBSTRING(input, LENGTH(currentToken) + 2)
	    );
	SET currentDate = STR_TO_DATE(currentToken, '%Y-%m-%d');
	IF currentDate IS NOT NULL THEN IF minDateFound = FALSE
	OR currentDate < minDate THEN
	SET minDate = currentDate;
	SET minDateFound = TRUE;
	END IF;
	END IF;
	END WHILE;
	RETURN minDate;
	END // 


DELIMITER ;

/* no 3 */

DELIMITER $$

CREATE PROCEDURE EXTRACTKURSPAJAK() BEGIN DECLARE 
	DECLARE EXIT HANDLER FOR SQLEXCEPTION BEGIN ROLLBACK;
	RESIGNAL;
	END;
	START TRANSACTION;
	IF EXISTS (SELECT * FROM kurs_pajak) THEN ROLLBACK;
	SIGNAL SQLSTATE '45000'
	SET
	    MESSAGE_TEXT = 'Table kurs_pajak already contains data. Transaction rolled back.';
	ELSE
	INSERT INTO
	    kurs_pajak (
	        id_ksm_kurs_pajak,
	        kurs_rate,
	        tgl,
	        curr_id
	    )
	SELECT
	    id,
	    kurs_rate,
	    end_date,
	    curr_id
	FROM ksm_kurs_pajak;
	COMMIT;
	END IF;
	END $$ 


DELIMITER ;