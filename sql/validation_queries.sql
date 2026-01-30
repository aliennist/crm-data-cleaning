/* =========================================
   CRM DATA QUALITY VALIDATION QUERIES
   ========================================= */

/* 1. Check total records */
SELECT COUNT(*) AS total_leads
FROM raw_leads;

/* 2. Missing required fields */
SELECT
    COUNT(*) AS missing_required_fields
FROM raw_leads
WHERE email IS NULL
   OR email = ''
   OR company IS NULL
   OR company = '';

/* 3. Invalid email format */
SELECT
    COUNT(*) AS invalid_emails
FROM raw_leads
WHERE email NOT LIKE '%@%';

/* 4. Duplicate email addresses */
SELECT
    email,
    COUNT(*) AS occurrences
FROM raw_leads
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;

/* 5. Leads missing phone number */
SELECT
    COUNT(*) AS missing_phone
FROM raw_leads
WHERE phone IS NULL
   OR phone = '';

/* 6. Leads by source (distribution check) */
SELECT
    lead_source,
    COUNT(*) AS lead_count
FROM raw_leads
GROUP BY lead_source
ORDER BY lead_count DESC;

/* 7. Recently created leads (last 30 days) */
SELECT
    *
FROM raw_leads
WHERE created_date >= CURRENT_DATE - INTERVAL '30 days';

/* =========================================
   DATA CLEANING LOGIC
   ========================================= */

/* Create a cleaned dataset */
SELECT
    lead_id,
    LOWER(TRIM(email)) AS email,
    TRIM(first_name) AS first_name,
    TRIM(last_name) AS last_name,
    TRIM(company) AS company,
    job_title,
    INITCAP(industry) AS industry,
    lead_source,
    created_date,
    country,
    employee_count,
    phone
FROM raw_leads
WHERE email IS NOT NULL
  AND email <> ''
  AND email LIKE '%@%'
  AND company IS NOT NULL
  AND company <> ''
  AND lead_source IN (
      'Website',
      'Facebook Ads',
      'Google Ads',
      'Referral',
      'Email Campaign',
      'Event'
  );

/* Deduplicate by email, keeping most recent record */
WITH ranked_leads AS (
    SELECT
        *,
        ROW_NUMBER() OVER (
            PARTITION BY email
            ORDER BY created_date DESC
        ) AS row_num
    FROM cleaned_leads
)
SELECT *
FROM ranked_leads
WHERE row_num = 1;
