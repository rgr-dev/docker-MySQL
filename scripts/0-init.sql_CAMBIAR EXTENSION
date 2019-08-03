CREATE DATABASE IF NOT EXISTS PRICESURFER_CORE_DEV;
CREATE USER 'developer'@'%' IDENTIFIED BY 'nemonemo';
GRANT ALL ON *.* TO 'developer'@'%' IDENTIFIED BY 'nemonemo';
CREATE FUNCTION levenshtein RETURNS INTEGER SONAME "libnemo-levenshtein.so";
CREATE FUNCTION FormatLev RETURNS STRING SONAME "libnemo-formatlevenshtein.so";
CREATE FUNCTION levenshteinPercent RETURNS INTEGER SONAME "libnemo-levenshtein.so";