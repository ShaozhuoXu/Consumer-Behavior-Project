#1 Below it reveals that what's the average album number that customers purchased for each country
#In this way, the company could enlarge its market share and promotional activities at the country whose Country_Average_Purchase ranked
#No.1, Norway.
SELECT
	Country,
	Round(Avg(NumberOfAlbum_Customer_purchase),0) as Country_Average_Purchase
FROM Leo_Table
GROUP BY Country
ORDER BY Country_Average_Purchase DESC
LIMIT 25;


#2 Below it reveals that how much money consumers spent on album for each 2012 and 2013 year.
#In this way, the company could monitor the sales trendency among consumers and positively adjust their strategies as well.
#As i could see, its trendency is going upward, which is good sign.
SELECT 
        year(latest_invoice) as year,
        Round(AVG(Customermoney_spenton_Album),2) as this_year_album_money_customer_spent_on
FROM Leo_Table
JOIN
(
SELECT CustomerId, max(invoiceDate) as latest_invoice
FROM invoice
GROUP BY CustomerID
) AS latest_invoice
USING (CustomerId)
GROUP BY year;


#3 Below it reveals that how much money has been spent, as divided by each country.
#In this way, the company could learn which country has the most powerful strength for purchasing.
#In this case, it is USA for sure with the total_album_money as 528 units. Thus, the company shall consider holding more sales activities in the states.
SELECT Country,
		SUM(Customermoney_spenton_Album) as total_album_money
FROM Leo_Table
GROUP BY Country
ORDER BY total_album_money DESC
LIMIT 25;


#4 Below it shows the 10 best customers who spend the most. It would help the company to identify the a group of the most important 
#customers, which helps to boost sales by making adjustments according to their requirements.
SELECT CustomerId, FirstName, LastName, Address, City, Country, Customermoney_spenton_Album
FROM Leo_Table
ORDER BY Customermoney_spenton_Album DESC
LIMIT 10;


#5 Below it reveals that how much albums that consumers within a country have purchased. This table could also shows the purchase power
#of each country. The result it generated also resonates with #4 where USA purchased the most amount of albums. Thus, the company could
#consider to set the product-releasing date earlier to further cultivate consumers' passion for the product.
select Country,sum(NumberOfAlbum_Customer_purchase) as total_album_purchased
from Leo_Table
group by country
order by total_album_purchased DESC
LIMIT 25;


#6 Below it shows the maximum artist number for each city in the states. It would help the company to locate which one will be the best
#spot to hold the offline album releasing, or signing events for its promotional needs, since the table represents the passion consumers have
#for artists varing from each city.
Select Country, City, max(NumberOfArtist_Customer_Like) as Maximum_artist_customer_like
from Leo_Table
WHERE Country = "USA"
group by City
ORDER BY Maximum_artist_customer_like DESC;


#7 Below shows the ranking of countries by the number of customers. It would help the company to make decisions on strategic focus on 
# which countries, since the table reflects the market size in different countries.
SELECT Country, COUNT(customerId) AS No_of_customers
FROM Leo_Table
GROUP BY Country
ORDER BY No_of_customers DESC;


#8 Below shows the 10 customers that have spent the most amount of money on purchasing albums. This could help the company to identify 
# the group of the most important customers, so as to prioritize their requirements to maintain loyal customers, and to optimize marketing
# and operational strategies accordingly.
SELECT CustomerId, FirstName, LastName, Address, City, Country, Customermoney_spenton_Album
FROM Leo_Table
ORDER BY Customermoney_spenton_Album DESC
LIMIT 10;

