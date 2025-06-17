START TRANSACTION;
DELIMITER //
update employees set dept_id = 3 where dept_id in
           (select dept_id from departments where dept_id = 1) ;
SAVEPOINT after_dept_insert;
UPDATE employees SET salary = salary + salary + 10/100 WHERE dept_id = 3;
UPDATE employees SET dept_id = 0 where dept_id is null ;
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION 
    BEGIN 
		GET DIAGNOSTICS CONDITION 1 @p1 = RETURNED_SQLSTATE, @p2 = MESSAGE_TEXT;
        SELECT CONCAT(@p1, ':', @p2);
    END ;
END 
ROLLBACK TO SAVEPOINT after_dept_insert;
INSERT INTO employees (first_name, last_name, gender, hire_date, dept_id, salary) 
			   VALUES ('Tom','Victor', 'M', now(), 1, 61000);
COMMIT;  
 //

 -- select * from employees //
 -- select * from departments //