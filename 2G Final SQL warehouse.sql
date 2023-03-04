
# final project focus on customer 

DROP TABLE IF EXISTS Leo_Table;
CREATE TABLE Leo_Table AS 
SELECT c.CustomerId,c.FirstName,c.LastName,c.Address,c.City,c.Country,
IF(Country LIKE 'Germany' OR 
		Country LIKE 'Norway' OR
        Country LIKE 'Czech Republic' OR
        Country LIKE 'Austria' OR
        Country LIKE 'Denmark' OR
        Country LIKE 'Portugal' OR
        Country LIKE 'France' OR 
        Country LIKE 'Hungary' OR
         Country LIKE 'Ireland' OR
         Country LIKE 'Italy' OR
         Country LIKE 'Netherlands' OR
         Country LIKE 'Poland' OR
         Country LIKE 'Spai' OR
         Country LIKE 'Swede' OR
         Country LIKE 'United Kingdom' OR
          Country LIKE 'Finland',
        'Europe', 'Non-Europe') AS Regions,
	Customermoney_spenton_Album, 
	Customer_average_yearly_purchase, 
    NumberOfAlbum_Customer_purchase,
    NUM_MEDIA_CUSTOMER_USED,
    NumberOfArtist_Customer_Like
FROM Customer c
JOIN( 
SELECT CustomerId, ROUND(SUM(Total),0) AS Customermoney_spenton_Album
FROM invoice i
GROUP BY CustomerId
) AS d
ON c.CustomerId = d.CustomerId
JOIN(
SELECT i.CustomerID, ROUND(ROUND(SUM(Total),0) / (YEAR(MAX(i.InvoiceDate))-YEAR(MIN(i.InvoiceDate))),1)AS Customer_average_yearly_purchase
FROM invoice i
GROUP BY CustomerId
) AS d2
ON c.CustomerId = d2.CustomerId
JOIN(
SELECT CustomerId,  COUNT(DISTINCT AlbumId) AS NumberOfAlbum_Customer_purchase
FROM InvoiceLine iv
JOIN track tr
USING (Trackid)
JOIN Invoice
USING (InvoiceId)
GROUP BY CustomerId
) AS d3
ON c.CustomerId = d3.CustomerId
JOIN(
SELECT CustomerId, COUNT( DISTINCT mt.MediaTypeId) AS NUM_MEDIA_CUSTOMER_USED
FROM InvoiceLine iv
JOIN track tr
USING (Trackid)
JOIN Invoice
USING (InvoiceId)
JOIN MediaType mt
USING(MediaTypeId)
GROUP BY CustomerId
) AS d4
ON c.CustomerId = d4.CustomerId
JOIN(
SELECT CustomerId, COUNT(DISTINCT ar.Name) AS NumberOfArtist_Customer_Like
FROM InvoiceLine iv
JOIN track tr
USING (Trackid)
JOIN Invoice
USING (InvoiceId)
JOIN Album
USING (AlbumId)
JOIN Artist ar
USING (ArtistId)
GROUP BY CustomerId
) AS d5
ON c.CustomerId = d5.CustomerId;

	
#################################################################









