-- Query to run a specific query to run n number of times
-- Used for performance testing of a query and comparison within different queries


CREATE OR REPLACE PROCEDURE perfDemoProc(query_text TEXT, n_times INT)
LANGUAGE plpgsql
AS $$
DECLARE
    start_time TIMESTAMP;
    end_time TIMESTAMP;
    i INT := 0;
BEGIN
    start_time := clock_timestamp();

    FOR i IN 1..n_times LOOP
        EXECUTE query_text;
    END LOOP;

    end_time := clock_timestamp();
    RAISE NOTICE 'Total time taken: % seconds', EXTRACT(EPOCH FROM end_time - start_time);
END;
$$;



-- Call procedure
CALL perfDemoProc(
	'SELECT c.customer_id, COUNT(*) AS customer_order_count
	FROM customers AS c
	LEFT JOIN orders AS o
	ON c.customer_id = o.order_customer_id
	GROUP BY customer_id;'
, 500);
