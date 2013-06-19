-- Verify flips

BEGIN;

-- XXX Add verifications here.
SELECT id, nickname, body, timestamp
    FROM flips
	WHERE 0;

ROLLBACK;
