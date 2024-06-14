-- This SQL code was run in BigQuery

-- Determine how many users use daily activity features
SELECT COUNT(DISTINCT Id)
FROM `bellabeat-case-study-426114.Bellabeat.daily_activity`

-- Determine how many users use sleep monitoring features
SELECT COUNT(DISTINCT Id)
FROM `bellabeat-case-study-426114.Bellabeat.daily_sleep`

-- Determine how many users use weight and BMI features
SELECT COUNT(DISTINCT Id)
FROM `bellabeat-case-study-426114.Bellabeat.weight_log_info`

-- Calculate users' frequency (how many times each user use the daily activity feature)
-- Save to new table in datatset (format query settings to save the new table)
SELECT Id, COUNT(*) AS daily_activity_users_freq
FROM `bellabeat-case-study-426114.Bellabeat.daily_activity`
GROUP BY Id
ORDER BY daily_activity_users_freq DESC

-- Calculate users' frequency (how many times each user use the sleep monitoring feature)
-- Save to new table in datatset (format query settings to save the new table)
SELECT Id, COUNT(*) AS sleep_users_freq
FROM `bellabeat-case-study-426114.Bellabeat.daily_sleep`
GROUP BY Id
ORDER BY sleep_users_freq DESC

-- Calculate users' frequency (how many times each user use the weight and BMI feature)
-- Save to new table in datatset (format query settings to save the new table)
SELECT Id, COUNT(*) AS weightinfo_users_freq
FROM `bellabeat-case-study-426114.Bellabeat.weight_log_info`
GROUP BY Id
ORDER BY weightinfo_users_freq DESC

-- Calculate the average of users' frequency for all 33 users including those who never use certain features
SELECT AVG(activity.activity_users_freq) AS avg_activity_users_freq,
SUM(sleep.sleep_users_freq)/33 AS avg_sleep_users_freq,
SUM(weight.weightinfo_users_freq)/33 AS avg_weightinfo_users_freq
FROM `bellabeat-case-study-426114.Bellabeat.daily_activity_users_freq` AS activity
FULL OUTER JOIN `bellabeat-case-study-426114.Bellabeat.sleep_users_freq` AS sleep
ON activity.Id = sleep.Id
FULL OUTER JOIN `bellabeat-case-study-426114.Bellabeat.weightinfo_users_freq` AS weight
ON activity.Id = weight.Id
    
-- Join 3 new tables and export results to local file
-- Convert null values to 0 (indicate user never use the feature)
SELECT activity.Id,
IFNULL(activity.activity_users_freq, 0) AS activity_users_freq,
IFNULL(sleep.sleep_users_freq, 0) AS sleep_users_freq,
IFNULL(weight.weightinfo_users_freq, 0) AS weightinfo_users_freq
FROM `bellabeat-case-study-426114.Bellabeat.daily_activity_users_freq` AS activity
FULL OUTER JOIN `bellabeat-case-study-426114.Bellabeat.sleep_users_freq` AS sleep
ON activity.Id = sleep.Id
FULL OUTER JOIN `bellabeat-case-study-426114.Bellabeat.weightinfo_users_freq` AS weight
ON activity.Id = weight.Id
ORDER BY activity_users_freq DESC

    
-- Calculate average of total steps, calories, and different active minutes by users
-- Calculate min and max for each average by users
-- Temp table (lines 63-73) must be run simultaneously with lines 74-80
WITH avg_by_users AS (
  SELECT Id,
  ROUND(AVG(TotalSteps), 2) AS avg_total_steps,
  ROUND(AVG(Calories), 2) AS avg_calories,
  ROUND(AVG(VeryActiveMinutes), 2) AS avg_very_active_minutes,
  ROUND(AVG(FairlyActiveMinutes), 2) AS avg_fairly_active_minutes,
  ROUND(AVG(LightlyActiveMinutes), 2) AS avg_lightly_active_minutes,
  ROUND(AVG(SedentaryMinutes), 2) AS avg_sedentary_minutes
  FROM `bellabeat-case-study-426114.Bellabeat.daily_activity` 
  GROUP BY Id
)
SELECT CONCAT(MIN(avg_total_steps), " - ", MAX(avg_total_steps)) AS average_total_steps,  
CONCAT(MIN(avg_calories), " - ", MAX(avg_calories)) AS average_calories,
CONCAT(MIN(avg_very_active_minutes), " - ", MAX(avg_very_active_minutes)) AS average_very_active_minutes,
CONCAT(MIN(avg_fairly_active_minutes), " - ", MAX(avg_fairly_active_minutes)) AS average_fairly_active_minutes,
CONCAT(MIN(avg_lightly_active_minutes), " - ", MAX(avg_lightly_active_minutes)) AS average_lightly_active_minutes,
CONCAT(MIN(avg_sedentary_minutes), " - ", MAX(avg_sedentary_minutes)) AS average_sedentary_minutes
FROM avg_by_users


-- Calculate average of total steps, calories, and different active minutes by days of the week
-- Calculate min and max for each average by days of the week
-- Temp table (lines 88-98) must be run simultaneously with lines 99-103
-- Subquery in lines 101-103 calculate max of average of sedentary minutes
-- Subquery need to be modify to calculate min or max of other variables
WITH avg_by_days AS (
  SELECT Day,
  ROUND(AVG(TotalSteps), 2) AS avg_total_steps,
  ROUND(AVG(Calories), 2) AS avg_calories,
  ROUND(AVG(VeryActiveMinutes), 2) AS avg_very_active_minutes,
  ROUND(AVG(FairlyActiveMinutes), 2) AS avg_fairly_active_minutes,
  ROUND(AVG(LightlyActiveMinutes), 2) AS avg_lightly_active_minutes,
  ROUND(AVG(SedentaryMinutes), 2) AS avg_sedentary_minutes
  FROM `bellabeat-case-study-426114.Bellabeat.daily_activity` 
  GROUP BY Day
)
SELECT * 
FROM avg_by_days
WHERE avg_sedentary_minutes = (
  SELECT MAX(avg_sedentary_minutes) FROM avg_by_days
)


-- Calculate average of total minutes asleep by users
-- Calculate min and max for average by users
-- Temp table (lines 109-114) must be run simultaneously with lines 115-116
WITH sleep_table AS (
  SELECT Id, ROUND(AVG(TotalMinutesAsleep), 2) AS avg_total_minutes_asleep
  FROM `bellabeat-case-study-426114.Bellabeat.daily_sleep`
  GROUP BY Id
  ORDER BY avg_total_minutes_asleep DESC
)
SELECT MIN(avg_total_minutes_asleep), MAX(avg_total_minutes_asleep) 
FROM sleep_table


-- Calculate average of total minutes asleep by days of the week
-- Calculate min and max for average by days of the week
-- Temp table (lines 124-129) must be run simultaneously with lines 130-134
-- Subquery in lines 132-134 calculate the min of average of total minutes asleep
-- Subquery need to be modify to calculate the max of average of total minutes asleep
WITH sleep_table AS (
  SELECT Day, ROUND(AVG(TotalMinutesAsleep), 2) AS avg_total_minutes_asleep
  FROM `bellabeat-case-study-426114.Bellabeat.daily_sleep`
  GROUP BY Day
  ORDER BY avg_total_minutes_asleep DESC
)
SELECT * 
FROM sleep_table
WHERE avg_total_minutes_asleep = (
  SELECT MIN(avg_total_minutes_asleep) FROM sleep_table
)