# Case Study 1: Bellabeat Smart Device Usage

### **Scenario Introduction**
Urška Sršen, cofounder and Chief Creative Officer of Bellabeat, believes that analyzing smart device fitness data could help unlock new growth opportunities for the company. 
You have been asked to focus on one of Bellabeat’s products and analyze smart device data to gain insight into how consumers are using their smart devices. 
The insights you discover will then help guide marketing strategy for the company. 
You will present your analysis to the Bellabeat executive team along with your high-level recommendations for Bellabeat’s marketing strategy.

---
### **Business task**
Identify the trends on the smart devices usage and the ways these trends can unlock new growth opportunities for the company 

---
### **Data sources**
[FitBit Fitness Tracker Data](https://www.kaggle.com/datasets/arashnic/fitbit?resource=download&select=mturkfitbit_export_4.12.16-5.12.16), public dataset from Kaggle. 
- This data set contains personal fitness tracker from 33 Fitbit users.
- 33 eligible Fitbit users consented to the submission of personal tracker data, including minute-level output for physical activity, heart rate, and sleep monitoring.
- It includes information about daily activity, steps, and heart rate that can be used to explore users’ habits.
- There are 2 main files in this dataset (12th March – 12th April 2016) and (12th April – 12th May 2016). We will use data from 12th April to 12th May 2016 only due to missing variables needed for our analysis in the other main file.
- Sub-files we used in the analysis:
  1.	dailyActivity_merged (record of daily steps, daily calories, total active minutes)
  2.	sleepDay_merged (record of total minutes asleep, total time in bed)
  3.	weightLogInfo_merged (record of weight and BMI)
---
### **Documentation of data cleaning**
Tools: Google Sheet
- New:
  1. Added column “Day” using TEXT function and apply to Date (Daily_activity, Sleep_daily and Weight_log_info)  
- Changes:
  1. Renamed files:
       - From dailyActivity_merged.csv into Daily_activity.csv
       - From sleepDay_merged.csv into Sleep_daily.csv
       - From weightLogInfo_merged.csv into Weight_log_info.csv
  2. Removed duplicates (Sleep_daily)
  3. Changed date format to MM-DD-YYYY (Sleep_daily and Weight_log_info)
  4. Rename column “SleepDay” into “Date” (Sleep_daily)
---
### **Summary of Analysis**
Tools: SQL BigQuery [(view SQL file here)](Case_Study_1_Bellabeat_Smart_Device_Usage.sql)
- Variation between output represents use of different types of Fitbit trackers and individual tracking behaviours/preferences.
- Total users:
  -	daily activity: 33 users
  -	daily sleep monitoring: 24 users
  -	weight: 8 users
- Range of users’ frequency:
  -	daily activity: between 4 and 31 times
  -	daily sleep monitoring: between 0 and 31 times (0 indicate users who never use sleep monitoring)
  -	weight: between 0 to 30 times (0 indicate users who never record weight)
- Average of users’ frequency (include all 33 users):
  -	daily activity: 28 times
  -	daily sleep monitoring: 12 times
  -	weight: 2 times
- Average by users:
  -	Calories: between 1483.35 and 3436.58
  -	Total steps: between 916.13 and 16040.03
  -	Very active minutes: 0.1 and 87.33
  -	Fairly active minutes: 0.26 and 61.27
  -	Lightly active minutes: 38.58 and 327.9
  -	Sedentary minutes: 662.32 and 1317.42
  -	Sleep (minutes): between 61 and 652 (24 users only)
- Average by day of the week:
  -	Calories: min (Thu - 2199.57), max (Tue - 2356.01) 
  -	Total steps: min (Sun - 6933.23), max (Sat - 8152.98) 
  -	Very active minutes: min (Thu - 19.41), max (Mon - 23.11) 
  -	Fairly active minutes: min (Thu - 11.96), max (Sat - 15.2) 
  -	Lightly active minutes: min (Sun - 173.98), max (Sat - 207.15) 
  -	Sedentary minutes: min (Thu - 961.99), max (Mon - 1027.94) 
  -	Sleep (minutes): min (Thu - 401.3), max (Sun - 452.75)
---
### **Supporting visualizations**
Tools: [Tableau](https://public.tableau.com/views/BellabeatCaseStudy_17183488909900/Dashboard1?:language=en-US&:sid=&:display_count=n&:origin=viz_share_link)

![Dashboard 1](https://github.com/NurNadhrah/Case-Study-1-Bellabeat-Smart-Device-Usage/assets/153793854/ffaef5e9-4f9f-45cb-9d44-61251871bd71)
![Dashboard 2](https://github.com/NurNadhrah/Case-Study-1-Bellabeat-Smart-Device-Usage/assets/153793854/7e05c111-8253-4df0-b0fe-115b84e7636f)
![Dashboard 3](https://github.com/NurNadhrah/Case-Study-1-Bellabeat-Smart-Device-Usage/assets/153793854/c361f85d-568f-49dc-9d50-97e837edb82c)
![Dashboard 4](https://github.com/NurNadhrah/Case-Study-1-Bellabeat-Smart-Device-Usage/assets/153793854/bcca4635-766a-4446-bfda-bd8224c7d255)
![Sheet 5](https://github.com/NurNadhrah/Case-Study-1-Bellabeat-Smart-Device-Usage/assets/153793854/e4f2d336-a123-4339-966e-77e219fda1c7)
![Sheet 5 (2)](https://github.com/NurNadhrah/Case-Study-1-Bellabeat-Smart-Device-Usage/assets/153793854/ac98c637-eb10-4a55-8e0d-de411e115225)
![Dashboard 6](https://github.com/NurNadhrah/Case-Study-1-Bellabeat-Smart-Device-Usage/assets/153793854/b0e62009-e522-4f24-bc94-8739e4cd877f)

