-- CROSS JOIN
	SELECT S.St_Fname, D.Dept_Name
	FROM Student S, Department D   -- 98 ROW

-- EQUI INNER JOIN
	SELECT S.St_Fname, D.*
	FROM Student S, Department D   -- 13 ROW
		WHERE S.Dept_Id = D.Dept_Id


	SELECT S.St_Fname, D.Dept_Name
	FROM Student S INNER JOIN Department D   -- 13 ROW
		ON S.Dept_Id = D.Dept_Id


-- OUTER JOIN
	SELECT S.St_Fname, D.Dept_Name
		--LEFT
	FROM Student S		--RIGHT
		LEFT JOIN Department D
		ON S.Dept_Id = D.Dept_Id;


	SELECT S.St_Fname, D.Dept_Name
		--LEFT
	FROM Student S		--RIGHT
		RIGHT JOIN Department D
		ON S.Dept_Id = D.Dept_Id;


	SELECT S.St_Fname, D.Dept_Name
		--LEFT
	FROM Student S		--RIGHT
		FULL OUTER JOIN Department D
		ON S.Dept_Id = D.Dept_Id;


--SELF JOIN
	SELECT 
		S1.St_Fname + ' ' + S1.St_Lname AS Full_Name,
		S2.St_Fname + ' ' + S2.St_Lname AS Leader_Full_Name
	FROM Student S1
		JOIN Student S2 
		ON S1.St_super = S2.St_Id;





-- JOIN WITH DML
	UPDATE SC
		SET SC.Grade += 10	
	FROM Student S JOIN Stud_Course SC
		ON S.St_Id = SC.St_Id 
			AND S.St_Address LIKE 'cairo';



SELECT ISNULL(S.St_Fname, 'NO NAME')
FROM Student S;

SELECT COALESCE(S.St_Fname, S.St_Lname)
FROM Student S


