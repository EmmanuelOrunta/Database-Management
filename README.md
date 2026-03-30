# 🌍 EcoAction International Database System

## 📌 Project Overview
This project was developed as part of **ITEC617 – Modern Database Management (Assessment 3)**. It focuses on designing and implementing a relational database system for **EcoAction International**, a global NGO dedicated to environmental protection and climate change mitigation.

EcoAction International collects and manages large volumes of data to support environmental advocacy, including:
- Environmental resources (air, water, soil, wildlife)
- Climate impacts (temperature change, sea-level rise, etc.)
- Volunteer participation and demographics
- Campaign performance and outreach

This database system was built to efficiently store, manage, and analyse this data to support decision-making and reporting.

---

## 🎯 Objectives
The key objectives of this project are:
- Design a well-structured relational database
- Ensure the database adheres to **Third Normal Form (3NF)**
- Implement tables with appropriate constraints
- Populate the database with realistic sample data
- Develop SQL queries to extract meaningful insights

---

## 🧱 Database Design (Conceptual Model)

### 🔹 Entities Identified
The following core entities were identified based on system requirements:

- **CLIMATE_IMPACT**
- **ENVIRONMENTAL_RESOURCE**
- **CAMPAIGN**
- **VOLUNTEER**
- **DONOR**

### 🔹 Relationships
- A **Volunteer** can participate in multiple campaigns
- A **Campaign** can have multiple volunteers
- A **Donor** can donate to multiple campaigns
- A **Campaign** can have multiple donors
- A **Campaign** can focus on multiple environmental resources
- A **Resource** can be impacted by multiple climate impacts

### 🔹 Normalisation
The database was normalised to **Third Normal Form (3NF)**:
- No repeating groups
- No partial dependencies
- No transitive dependencies

---

## 🗄️ Database Implementation (Logical Model)

### 📂 File: `ER DIAGRAM - SCRIPT.sql`

The database was implemented using MySQL with the following structure:

### 🔹 Database Creation

CREATE DATABASE OruntaS00403657;
USE OruntaS00403657;

## 🔹 Tables Created
- CLIMATE_IMPACT  
- ENVIRONMENTAL_RESOURCE  
- RESOURCE_IMPACT (M:N relationship)  
- CAMPAIGN  
- CAMPAIGN_FOCUS (M:N relationship)  
- VOLUNTEER  
- VOLUNTEER_ACTIVITY (M:N relationship)  
- DONOR  
- DONATION (M:N relationship)  

---

## 🔹 Example Table
CREATE TABLE CAMPAIGN (
    CampaignID INT PRIMARY KEY AUTO_INCREMENT,
    CampaignName VARCHAR(255) NOT NULL UNIQUE,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    FundraisingGoal DECIMAL(10, 2) NOT NULL CHECK (FundraisingGoal >= 0),
    AmountRaised DECIMAL(10, 2) DEFAULT 0.00 CHECK (AmountRaised >= 0),
    CONSTRAINT CHK_Campaign_Dates CHECK (EndDate >= StartDate)

##🔹 Constraints Used
Primary Keys
Foreign Keys
UNIQUE constraints
CHECK constraints
Composite keys for relationship tables

---
## 📥 Data Population

### 📂 File: INSERT VALUES QUERIES.sql

The database was populated with realistic sample data to simulate real-world operations.

🔹 Data Includes
Climate impacts (e.g., Sea-Level Rise, Extreme Weather)
Environmental resources (e.g., Wildlife, Water Quality)
Campaigns with different goals and outcomes
Volunteers across different regions
Donors contributing to campaigns

🔹 Example Insert
INSERT INTO CAMPAIGN (CampaignName, StartDate, EndDate, FundraisingGoal, AmountRaised)
VALUES ('Clean Oceans 2025', '2025-01-15', '2025-12-31', 10000.00, 8500.50);

---
## 📊 SQL Queries (Part C)

### 📂 File: PART C - SQL QUERIES.sql

A set of advanced SQL queries were developed to analyse the data.

🔍 Queries Implemented
1. Top 5 Donors per Region for a Specific Campaign
Uses ROW_NUMBER() window function
Partitions donors by region

2. Number of Campaigns per Volunteer
Uses COUNT() and GROUP BY

3. Active Campaigns (Wildlife / Water Focus)
Filters campaigns still accepting donations

4. Donors Contributing to Multiple Campaigns

SELECT
    D.DonorID,
    D.FirstName,
    D.LastName,
    COUNT(DISTINCT DN.CampaignID) AS CampaignsContributedTo
FROM DONOR D
JOIN DONATION DN ON D.DonorID = DN.DonorID
GROUP BY D.DonorID
HAVING COUNT(DISTINCT DN.CampaignID) > 1;

5. Average Donation per Donor
Uses subquery with aggregation

6. Campaigns Affected by Climate Impacts
Joins multiple tables

7. Volunteers in High-Value Campaigns (> $5000)
Filters based on AmountRaised

8. Urgent Campaigns (< 10 Days Left)
Uses DATEDIFF() for time-based filtering

9. Top Environmental Resources
Ranked by campaign associations

10. Top 3 Campaigns Summary
Includes number of volunteers and donors
Filters campaigns with both participants
