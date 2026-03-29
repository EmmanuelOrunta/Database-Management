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
