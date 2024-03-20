-- Active: 1710700875312@@pg-db@5432@sfcpolice
CREATE TABLE police
(
         pd_id BIGINT,
        IncidentNum VARCHAR(10),
        "Incident Code" VARCHAR(10),
        Category VARCHAR(50),
        Descript VARCHAR(100),
        DayOfWeek VARCHAR(10),
        Date DATE,
        Time TIME,
        PdDistrict VARCHAR(10),
        Resolution VARCHAR(50),
        Address VARCHAR(100),
        X NUMERIC(9, 6),
        Y NUMERIC(9, 6),
        location VARCHAR(55),
        "SF Find Neighborhoods 2 2" FLOAT,
        "Current Police Districts 2 2" INT,
        "Current Supervisor Districts 2 2" INT,
        "Analysis Neighborhoods 2 2" INT,
        "DELETE - Fire Prevention Districts 2 2" INT,
        "DELETE - Police Districts 2 2" INT,
        "DELETE - Supervisor Districts 2 2" INT,
        "DELETE - Zip Codes 2 2" INT,
        "DELETE - Neighborhoods 2 2" INT,
        "DELETE - 2017 Fix It Zones 2 2" INT,
        "Civic Center Harm Reduction Project Boundary 2 2" INT,
        "Fix It Zones as of 2017-11-06 2 2" INT,
        "DELETE - HSOC Zones 2 2" INT,
        "Fix It Zones as of 2018-02-07 2 2" INT,
        "CBD, BID and GBD Boundaries as of 2017 2 2" INT,
        "Areas of Vulnerability, 2016 2 2" INT,
        "Central Market/Tenderloin Boundary 2 2" INT,
        "Central Market/Tenderloin Boundary Polygon - Updated 2 2" INT,
        "HSOC Zones as of 2018-06-05 2 2" INT,
        "OWED Public Spaces 2 2" INT,
        "Neighborhoods 2" INT
);

-- DESCRIBE police ;

SHOW COLUMNS FROM police ;