-- create a staging table for cleaning from the raw data 
CREATE TABLE tripdata_2025_staging
LIKE tripdata_2025_combined;

SELECT
	*
FROM
	`Cyclistic`.`tripdata_2025_staging`; -- creates the columns 

INSERT tripdata_2025_staging
SELECT 
	*
FROM
	`Cyclistic`.`tripdata_2025_combined`; -- inserts the data into the columns 

-- REMOVING DUPLICATES 

SELECT
	*,
	ROW_NUMBER() OVER(
	PARTITION BY ride_id) AS row_num  
FROM
	`Cyclistic`.`tripdata_2025_staging`; -- window function row_number 

-- creating a CTE (common table expression) to filter out duplicates 
WITH duplicate_cte AS 
(
SELECT
	*,
	ROW_NUMBER() OVER(
	PARTITION BY ride_id) AS row_num  
FROM
	`Cyclistic`.`tripdata_2025_staging`
)
SELECT
	*
FROM
	duplicate_cte
WHERE
	row_num > 1; -- there are no duplicate ride ids 

-- REMOVING ROWS WITH NULL OR BLANK VALUES

SELECT
	*
FROM
	`Cyclistic`.`tripdata_2025_staging`
WHERE
	end_station_name IS NULL OR end_station_name = ''; -- went through all the columns to find nulls or blanks/empty
	
DELETE FROM tripdata_2025_staging
WHERE start_station_name IS NULL OR start_station_name = ''
	OR start_station_id IS NULL OR start_station_id = ''
	OR end_station_name IS NULL OR end_station_name = ''
	OR end_station_id IS NULL OR end_station_id = ''; -- deleted rows with nulls or empty values

SELECT
	*
FROM
	`Cyclistic`.`tripdata_2025_staging`
WHERE
	start_lat IS NULL OR start_lat = ''
	OR start_lng IS NULL OR start_lng = ''
	OR end_lat IS NULL OR end_lat = ''
	OR end_lng IS NULL OR end_lng = ''; -- checked the remaining columns for nulls or empty values 
	
SELECT
	DISTINCT member_casual
FROM
	`Cyclistic`.`tripdata_2025_staging`; -- checked possible values in member_casual 
	
ALTER TABLE tripdata_2025_staging
RENAME COLUMN member_casual TO rider_type; -- renamed member_casual to rider_type for more clarity 

-- ADD COLUMNS FOR ANALYSIS 

-- ride_length column to see how long rides are 
ALTER TABLE tripdata_2025_staging
ADD ride_length TIME;

UPDATE tripdata_2025_staging
SET ride_length = TIMEDIFF(ended_at, started_at); -- added column ride_lenth and updated with data using timediff function

SELECT
	*
FROM 
	`Cyclistic`.`tripdata_2025_staging`
WHERE
	ride_length IS NULL OR ride_length = ''; -- no nulls or empty values in new column

SELECT
	*
FROM 
	`Cyclistic`.`tripdata_2025_staging`
WHERE
	ride_length < 0; -- checked for negative values

SELECT
	*
FROM 
	`Cyclistic`.`tripdata_2025_staging`
WHERE
	MINUTE(ride_length) < 1; -- checked for rides < 1 minute
	
SELECT
	*
FROM 
	`Cyclistic`.`tripdata_2025_staging`
WHERE
	HOUR(ride_length) >= 24; -- checked for rides > 24 hours

DELETE FROM tripdata_2025_staging
WHERE ride_length < 0 
	OR MINUTE(ride_length) < 1 
	OR HOUR(ride_length) >= 24; -- deleted negative values and constrained ride lengths between 1 minute and 24 hours 
	
-- day_of_week column
ALTER TABLE tripdata_2025_staging
ADD day_of_week TEXT; -- added day_of_week column 

SELECT
	started_at,
	DAYNAME(started_at) AS `day` 
FROM
	`Cyclistic`.`tripdata_2025_staging`; -- checked the dayname function

UPDATE tripdata_2025_staging
SET day_of_week = DAYNAME(started_at); -- updated column with data using dayname function 

SELECT
	*
FROM
	`Cyclistic`.`tripdata_2025_staging`
 WHERE
 	day_of_week IS NULL OR day_of_week = ''; -- no nulls or empty values in new column 
 
 -- hour column
 ALTER TABLE tripdata_2025_staging
 ADD `hour` INT;

UPDATE tripdata_2025_staging
SET `hour` = HOUR(started_at); -- created and updated column with hour function 

-- month column
ALTER TABLE tripdata_2025_staging
ADD `month` TEXT;

UPDATE tripdata_2025_staging
SET `month` = MONTHNAME(started_at); -- created and updated month column with name of month 

-- SUMMARY DATA/EXPLORING 
SELECT
	rider_type,
	TIME_FORMAT(SEC_TO_TIME(AVG(TIME_TO_SEC(ride_length))), '%H:%i:%s') AS avg_ride_length,
	COUNT(ride_id) AS number_of_rides,
	MAX(ride_length) AS longest_ride,
	MIN(ride_length) AS shortest_ride
FROM
	`Cyclistic`.`tripdata_2025_staging`
GROUP BY
	rider_type; -- average ride lengths, number of rides, longest and shortest ride by rider type 

SELECT
	day_of_week,
	COUNT(ride_id) AS num_of_rides,
	TIME_FORMAT(SEC_TO_TIME(AVG(TIME_TO_SEC(ride_length))), '%H:%i:%s') AS avg_ride_length
FROM
	`Cyclistic`.`tripdata_2025_staging`
GROUP BY 
	day_of_week
ORDER BY
	avg_ride_length DESC; -- saturday and friday had the most rides; sunday and saturday had the longest rides 

SELECT
	`month`,
	COUNT(ride_id) AS num_of_rides
FROM
	`Cyclistic`.`tripdata_2025_staging`
GROUP BY
	`month`
ORDER BY
	num_of_rides DESC; -- most of the rides happened in the warmest months 

SELECT
	`hour`,
	COUNT(ride_id) AS number_of_rides
FROM
	`Cyclistic`.`tripdata_2025_staging`
WHERE
	rider_type = 'casual'
GROUP BY
	`hour`
ORDER BY
	`hour`; -- member usage spikes in morning and evening rushhours while casual usage peaks early afternoon 







	