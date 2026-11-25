-- THE MOONLIT PEARL CASE
--
-- Kaito Kid has stolen the Moonlit Pearl. Detective Conan believes every clue
-- can be solved with the conan_case database. Write one query beneath each clue.
-- Each Clue will help you in solving the next Clue



-- Clue #1
-- Airport cameras first spotted Kid in the middle east region
-- He is rumored to be staying in the least populated country in the middle east
-- Sort the matching countries by population and return only the first result.

-- Write SQL query here
SELECT *
FROM countries
WHERE region = 'Middle East'
ORDER BY population ASC
LIMIT 1;



-- Clue #2
-- Kaito kid is has been spotted in the capital of the country from Clue #1
-- The countries table contains a "capital" column and this column corresponds with the id in the cities table
-- find the capital of the country based on the country you got from the last clue

-- Write SQL query here
SELECT cities.*
FROM cities
JOIN countries ON cities.id = countries.capital
WHERE countries.code = (
    SELECT code
    FROM countries
    WHERE region = 'Middle East'
    ORDER BY population ASC
    LIMIT 1
);


-- Clue #3
-- The message says: "My next stop is another GCC country. Arabic is official
-- there, and its government form is a Emirate Federation. Join countries with
-- official_languages to identify the country.

-- Write SQL query here

SELECT countries.*
FROM countries
JOIN official_languages ON countries.code = official_languages.countrycode
WHERE countries.governmentform = 'Emirate Federation'
  AND official_languages.language = 'Arabic'
  AND countries.code IN ('AE', 'BH', 'KW', 'OM', 'QA', 'SA');

-- Clue #4
-- There are 5 cities from the country in Clue #3 appear in the case database.
-- We recieve an anonymous message in our agency that he is staying in a city that starts with the letters "Aj"
-- Find the city that matches this description

-- Write SQL query here
SELECT cities. *
FROM cities
JOIN countries ON cities.countrycode = countries.code
JOIN countrylanguages ON countries.code = countrylanguages.countrycode
WHERE countrylanguages.language = 'Arabic'
  AND countries.governmentform = 'Emirate Federation'
  AND cities.name LIKE 'Aj%';




-- Clue #5
-- The city from Clue #4 was a decoy. A damaged luggage tag begins with "Sh",
-- and the arrival country was in the Middle East. Join countries and cities,
-- then use ILIKE to find the matching city and its country.

-- Write SQL query here
SELECT cities.name AS city_name, countries.name AS country_name, countries.code
FROM cities
JOIN countries ON cities.countrycode = countries.code
WHERE countries.region = 'Middle East'
  AND cities.name ILIKE 'Sh%';
-- Clue #6
-- A taxi driver in the country from Clue #5 says Kid is heading to the capital.
-- Find the capital of this country.

-- Write SQL query here

SELECT cities.*
FROM cities
JOIN countries ON cities.id = countries.capital
WHERE countries.code = (
    SELECT countries.code
    FROM cities
    JOIN countries ON cities.countrycode = countries.code
    WHERE countries.region = 'Middle East'
      AND cities.name ILIKE 'Sh%'
    LIMIT 1
);


-- Clue #7
-- At the capital, Conan finds one final note:
--
--   "Your database counted 148004 people before my arrival.
--    Add one phantom passenger and search the new total.
--    Reach that city before midnight, and the pearl is yours."
--
-- Find the city with this population and you will find the Kid

-- Write SQL query here

-- Clue #7
SELECT *
FROM cities
WHERE population = 148004 + 1;
-- FINAL QUESTION
-- In which city should Conan wait for Kaito Kid?
-- manama