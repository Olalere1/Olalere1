/* Assumption: Question 2 countries are regarded as Non-EU; also 3 attributes 
needed where the Total revenue, Revenue from the identified non-EU countries and the percentage */

Select sum(Pr.Price*Od.Quantity) as TotalRevenue,
( 
       Case
           When Cs.Country IN ("Argentina", Brazil, Canada, Mexico, USA, Venezuela, Denmark, Finland, Norway, Sweden, Uk) 
               Then sum(Pr.Price*Od.Quantity) 
           else "0"
           END    
    )  AS TotalRevenue_nonEU,
       TotalRevenue_nonEU/TotalRevenue*100 as Percentage_NonEU
       
/* Only tables whose attributes were used in computing our 3 select attribute schema were used */
    
From Products Pr, OrderDetails Od, Orders Os, Customers Cs

/* These tables had to be joined together using attributes column common to them; 
this allows us to match information rows from one table to another in 
the course of building our SELECT queries */
Where Pr.ProductID = Od.ProductID and Os.OrderID = Od.OrderID and Cs.CustomerID = Os.CustomerID