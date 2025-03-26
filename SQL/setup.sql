
CREATE DATABASE bookstore;

USE bookstore;

set sql_safe_updates = 0;

-- run this if error 1419 occures while running triggers.sql (run with root user)
set global log_bin_trust_function_creators = 1;
