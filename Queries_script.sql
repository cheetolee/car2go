
--Create a script file. List at least 10 reasonable query statements (as comments)
--in English. Add SQL statements to execute these queries and get the results.

USE Car2Go
GO

-- 1. Display all the records of all the branches with all its attributes.
SELECT * FROM BRANCH;

-- 2. Display Street number and street name of all the branches located in quebec.  
SELECT STREET_NUMBER, STREET_NAME FROM BRANCH  WHERE PROVINCE = 'quebec';

-- 3. Display last name and first name of all the customers located in Toronto in a ascending order of their first name..  
SELECT FIRST_NAME, LAST_NAME FROM CUSTOMER WHERE CITY='TORONTO' ORDER BY FIRST_NAME;

-- 4. Display all the car class names along with their rate that have a rate of 50 or more.  
SELECT CLASS_ID,RATE FROM CLASSIFICATION WHERE RATE >= 50;

--5. Display phone number along with last name and plate number  of all the customers having area code 613 and their names in a ascending order of their area code.  
SELECT LOCAL_NUMBER, LAST_NAME, c.LICENSE_NUMBER FROM PHONE p, CUSTOMER C  WHERE C.LICENSE_NUMBER = P.LICENSE_NUMBER AND AREA_CODE=613 ORDER BY LAST_NAME;


--6. Display the minimum rate among car classifications
SELECT MIN(RATE) AS MINIMUM_RATE FROM CLASSIFICATION; 

--7. Display PLATE AND LICENCE NUMBERS FOR ALL CARS with a rent Date of "2008-11-11" 
SELECT C.PLATE_NUMBER, R.LICENSE_NUMBER FROM RENTAL R, CAR C WHERE RENTAL_DATE='2008-11-11';

--8. Display email address with first and last name for all customers living in London
SELECT E.EMAIL, c.FIRST_NAME,c.LAST_NAME FROM CUSTOMER C, EMAIL E WHERE c.LICENSE_NUMBER=E.LICENSE_NUMBER and C.CITY='LONDON';

--9 Show the first and the last name and the CITY of those customers that have rented a car in the category that has label = 'luxury'  
SELECT DISTINCT C.FIRST_NAME,C.LAST_NAME,C.CITY FROM CUSTOMER C, RENTAL R WHERE R.REQUESTED_CLASSIFICATION='lUXURY';

--10  Show the total amount of rentals per location ID (pick up)
SELECT COUNT(R.INITIAL_B_id) AS TOTAL_RENTALS FROM BRANCH B, RENTAL R  WHERE B.B_ID=R.INITIAL_B_ID;

--11 Show the number of times that a luxury vehicle has been requested from a branch in Quebec
SELECT COUNT(R.REQUESTED_CLASSIFICATION) AS NUMBER_OF_REQUESTS FROM BRANCH B, RENTAL R WHERE R.REQUESTED_CLASSIFICATION='LUXURY' AND B.PROVINCE='QUEBEC'  ;

--12  Show the RETURN DATE and the location ID of all rentals in 5/20/2015 
SELECT RETURN_DATE,RETURN_B_ID FROM RENTAL WHERE RENTAL_DATE='2022-06-15';


--13 Show all the CLASSES THAT HAVE promotions starting in first of july
SELECT C.CLASS_ID,P.PROMO_RATE FROM CLASSIFICATION C, PROMOTION P WHERE C.CLASS_ID=P.CLASS_ID AND P.START_DATE='2022-07-01';


-- 14 Display all Rentals where the Initial Mileage is greater than 1000
SELECT * FROM RENTAL WHERE INITIAL_MILAGE > 1000;


-- 15 Display all promotions where the promo rate is 50% off
SELECT * FROM PROMOTION WHERE PROMO_RATE = 50;


-- 16 Display all customers that are in Canada
SELECT * FROM CUSTOMER WHERE COUNTRY = 'CANADA';


-- 17 Display all customers that have a letter K in their first name
SELECT * FROM CUSTOMER WHERE FIRST_NAME LIKE '%K%';


-- 18 Display the Classification that has the highest rate
SELECT MAX(RATE) AS MAXIMUM_RATE FROM CLASSIFICATION;

-- 19.  Display the number of customers who live in a house (not apartment neither units)
SELECT COUNT(DISTINCT first_name) AS HOUSE_OWNERS FROM customer WHERE UNIT_NUMBER IS NULL;

-- 20. Display all rentals along with the amount of days the rental lasted, and the dropoff price of said rental
SELECT RENTAL_ID, DIFFERENCE(RETURN_DATE, RENTAL_DATE) AS DAYS_OF_RENTAL, DROPOFF_PRICE FROM RENTAL;

-- 21. Display for each rental, the requested classification and the received classification.
SELECT RENTAL_ID, REQUESTED_CLASSIFICATION, CLASS_ID AS RECEIVED_CLASSIFICATION FROM RENTAL, CAR WHERE RENTAL.VIN_NUMBER = CAR.VIN_NUMBER;

-- 22. Display rentals that are eligible for promotions, based on the return date.
SELECT RENTAL_ID, RETURN_DATE, PROMO_ID, START_DATE AS PROMO_START, END_DATE AS PROMO_END
FROM RENTAL, PROMOTION, CAR
WHERE RETURN_DATE BETWEEN START_DATE AND END_DATE
AND RENTAL.VIN_NUMBER = CAR.VIN_NUMBER
AND CAR.CLASS_ID = PROMOTION.CLASS_ID;
