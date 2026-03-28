-- 1. Database Setup
CREATE DATABASE OruntaS00403657;
USE OruntaS00403657;

-- 2. CLIMATE_IMPACT Table (Core Entity)
CREATE TABLE CLIMATE_IMPACT (
    ImpactID INT PRIMARY KEY AUTO_INCREMENT,
    ImpactName VARCHAR(100) NOT NULL UNIQUE,
    Description TEXT
);

-- 3. ENVIRONMENTAL_RESOURCE Table (Core Entity)
CREATE TABLE ENVIRONMENTAL_RESOURCE (
    ResourceID INT PRIMARY KEY AUTO_INCREMENT,
    ResourceName VARCHAR(100) NOT NULL UNIQUE,
    ResourceType VARCHAR(100)
);

-- 4. RESOURCE_IMPACT (M:N between Resource and Impact)
-- Primary key is composite: (ResourceID, ImpactID)
CREATE TABLE RESOURCE_IMPACT (
    ResourceID INT NOT NULL,
    ImpactID INT NOT NULL,
    ImpactMagnitude DECIMAL(3, 2) CHECK (ImpactMagnitude >= 0.00 AND ImpactMagnitude <= 1.00),
    PRIMARY KEY (ResourceID, ImpactID),
    FOREIGN KEY (ResourceID) REFERENCES ENVIRONMENTAL_RESOURCE(ResourceID) ON DELETE CASCADE,
    FOREIGN KEY (ImpactID) REFERENCES CLIMATE_IMPACT(ImpactID) ON DELETE CASCADE
);

-- 5. CAMPAIGN Table (Core Entity)
CREATE TABLE CAMPAIGN (
    CampaignID INT PRIMARY KEY AUTO_INCREMENT,
    CampaignName VARCHAR(255) NOT NULL UNIQUE,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    FundraisingGoal DECIMAL(10, 2) NOT NULL CHECK (FundraisingGoal >= 0),
    AmountRaised DECIMAL(10, 2) DEFAULT 0.00 CHECK (AmountRaised >= 0),
    CONSTRAINT CHK_Campaign_Dates CHECK (EndDate >= StartDate)
);

-- 6. CAMPAIGN_FOCUS (M:N between Campaign and Resource)
-- Primary key is composite: (CampaignID, ResourceID)
CREATE TABLE CAMPAIGN_FOCUS (
    CampaignID INT NOT NULL,
    ResourceID INT NOT NULL,
    PRIMARY KEY (CampaignID, ResourceID),
    FOREIGN KEY (CampaignID) REFERENCES CAMPAIGN(CampaignID) ON DELETE CASCADE,
    FOREIGN KEY (ResourceID) REFERENCES ENVIRONMENTAL_RESOURCE(ResourceID) ON DELETE CASCADE
);

-- 7. VOLUNTEER Table (Core Entity)
CREATE TABLE VOLUNTEER (
    VolunteerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Region VARCHAR(100),
    Demographics VARCHAR(255)
);

-- 8. VOLUNTEER_ACTIVITY (M:N between Volunteer and Campaign)
CREATE TABLE VOLUNTEER_ACTIVITY (
    VolunteerActivityID INT PRIMARY KEY AUTO_INCREMENT,
    VolunteerID INT NOT NULL,
    CampaignID INT NOT NULL,
    ActivityDate DATE NOT NULL,
    ActivityType VARCHAR(100) NOT NULL,
    FOREIGN KEY (VolunteerID) REFERENCES VOLUNTEER(VolunteerID) ON DELETE RESTRICT,
    FOREIGN KEY (CampaignID) REFERENCES CAMPAIGN(CampaignID) ON DELETE RESTRICT,
    UNIQUE KEY UQ_Volunteer_Activity (VolunteerID, CampaignID, ActivityDate)
);

-- 9. DONOR Table (Core Entity)
CREATE TABLE DONOR (
    DonorID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) NOT NULL UNIQUE,
    Region VARCHAR(100)
);

-- 10. DONATION (M:N between Donor and Campaign)
CREATE TABLE DONATION (
    DonationID INT PRIMARY KEY AUTO_INCREMENT,
    DonorID INT NOT NULL,
    CampaignID INT NOT NULL,
    DonationAmount DECIMAL(10, 2) NOT NULL CHECK (DonationAmount >= 0.01),
    DonationDate DATE NOT NULL,
    FOREIGN KEY (DonorID) REFERENCES DONOR(DonorID) ON DELETE RESTRICT,
    FOREIGN KEY (CampaignID) REFERENCES CAMPAIGN(CampaignID) ON DELETE RESTRICT
);