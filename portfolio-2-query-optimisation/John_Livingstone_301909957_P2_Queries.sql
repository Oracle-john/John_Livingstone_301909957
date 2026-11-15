-- Show related reservation, guest, listing records (up to 20).
SELECT t0."reservation_id" AS "reservation_reservation_id",
       t0."booking_code" AS "reservation_booking_code",
       t1."guest_id" AS "guest_guest_id",
       t1."full_name" AS "guest_full_name",
       t2."listing_id" AS "listing_listing_id",
       t2."property_name" AS "listing_property_name"
FROM portfolio."reservation" t0
JOIN portfolio."guest" t1 ON t0."guest_id" = t1."guest_id"
JOIN portfolio."listing" t2 ON t0."listing_id" = t2."listing_id"
ORDER BY t0."reservation_id", t1."guest_id", t2."listing_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT t0."reservation_id" AS "reservation_reservation_id",
       t0."booking_code" AS "reservation_booking_code",
       t1."guest_id" AS "guest_guest_id",
       t1."full_name" AS "guest_full_name",
       t2."listing_id" AS "listing_listing_id",
       t2."property_name" AS "listing_property_name"
FROM portfolio."reservation" t0
JOIN portfolio."guest" t1 ON t0."guest_id" = t1."guest_id"
JOIN portfolio."listing" t2 ON t0."listing_id" = t2."listing_id"
ORDER BY t0."reservation_id", t1."guest_id", t2."listing_id"
LIMIT 20;

-- Find listing records where property_name matches "Harbor Cottage" (up to 20).
SELECT * FROM portfolio."listing"
WHERE "property_name" IS NOT DISTINCT FROM 'Harbor Cottage'
ORDER BY "listing_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."listing"
WHERE "property_name" IS NOT DISTINCT FROM 'Harbor Cottage'
ORDER BY "listing_id"
LIMIT 20;

-- Count reservation records for each guest_id (up to 20 groups).
SELECT "guest_id", count(*) AS record_count
FROM portfolio."reservation"
GROUP BY "guest_id"
ORDER BY record_count DESC, "guest_id" NULLS LAST
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT "guest_id", count(*) AS record_count
FROM portfolio."reservation"
GROUP BY "guest_id"
ORDER BY record_count DESC, "guest_id" NULLS LAST
LIMIT 20;

-- Find reservation records where check_in matches "2026-07-12" (up to 20).
SELECT * FROM portfolio."reservation"
WHERE "check_in" IS NOT DISTINCT FROM '2026-07-12'
ORDER BY "reservation_id"
LIMIT 20;

EXPLAIN (ANALYZE, BUFFERS, FORMAT JSON)
SELECT * FROM portfolio."reservation"
WHERE "check_in" IS NOT DISTINCT FROM '2026-07-12'
ORDER BY "reservation_id"
LIMIT 20;
