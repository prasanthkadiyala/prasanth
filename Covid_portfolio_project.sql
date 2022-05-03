
--COVID PORTFOLIO SQL PROJECT

select *
from [Portfolio Project]..vaccinations$
order by 3,4

--Select that the data that we are using

SELECT location,date, total_cases, new_cases, total_deaths, population
FROM [Portfolio Project]..Coviddeaths
ORDER BY 1,2

--Looking at Total cases vs Total deaths
--Shows the likelihood of dying if you catch covid in your country

SELECT location,date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM [Portfolio Project]..Coviddeaths
WHERE location like '%Asia%'
ORDER BY 1,2

--Looking at Total Population vs Total Cases
--Shows the percentage of population affected by Covid

SELECT location,date, total_cases, total_deaths, population,(total_cases/population)*100 AS PopulationPercentage
FROM [Portfolio Project]..Coviddeaths
WHERE location like '%Asia%'
ORDER BY 1,2

--Identifying the countries with Highest Infection Rate


SELECT location, population, MAX(total_cases) AS HighestInfectionCount,MAX((total_cases/population))*100 AS PopulationPercentageInfected
FROM [Portfolio Project]..Coviddeaths
GROUP BY location,population
ORDER BY PopulationPercentageInfected Desc


--Identifying the countries with the Highest death count

SELECT location, Max(cast(total_deaths AS int)) AS HighestDeathCount
FROM [Portfolio Project]..Coviddeaths
WHERE continent is not null
GROUP BY location
ORDER BY HighestDeathCount Desc

--Identifying the Continents with the Highest death count


SELECT continent, Max(cast(total_deaths AS int)) AS HighestDeathCount
FROM [Portfolio Project]..Coviddeaths
WHERE continent is not null
GROUP BY continent
ORDER BY HighestDeathCount Desc


--GLOBAL NUMBERS

SELECT SUM(new_cases) AS New_Cases, SUM(cast(total_deaths AS int)) AS Total_Deaths, SUM(cast(new_deaths AS int))/SUM(new_cases)*100 AS DeathPercentage
FROM [Portfolio Project]..Coviddeaths
WHERE continent is not null
ORDER BY 1,2

--JOINING COVID DEATHS AND VACCINATIONS ON "LOCATION" AND "DATE"

SELECT *
FROM [Portfolio Project]..Coviddeaths AS Death
JOIN [Portfolio Project]..vaccinations$ AS Vac 
ON Death.location= Vac.location AND Death.date= Vac.date
on Death.location =Vac.location


--Total Population vs Fully_Vaccinated and fully vaccinated percentage

SELECT Vac.date,Death.continent,Death.location,Death.population,SUM(cast(Vac.people_fully_vaccinated AS int))AS Fully_Vaccinated_Count,SUM(cast(Vac.people_fully_vaccinated AS int)/Death.population)*100 AS Fully_Vaccinated_Percentage
FROM [Portfolio Project]..Coviddeaths AS Death
JOIN [Portfolio Project]..vaccinations$ AS Vac 
ON Death.location= Vac.location AND Death.date= Vac.date
WHERE Death.continent is not null
GROUP BY Vac.date, Death.continent, Death.location,Death.population, Vac.people_fully_vaccinated
ORDER BY people_fully_vaccinated DESC



 


