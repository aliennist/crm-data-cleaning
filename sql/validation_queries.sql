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
