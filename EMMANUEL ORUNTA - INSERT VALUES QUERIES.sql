-- SQL QUERIES USED TO INSERT NEW DATA IN THE TABLES IN MY DATABASE

-- 1. CLIMATE_IMPACT
INSERT INTO CLIMATE_IMPACT (ImpactName, Description) VALUES
('Sea-Level Rise', 'Threatens coastal communities and ecosystems.'),
('Ocean Acidification', 'Caused by absorbed CO2, harming marine life.'),
('Temperature Changes', 'Increased global average temperatures and extreme heat events.'),
('Extreme Weather', 'Increased frequency and intensity of storms, floods, and droughts.');

-- 2. ENVIRONMENTAL_RESOURCE
INSERT INTO ENVIRONMENTAL_RESOURCE (ResourceName, ResourceType) VALUES
('Wildlife', 'Biological'),
('Water Quality', 'Physical'),
('Forest Cover', 'Biological'),
('Air Quality', 'Physical'),
('Soil Health', 'Physical');

-- 3. RESOURCE_IMPACT (Linking Impacts to Resources)
INSERT INTO RESOURCE_IMPACT (ResourceID, ImpactID, ImpactMagnitude) VALUES
(1, 3, 0.85), -- Wildlife impacted by Temperature Changes
(2, 4, 0.70), -- Water Quality impacted by Extreme Weather (flooding)
(3, 3, 0.60), -- Forest Cover impacted by Temperature Changes (fires)
(2, 1, 0.90), -- Water Quality impacted by Sea-Level Rise (salinization)
(5, 3, 0.55); -- Soil Health impacted by Temperature Changes (drought)

-- 4. CAMPAIGN (Campaigns for all subsequent data)
INSERT INTO CAMPAIGN (CampaignName, StartDate, EndDate, FundraisingGoal, AmountRaised) VALUES
('Clean Oceans 2025', '2025-01-15', '2025-12-31', 10000.00, 8500.50), -- Campaign 1: High-achieving, still accepting
('Save the Bears', '2025-03-01', '2025-06-30', 5000.00, 5200.00),     -- Campaign 2: Met goal, closed
('Renewable Energy Push', '2024-11-01', '2025-03-15', 7500.00, 4800.00), -- Campaign 3: Failed goal, closed
('Amazon Reforestation Fund', '2025-08-01', '2025-11-15', 20000.00, 18500.00), -- Campaign 4: High goal, 15 days left (based on current date being 2025-11-01), near goal
('Stop Air Pollution Now', '2025-09-01', '2025-11-10', 3000.00, 1500.00); -- Campaign 5: Low goal, 10 days left (based on current date being 2025-11-01), unmet goal

-- 5. CAMPAIGN_FOCUS (Linking Campaigns to Resources)
INSERT INTO CAMPAIGN_FOCUS (CampaignID, ResourceID) VALUES
(1, 2), -- Clean Oceans focuses on Water Quality
(2, 1), -- Save the Bears focuses on Wildlife (needed for query)
(3, 4), -- Renewable Energy focuses on Air Quality
(4, 3), -- Reforestation focuses on Forest Cover
(5, 4), -- Stop Air Pollution focuses on Air Quality
(1, 1); -- Clean Oceans also focuses on Wildlife

-- 6. VOLUNTEER
INSERT INTO VOLUNTEER (FirstName, LastName, Email, Region, Demographics) VALUES
('Alice', 'Green', 'alice@example.com', 'North America', 'Student, Age 22'),    -- V1
('Bob', 'Smith', 'bob@example.com', 'Europe', 'Professional, Age 35'),          -- V2
('Clara', 'Jones', 'clara@example.com', 'Asia', 'Retired, Age 60'),            -- V3
('David', 'Lee', 'david@example.com', 'North America', 'Student, Age 19');     -- V4 (Used for high-value campaign)

-- 7. VOLUNTEER_ACTIVITY (Linking Volunteers to Campaigns)
INSERT INTO VOLUNTEER_ACTIVITY (VolunteerID, CampaignID, ActivityDate, ActivityType) VALUES
(1, 1, '2025-01-20', 'Social Media'), -- Alice in C1
(1, 3, '2025-02-10', 'Letter-writing'), -- Alice in C3 (2 campaigns total)
(2, 1, '2025-01-25', 'Direct action'), -- Bob in C1
(3, 4, '2025-09-05', 'Social Media'), -- Clara in C4
(4, 4, '2025-09-06', 'Direct action'), -- David in C4 (High-value campaign)
(4, 5, '2025-09-15', 'Letter-writing'), -- David in C5
(2, 2, '2025-03-05', 'Social Media'); -- Bob in C2 (3 campaigns total)

-- 8. DONOR
INSERT INTO DONOR (FirstName, LastName, Email, Region) VALUES
('Ethan', 'Moore', 'ethan@donor.com', 'North America'), -- D1
('Fiona', 'Clark', 'fiona@donor.com', 'Europe'),        -- D2
('George', 'Wang', 'george@donor.com', 'Asia'),         -- D3
('Hannah', 'Kim', 'hannah@donor.com', 'North America'), -- D4 (Multiple Campaigns)
('Ivan', 'Patel', 'ivan@donor.com', 'Europe');          -- D5 (Top donor)

-- 9. DONATION (Linking Donors to Campaigns)
INSERT INTO DONATION (DonorID, CampaignID, DonationAmount, DonationDate) VALUES
-- Donations to Campaign 1 (Clean Oceans)
(1, 1, 1500.00, '2025-01-16'), -- Ethan (NA)
(2, 1, 1000.00, '2025-01-18'), -- Fiona (Europe)
(5, 1, 3000.00, '2025-02-01'), -- Ivan (Europe - Top donor for C1 in Europe)
(4, 1, 500.00, '2025-02-15'), -- Hannah (NA)

-- Donations to Campaign 4 (Amazon Reforestation - High value)
(3, 4, 10000.00, '2025-08-05'), -- George (Asia - Top donor for C4 in Asia)
(5, 4, 5000.00, '2025-08-10'), -- Ivan (Europe)
(4, 4, 3000.00, '2025-08-20'), -- Hannah (NA - Contributed to more than one campaign)

-- Donations to Campaign 3 (Renewable Energy)
(4, 3, 500.00, '2024-11-05'), -- Hannah (NA - Contributed to more than one campaign)
(1, 3, 4000.00, '2024-12-01'), -- Ethan (NA)
(2, 3, 300.00, '2025-01-01'); -- Fiona (Europe)