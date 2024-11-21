# Netflix Data Analysis with SQL

## Project Overview
This project demonstrates SQL skills by analyzing a hypothetical Netflix dataset. The analysis provides insights into various aspects of Netflix content, such as genre distribution, country-specific trends, top-performing content, and more. The project focuses on solving 15 business problems using SQL queries.

## Table of Contents
- [Dataset Schema](#dataset-schema)
- [Business Problems and Solutions](#business-problems-and-solutions)
- [Tools Used](#tools-used)
- [How to Use](#how-to-use)

## Dataset Schema
The dataset used for this project consists of the following columns:
- **show_id**: Unique identifier for each content item
- **type**: Type of content (e.g., Movie or TV Show)
- **title**: Title of the content
- **director**: Director(s) of the content
- **casts**: Cast members
- **country**: Country where the content was produced
- **date_added**: Date the content was added to Netflix
- **release_year**: Year the content was released
- **rating**: Content rating (e.g., PG, TV-MA)
- **duration**: Duration of the content (e.g., number of seasons or runtime)
- **listed_in**: Categories or genres of the content
- **description**: A short description of the content

## Business Problems and Solutions

1. **Count the number of Movies vs TV Shows**  
   Query groups content by type and counts the number of Movies and TV Shows.  

2. **Find the most common rating for Movies and TV Shows**  
   Identifies the top ratings for Movies and TV Shows using `RANK()`.

3. **List all Movies released in a specific year (e.g., 2020)**  
   Filters Movies by their release year.

4. **Top 5 countries with the most content on Netflix**  
   Splits country data and counts the number of content items for each country.

5. **Identify the longest Movie**  
   Finds the Movie with the maximum duration.

6. **Find content added in the last 5 years**  
   Filters content based on the `date_added` field using `TO_DATE()`.

7. **Find all content by director 'Rajiv Chilaka'**  
   Searches for content directed by 'Rajiv Chilaka' using case-insensitive matching.

8. **List all TV Shows with more than 5 seasons**  
   Filters TV Shows with `duration` greater than 5 seasons.

9. **Count the number of content items in each genre**  
   Splits the `listed_in` field into genres and counts the occurrences.

10. **Average number of content releases by India per year**  
    Calculates the yearly average of content added by India, sorted by the highest averages.

11. **List all Movies that are Documentaries**  
    Filters Movies labeled as Documentaries in the `listed_in` column.

12. **Find all content without a director**  
    Identifies content where the `director` field is null.

13. **Count how many Movies Salman Khan appeared in the last 10 years**  
    Searches for appearances of 'Salman Khan' in the `casts` field for the last 10 years.

14. **Top 10 actors with the most appearances in Indian content**  
    Identifies the top 10 actors based on the number of appearances in Indian content.

15. **Categorize content based on keywords 'kill' and 'violence'**  
    Labels content containing 'kill' or 'violence' as "Bad Content" and others as "Good Content". Counts the occurrences of each category.

## Tools Used
- **Database**: PostgreSQL
- **Query Language**: SQL

## How to Use
1. Clone this repository to your local machine.
   ```bash
   git clone <repository-url>
