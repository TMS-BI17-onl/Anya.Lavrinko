--Написать запрос на выборку всех пользователей с телефонами, начинающимися на 3 и заканчивающимися на 4,
--либо с возрастом > 35.
SELECT u.id, 
       u.name 
FROM user u
LEFT JOIN phone p
ON u.id = p.user_id
WHERE p.name LIKE '3%4'
OR u.age >35

SELECT u.id, 
       u.name 
FROM user u
LEFT JOIN phone p
ON u.id = p.user_id
WHERE LEFT(phone,2)=3 AND RIGHT(phone,1)=4
OR u.age >35