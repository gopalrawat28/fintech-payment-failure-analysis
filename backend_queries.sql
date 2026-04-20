-- -----------------------------------------------------------------------------
-- Payment Failure Intelligence System - SQL Extraction Queries
-- -----------------------------------------------------------------------------

-- 1. Overall Success Rate Validation
SELECT 
    ROUND((COUNT(CASE WHEN status = 'success' THEN 1 END) * 100.0) / COUNT(*), 2) AS success_rate_percentage
FROM transactions;

-- 2. Finding the Bottleneck (Failures by Bank)
SELECT 
    bank, 
    COUNT(*) AS total_failures
FROM transactions
WHERE status = 'failed'
GROUP BY bank
ORDER BY total_failures DESC;

-- 3. The Business Impact (Revenue Loss Calculation)
SELECT 
    SUM(amount) AS total_revenue_lost
FROM transactions
WHERE status = 'failed';

-- 4. Peak Failure Hours (Server Load Analysis)
SELECT 
    HOUR(timestamp) AS time_of_day,
    COUNT(*) AS total_failures
FROM transactions
WHERE status = 'failed'
GROUP BY HOUR(timestamp)
ORDER BY total_failures DESC
LIMIT 5;
