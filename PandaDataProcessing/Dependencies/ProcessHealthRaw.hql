ADD JAR wasb:///lib/csv-serde-0.9.1.jar;

DROP TABLE HealthObservations;

CREATE EXTERNAL TABLE HealthObservations (DateTreated string, TimeTreated string, Tag string, Symptom string, Treatment string, Amount string, Comment string)
row format serde 'com.bizo.hive.serde.csv.CSVSerde'
with serdeproperties (
   "separatorChar" = ",",
   "quoteChar"     = "\""
  )	  
STORED AS TEXTFILE LOCATION 'wasb:///raw/health/';

DROP TABLE HealthProcessed;

CREATE TABLE HealthProcessed (StudyID string, DateTreated string, TimeTreated string, Tag string, Treatment string, Amount string, Comment string)
ROW FORMAT DELIMITED FIELDS TERMINATED BY ',' LINES TERMINATED BY '10' STORED AS TEXTFILE LOCATION 'wasb:///processed/health/';

INSERT OVERWRITE TABLE HealthProcessed
SELECT SUBSTR(INPUT__FILE__NAME, LENGTH(INPUT__FILE__NAME) - 11, 5) AS StudyID, DateTreated, TimeTreated, Tag, Treatment, Amount, Comment
FROM HealthObservations
WHERE DateTreated <> ""
GROUP BY INPUT__FILE__NAME, DateTreated, TimeTreated, Tag, Treatment, Amount, Comment;