--Написать запрос на выборку всех пользователей с телефонами, начинающимися на 3 и заканчивающимися на 4,
--либо с возрастом > 35.
SELECT u.id, 
       u.name 
FROM user u
LEFT JOIN phone p
ON u.id = p.user_id
WHERE p.name LIKE '3%4'
OR u.age >35

--Найти топ 5 пользователей, кто купил больше всего продуктов.

SELECT TOP(5) p.count, u.name,   
       RANK() OVER (ORDER BY p.count DESC) AS Rank
FROM user u
JOIN order o
  ON u.id = o.user_id
JOIN product p
  ON o.product_id = p.id


SELECT TOP 5 WITH TIES price, name
FROM user u
JOIN order o
  ON u.id = o.user_id
JOIN product p
  ON o.product_id = p.id
ORDER BY price DESC
 
 --	Найти название продукта с максимальной ценой.

 SELECT name, price
 FROM Product
 WHERE price =(SELECT max(price)
               FROM Product)

SELECT TOP 1 WITH TIES price, name
FROM Product
ORDER BY price DESC

SELECT Name, price
FROM
(
  SELECT Name, price, RANK() OVER (ORDER BY price DESC) as rnk
  FROM Product
) temp
WHERE rnk=1


SELECT Name, price
FROM
(
SELECT Name, price, MAX(price) OVER ()  as max_price
FROM Product
) temp
WHERE price=max_price



--Написать запрос на добавление в таблицу manufacturer нового производителя HP из Америки.
INSERT INTO manufacturer (id,name,country_id)
VALUES (5,'HP',4)--no need to indicate 5 and id, if id =new id, it's atomatically



--Написать запрос, благодаря которому возраст пользователя Андрей в таблице user уменьшится в 3 раза.

UPDATE user
SET age = age/3
WHERE name = 'Андрей'