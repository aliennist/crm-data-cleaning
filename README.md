# CRM Data Cleaning & Validation

## Overview
This project demonstrates how I clean, validate, and prepare CRM lead data for downstream sales and operations use.

## Problem
Incoming CRM data often contains:
- Missing required fields
- Duplicate leads
- Invalid values (email, phone)

## Data
- Source: Simulated CRM export
- Format: CSV
- Records: 5,000+
- Note: This dataset is a simulated CRM export created for portfolio demonstration purposes. Data quality issues were intentionally introduced to reflect real-world operational scenarios.

## Approach
- Defined data quality rules
- Used SQL to identify duplicates and invalid records
- Standardized fields for reporting readiness
- Used SQL-based validation checks to assess data completeness, format correctness, and duplication risk prior to CRM ingestion.
- Enforced controlled lead_source values to ensure consistent attribution and reporting accuracy

## Output
- Cleaned dataset
- SQL queries for validation
- Documented data quality rules
- Generated a cleaned CRM dataset by enforcing required-field rules, validating email formats, standardizing text fields, and removing duplicate records.
- Reduced raw dataset from 5,000 records to 3762 validated, ingestion-ready leads.

## Tools Used
- SQL
- Excel / Google Sheets
