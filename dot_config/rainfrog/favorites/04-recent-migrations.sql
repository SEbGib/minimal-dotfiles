-- Show Doctrine migrations history (Symfony projects)
SELECT
    version,
    executed_at,
    execution_time
FROM doctrine_migration_versions
ORDER BY executed_at DESC
LIMIT 20;
