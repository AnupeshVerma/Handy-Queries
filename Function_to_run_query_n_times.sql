CREATE OR REPLACE FUNCTION perfDemoFunc(query_text TEXT, n_times INT)
RETURNS VOID AS $$
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
$$ LANGUAGE plpgsql;
