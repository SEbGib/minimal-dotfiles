-- Database statistics and overview
SELECT
    current_database() AS database_name,
    pg_size_pretty(pg_database_size(current_database())) AS database_size,
    (SELECT count(*) FROM pg_stat_user_tables) AS table_count,
    (SELECT count(*) FROM pg_stat_user_indexes) AS index_count,
    version() AS postgres_version;
