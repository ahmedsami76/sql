# get the data from the below link
# https://data.sfgov.org/Public-Safety/Police-Department-Incident-Reports-Historical-2003/tmnf-yvry/data

CREATE TABLE police_incident_reports (
  incident_num VARCHAR(10) PRIMARY KEY,
  category VARCHAR(50),
  descript VARCHAR(100),
  dayofweek VARCHAR(10),
  date DATE,
  time TIME,
  pd_district VARCHAR(10),
  resolution VARCHAR(50),
  address VARCHAR(100),
  x NUMERIC(9,6),
  y NUMERIC(9,6),
  location POINT,
  pd_id BIGINT
);
