SELECT *
FROM mysql.covid_data
WHERE continent is not null
order by 3, 4;

SELECT *
FROM mysql.covid_vaccin
order by 3, 4;

-- Selection of data (Important ones)
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM mysql.covid_data
ORDER BY 1, 2;

-- total cases vs total death (estimate of survival from the virus)
SELECT location, date, total_cases, total_deaths, (total_deaths / covid_data.total_cases) * 100 AS death_percentage
FROM mysql.covid_data
WHERE location like '%nigeria%'
ORDER BY 1, 2;

-- total cases vs population (showing the percentage of population affected by the virus)
SELECT location, date, population, total_cases, (total_cases / covid_data.population) * 100 AS affected_population
FROM mysql.covid_data
WHERE location like '%nigeria%'
ORDER BY 1, 2;

-- Countries with highest infection rate compared to population
SELECT location,
       population,
       MAX(total_cases)                         AS highest_infection_count,
       MAX(total_cases / covid_data.population) AS affected_population
FROM mysql.covid_data
WHERE continent is not null
GROUP BY location, population
order by affected_population desc;

-- Countries with highest death count per population
SELECT location, MAX(total_deaths) AS total_death_count
FROM mysql.covid_data
WHERE continent is not null
GROUP BY location
order by total_death_count desc;

-- Continent with highest death count per population
SELECT continent, MAX(total_deaths) AS total_death_count
FROM mysql.covid_data
WHERE continent is not null
GROUP BY continent
order by total_death_count desc;

-- Least affected Continents
SELECT continent, MAX(total_cases) AS least_affected_Continents
FROM mysql.covid_data
WHERE continent is not null
GROUP BY continent
ORDER BY least_affected_Continents;

-- Least affected Countries
SELECT location, MAX(total_cases) AS least_affected_Countries
FROM mysql.covid_data
WHERE covid_data.continent is not null
GROUP BY location
ORDER BY least_affected_Countries;

-- GLOBAL NUMBERS
SELECT date, SUM(new_cases), SUM(new_deaths)
FROM mysql.covid_data
WHERE continent is not null
GROUP BY date;

-- DEATH PERCENTAGE GLOBALLY
SELECT date, SUM(new_cases), SUM(new_deaths), SUM(new_deaths) / SUM(new_cases) * 100 AS death_percentage
FROM mysql.covid_data
WHERE continent is not null
GROUP BY date;

-- TOTAL GENERAL CASES
SELECT SUM(new_cases)                         AS total_cases,
       SUM(new_deaths)                        AS total_death,
       SUM(new_deaths) / SUM(new_cases) * 100 AS death_percentage
FROM mysql.covid_data
WHERE continent is not null;









