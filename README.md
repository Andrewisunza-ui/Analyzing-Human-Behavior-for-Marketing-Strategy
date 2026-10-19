# Analyzing-Human-Behavior-for-Marketing-Strategy
Analyzing historical data for trends and patterns to design marketing strategies. 

Background: 

I am assuming the role of a junior data analyst at Cyclistic, a fictional bike-share company in Chicago. Customers who purchase single-ride or full-day passes are referred to as casual riders. Customers who purchase annual memberships are members. The marketing team aims to increase company revenue by converting casual riders into annual members. The team wants to analyze historical bike trip data to identify trends and patterns between casual and member riders. 

Ask:

The marketing team wants to get a better understanding of its customers to design an effective marketing strategy. I have been tasked to answer the following question: How do annual members and casual riders use Cyclistic bikes differently? 

Prepare:

I worked with bike trip data for the year 2025. The data was collected from [here](https://divvy-tripdata.s3.amazonaws.com/index.html). The data was organized into twelve .csv files, each representing a different month of 2025.  Each ride made by a customer was assigned a unique identifier, called ride id. The dataset describes the type of bike used, the date and time the ride took place, the stations where the ride started and ended, and whether the rider was a member or a casual user. After studying the data, I decided to approach the question by analyzing riders’ behaviors. Particularly, how long and when customers were using the bikes.  

Process:

The dataset had millions of rows, so I decided to clean and analyze the data using SQL. The cleaning process involved the following four steps: removing duplicates, deleting rows with null values, standardizing the data, and creating columns for analysis. This ensured that the data was accurate, complete, and fit for use. Afterward, I extracted data from existing columns to create new columns for my analysis. This allowed me to focus on data that could answer my business question. 

Analyze:

I did a descriptive analysis by performing aggregate functions and calculations to the data. The goal here was to reveal trends, patterns or relationships in the dataset. I counted the numbers of rides, and took the average ride lengths for each rider type. Then, I calculated when each rider type used the bikes in yearly, weekly, and hourly perspectives. 

Share:

My analysis revealed the following insights:

<img width="463" height="483" alt="image" src="https://github.com/user-attachments/assets/4aa9a5fa-3a3f-4dc2-bb50-8fbada40d92c" />

1.	Overall, the greatest number of rides occurred in the middle of the year. The beginning and end of the year saw the least rides. This correlates with Chicago’s weather. People don’t really want to ride bikes in the harsh winter but prefer to wait for warm weather.

<img width="468" height="55" alt="image" src="https://github.com/user-attachments/assets/6f445ffb-1b73-4f51-b123-201822062458" />

2.	On average, casual riders rode the bikes longer than member riders by almost double. Clearly, member riders are using the bikes with intention – to get from point a to point b. Casual rider are more likely to be going on leisurely cruises and activities. 

<img width="468" height="562" alt="image" src="https://github.com/user-attachments/assets/80c6b515-57b6-4288-8cd2-88d9f44bebb8" />

3.	Most casual rides took place on the weekend (Saturday and Sunday) whereas most member rides took place during the week (Monday to Friday). Casual riders are using the bikes for recreation and entertainment purposes on the weekends. Member rider used the bikes as their means of transportation for the work week.  

<img width="468" height="258" alt="image" src="https://github.com/user-attachments/assets/e2c1c800-5897-4564-b490-3c9a942e3b4d" />

4.	Casual riders tend to use bikes from late morning to late afternoon. The number of member rides spike in the early morning and late afternoon.  These spikes indicate that member riders are commuting to and from work on bikes. 

Act:

Having completed my analysis, I had the following recommendation for the Cyclistic marketing team:
1.	Instead of only an annual membership, Cyclistic could offer a six-month plan. Realistically, people don’t want to ride bikes in the winter, limiting usage to about six months of the year. But people don’t want to buy an annual membership when they’ll only get to use it for six months. Casual riders would see six-month plan as more of a value. The marketing team could start advertising the membership plan in late March when the weather starts to warm up. 
2.	Chicago is a major tourist destination so it’s likely that some of the casual riders are tourists. It wouldn’t make sense for tourists to buy membership plans. However, the marketing team could target tourists by advertising Cyclistic bike rentals in airports, tourist offices, hotels, hostels, bus and metro stations. 
3.	The marketing team could advertise its bikes as a convenient and efficient means to commute to work. Bikes allow riders to avoid the morning and afternoon rush hours. 
