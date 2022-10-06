SELECT Cs.CustomerID, Cs.CustomerName, Cs.Country, count(Od.OrderID) as "TotalOrder",

/* Creating the remaining two columns bearing totalorders (a calculated 
attribute from unit price and quantity) by the year purchase */

 (
        CASE
            WHEN Os.OrderDate LIKE '%1996%'
                THEN SUM(Pr.Price*Od.Quantity)
            ELSE '0'
            END
        ) AS Year_1996_Spend,
 (
        CASE
            WHEN Os.OrderDate LIKE '%1997%'
                THEN SUM(Pr.Price*Od.Quantity)
            ELSE '0'
            END
        ) AS Year_1997_Spend
        
/* This tables were selected because attributes (columns) from each of them were used 
in the SELECT statement ; the tables were also aliased for easy repeat reference */
 
FROM Customers Cs, Orders Os, OrderDetails Od, Products Pr

/* The several tables utilized in the SELECT statements through their attributes
 are joined/linked together using common attributes to connect each of the tables */
 
 /* Assumption: Official EU countries, excluding UK and Nordic countries 
 where used to filter customers by country */
 
Where Cs.CustomerID = Os.CustomerID and Os.OrderID = Od.OrderID and Od.ProductID = Pr.ProductID and 
Cs.Country IN ("Austria", "Germany", "Ireland", "France", "Belgium", "Switzerland", "Italy", "Portugal", "Spain")

/* The folding up of the dataset and the use of aggregate operators like 
COUNT and SUM is enabled by this next line of Group by query */

Group by Cs.CustomerID, Cs.CustomerName, Cs.Country

/* Finally top customers selected by simply ordering in descending order and 
limiting row selection to 5 */

Order by TotalOrder Desc limit 5;