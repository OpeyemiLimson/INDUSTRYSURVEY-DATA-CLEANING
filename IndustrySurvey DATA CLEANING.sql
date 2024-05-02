select *
from PortfolioProject..IndustrySurvey

-----Data CLeaning Of IndustrySurvey

---- After doing some basic cleaning in Excel like renaming columns.

--- ADjust the Date 

SELECT TRY_CONVERT(Date, Timestamp) AS ConvertedDate
FROM PortfolioProject..IndustrySurvey

Alter table IndustrySurvey
add  ConvertedDate Date;

update IndustrySurvey
set  ConvertedDate = TRY_CONVERT(DATE, Timestamp)

	
	
	
	-- clean the country data

		--- Correct the countries name to UNITED STATES where the it is spelt incorrectly using the City and Currency to clean the data

			UPDATE IndustrySurvey
		SET Country = 'United States'
		WHERE USA_State IS NOT NULL;

			UPDATE IndustrySurvey
		SET Country = 'United States'
		WHERE Currency =  'USD';

			--- GBP/CAD currency to clean United kingdom and Canada data

		UPDATE IndustrySurvey
		SET Country = 'United Kingdom'
		WHERE Currency =  'GBP';

			--- it is also best we clean countries using EUR as European Union

			UPDATE IndustrySurvey
		SET Country = 'European Union'
		WHERE Currency =  'EUR';

	

		-- Australia and New Zealand Currency needs to Split into AUD & NZD respectively

				UPDATE IndustrySurvey
		SET Currency = 'NZD'						--- do the same for AUD
		WHERE Country =  'New Zealand';

			--- Other countries needs cleaning too

					UPDATE IndustrySurvey
		SET Country = 'Nigeria'
		WHERE Country = 'NIGERIA'




 -- Analyze the salary into range; low salary, medium salary and high salary

		 select Annual_Salary,
		CASE 
				WHEN Annual_Salary between 0 and 30000 THEN 'Low Salary'
				WHEN Annual_Salary between 30001 and 60000 THEN 'Lower Middle Salary'
				WHEN Annual_Salary between 60001 and 85000 THEN 'Upper Middle Salary'
				ELSE 'High Salary'
		END AS Annual_Salary_Range
	from PortfolioProject..IndustrySurvey

	ALTER TABLE IndustrySurvey
	add Annual_Salary_Range varchar(225)



update IndustrySurvey
			 set Annual_Salary_Range =
			 CASE
				WHEN Annual_Salary between 0 and 30000 THEN 'Low Salary'
				WHEN Annual_Salary between 30001 and 60000 THEN 'Lower Middle Salary'
				WHEN Annual_Salary between 60001 and 85000 THEN 'Upper Middle Salary'
				ELSE 'High Salary'
				END


				


	---- convert null values in bonuses to null

update IndustrySurvey
	set Allowances = 
	case
	when Allowances is null then 0
	else Allowances
	end


	
--- Change Gender from 'Man' and 'Woman' to MALE and FEMALE

UPDATE IndustrySurvey
		SET Gender = 'Male'
		WHERE Gender = 'Man';



---- Clean the Race to distinct Groups i.e white,Black or African American


UPDATE IndustrySurvey
		SET Race = 'Other Options/Prefer Not Say'
		WHERE Race is null;

	select *
		from PortfolioProject..IndustrySurvey
	

	---- delete unused column

ALTER TABLE IndustrySurvey
drop column Allowances