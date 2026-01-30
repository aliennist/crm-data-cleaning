# CRM Data Quality Rules

## Purpose
This document defines the minimum data quality standards required for CRM lead records to be considered ingestion-ready for sales and operations workflows.

The rules below are aligned with common CRM and Salesforce data governance practices.

---

## Required Fields
The following fields must be populated for all lead records:

| Field Name   | Requirement               |
|--------------|---------------------------|
| email        | Must not be NULL or empty |
| company      | Must not be NULL or empty |
| lead_source  | Must not be NULL          |
| created_date | Must be a valid date      |

---

## Format Validation Rules

### Email Address
- Must contain the `@` symbol
- Must not contain spaces
- Must be unique across lead records

### Phone Number
- Optional field
- If populated, must contain at least 7 numeric characters

---

## Duplication Rules

| Rule              | Description                           |
|-------------------|---------------------------------------|
| Duplicate Email   | Email address must be unique per lead |
| Duplicate Company | Allowed, but flagged for review       |

Duplicate detection is handled using SQL-based grouping logic prior to CRM ingestion.

---

## Standardization Rules

|    Field    | Standard                     |
|-------------|------------------------------|
| industry    | Title Case                   |
| country     | Standardized country names   |
| lead_source | Must match predefined values |

Accepted lead_source values:
- Website
- Facebook Ads
- Google Ads
- Referral
- Email Campaign
- Event

---

## Handling Invalid Records 

| Issue                   | Action                    |
|-------------------------|---------------------------|
| Missing required fields | Exclude from ingestion    |
| Invalid email format    | Flag for correction       |
| Duplicate email         | Retain most recent record |

---

## Ownership & Review
- Data Quality Owner: Data Operations
- Review Frequency: Weekly
