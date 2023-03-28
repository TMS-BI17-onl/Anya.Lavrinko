1
SELECT e2.First_Name, e2.Last_Name, COUNT (e1.Manager_ID) AS Cnt
FROM Employees e1 JOIN Employees e2 ON e1.Manager_ID=e2.Employee_ID
GROUP BY e2.First_Name, e2.Last_Name
HAVING COUNT (e1.Manager_ID)>6

2
SELECT Department_Name, MAX(Salary*(1-Comission_Pct/100)) AS MaxSalary,
MIN (Salary*(1-Comission_Pct/100)) AS MinSalary
FROM Employees e JOIN Departments d ON e.Department_ID=d.Department_ID
GROUP BY Department_Name

3
SELECT TOP 1 WITH TIES Region_Name
FROM
 (SELECT Region_Name, COUNT (Employee_ID) AS Cnt
  FROM Employees e JOIN Departments d ON e.Department_ID=d.Department_ID 
  JOIN Locations l ON d.Location_ID=l.Location_ID
  JOIN Countries c ON l.Country_ID=c.Country_ID JOIN Regions r ON c.Region_ID=r.Region_ID
  GROUP BY Region_Name
) t
ORDER BY Cnt DESC

4
SELECT DISTINCT Department_Name, (AvgSalary/AvgSalarybyDepartment-1)*100 AS AvgDifference
FROM
 (SELECT Department_Name, AVG (Salary) OVER () AS AvgSalary, 
         AVG (Salary) OVER (PARTITION BY Department_Name)AS AvgSalarybyDepartment
  FROM Employees e JOIN Departments d ON e.Department_ID=d.Department_ID 
) t

5
SELECT First_Name, Last_Name, Department_Name, DATEDIFF (YEAR, End_Date, Start_Date) AS YearsNumber
FROM Employees e JOIN Job_History j ON e.Employee_ID=j.Employee_ID
JOIN Departments d ON j.Department_ID=d.Department_ID 
WHERE DATEDIFF (YEAR, End_Date, Start_Date)>10

6
SELECT First_Name, Last_Name, Salary_Rank
FROM
  (SELECT First_Name, Last_Name, RANK () OVER (ORDER BY Salary DESC) AS Salary_Rank
   FROM Employees
   ) t
WHERE Salary_Rank BETWEEN 5 AND 10