-- PART C SQL QUERIES


-- 1. Top 5 donors by donation amount for a specific campaign for each region.

WITH RankedDonors AS (
    SELECT
        D.DonorID,
        D.FirstName,
        D.LastName,
        D.Region AS DonorRegion,
        C.CampaignName,
        DN.DonationAmount,
        ROW_NUMBER() OVER (PARTITION BY D.Region, C.CampaignID ORDER BY DN.DonationAmount DESC) as rn
    FROM
        DONATION DN
    JOIN
        DONOR D ON DN.DonorID = D.DonorID
    JOIN
        CAMPAIGN C ON DN.CampaignID = C.CampaignID
    WHERE
        C.CampaignID = 1 -- Filter for a specific campaign (e.g., CampaignID 1)
)
SELECT
    FirstName,
    LastName,
    DonorRegion,
    CampaignName,
    DonationAmount
FROM
    RankedDonors
WHERE
    rn <= 5
ORDER BY
    DonorRegion, DonationAmount DESC;

-- 2. Number of campaigns each volunteer has participated in.
SELECT
    V.VolunteerID,
    V.FirstName,
    V.LastName,
    COUNT(VA.CampaignID) AS NumberOfCampaigns
FROM
    VOLUNTEER V
LEFT JOIN
    VOLUNTEER_ACTIVITY VA ON V.VolunteerID = VA.VolunteerID
GROUP BY
    V.VolunteerID, V.FirstName, V.LastName
ORDER BY
    NumberOfCampaigns DESC;
    
-- 3. List of campaigns that are still accepting donations, focusing on wildlife or water quality.
SELECT
    C.CampaignName,
    C.EndDate,
    GROUP_CONCAT(ER.ResourceName) AS FocusResources
FROM
    CAMPAIGN C
JOIN
    CAMPAIGN_FOCUS CF ON C.CampaignID = CF.CampaignID
JOIN
    ENVIRONMENTAL_RESOURCE ER ON CF.ResourceID = ER.ResourceID
WHERE
    C.EndDate >= CURDATE() -- Still accepting donations
    AND ER.ResourceName IN ('Wildlife', 'Water Quality') -- Focusing on specified resources
GROUP BY
    C.CampaignID, C.CampaignName, C.EndDate
ORDER BY
    C.EndDate ASC;

-- 4. Donors who contributed to more than one campaign.
SELECT
    D.DonorID,
    D.FirstName,
    D.LastName,
    COUNT(DISTINCT DN.CampaignID) AS CampaignsContributedTo
FROM
    DONOR D
JOIN
    DONATION DN ON D.DonorID = DN.DonorID
GROUP BY
    D.DonorID, D.FirstName, D.LastName
HAVING
    COUNT(DISTINCT DN.CampaignID) > 1
ORDER BY
    CampaignsContributedTo DESC;

-- 5. Average donation amount per donor across all campaigns.
SELECT
    AVG(TotalDonated) AS AverageDonationPerDonor
FROM
    (
        SELECT
            SUM(DonationAmount) AS TotalDonated
        FROM
            DONATION
        GROUP BY
            DonorID
    ) AS DonorTotal;

-- 6. Number of campaigns affected by each climate impact.
SELECT
    CI.ImpactName,
    COUNT(DISTINCT CF.CampaignID) AS NumberOfCampaignsAffected
FROM
    CLIMATE_IMPACT CI
JOIN
    RESOURCE_IMPACT RI ON CI.ImpactID = RI.ImpactID
JOIN
    CAMPAIGN_FOCUS CF ON RI.ResourceID = CF.ResourceID
GROUP BY
    CI.ImpactID, CI.ImpactName
ORDER BY
    NumberOfCampaignsAffected DESC;

-- 7. Volunteers involved in campaigns that raised more than $5000.
SELECT DISTINCT
    V.VolunteerID,
    V.FirstName,
    V.LastName,
    C.CampaignName
FROM
    VOLUNTEER V
JOIN
    VOLUNTEER_ACTIVITY VA ON V.VolunteerID = VA.VolunteerID
JOIN
    CAMPAIGN C ON VA.CampaignID = C.CampaignID
WHERE
    C.AmountRaised > 5000.00
ORDER BY
    V.LastName, V.FirstName;

-- 8. Campaigns that haven’t met fundraising goals and have fewer than 10 days left.
SELECT
    CampaignName,
    FundraisingGoal,
    AmountRaised,
    EndDate,
    DATEDIFF(EndDate, CURDATE()) AS DaysLeft
FROM
    CAMPAIGN
WHERE
    AmountRaised < FundraisingGoal
    AND EndDate >= CURDATE() -- Ensure campaign is not already over
    AND DATEDIFF(EndDate, CURDATE()) < 10 -- Less than 10 days left
ORDER BY
    DaysLeft ASC;

-- 9. Top 10 resources that have the greatest impact on climate change, based on the number of campaigns they have been associated with.
SELECT
    ER.ResourceName,
    COUNT(CF.CampaignID) AS AssociatedCampaigns
FROM
    ENVIRONMENTAL_RESOURCE ER
JOIN
    CAMPAIGN_FOCUS CF ON ER.ResourceID = CF.ResourceID
GROUP BY
    ER.ResourceID, ER.ResourceName
ORDER BY
    AssociatedCampaigns DESC
LIMIT 10;

-- 10. Top 3 campaigns with the highest amount raised, along with the number of volunteers and donors who contributed to each campaign. Include the campaign name, amount raised, total number of volunteers, and total number of donors in the result. Only
SELECT
    C.CampaignName,
    C.AmountRaised,
    COUNT(DISTINCT VA.VolunteerID) AS TotalVolunteers,
    COUNT(DISTINCT DN.DonorID) AS TotalDonors
FROM
    CAMPAIGN C
LEFT JOIN
    VOLUNTEER_ACTIVITY VA ON C.CampaignID = VA.CampaignID
LEFT JOIN
    DONATION DN ON C.CampaignID = DN.CampaignID
GROUP BY
    C.CampaignID, C.CampaignName, C.AmountRaised
HAVING
    TotalVolunteers > 0 AND TotalDonors > 0 -- Only include campaigns that have both volunteers and donors
ORDER BY
    TotalVolunteers DESC, C.AmountRaised DESC -- Sort by total volunteers descending
LIMIT 3;
 