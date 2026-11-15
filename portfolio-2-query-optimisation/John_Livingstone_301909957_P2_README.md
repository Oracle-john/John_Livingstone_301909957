# Airbnb Reservation System — SQL queries

## 1. Show related reservation, guest, listing records (up to 20).

```sql
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
```

| reservation_reservation_id | reservation_booking_code | guest_guest_id | guest_full_name | listing_listing_id | listing_property_name |
| --- | --- | --- | --- | --- | --- |
| 3001 | BK-TEST-3001 | 1001 | Avery Chen | 2001 | Harbor Cottage |

## 2. Find listing records where property_name matches "Harbor Cottage" (up to 20).

```sql
SELECT * FROM portfolio."listing"
WHERE "property_name" IS NOT DISTINCT FROM 'Harbor Cottage'
ORDER BY "listing_id"
LIMIT 20;
```

| listing_id | property_name | city | nightly_rate | is_active |
| --- | --- | --- | --- | --- |
| 2001 | Harbor Cottage | Portland | 145.5 | true |

## 3. Count reservation records for each guest_id (up to 20 groups).

```sql
SELECT "guest_id", count(*) AS record_count
FROM portfolio."reservation"
GROUP BY "guest_id"
ORDER BY record_count DESC, "guest_id" NULLS LAST
LIMIT 20;
```

| guest_id | record_count |
| --- | --- |
| 1001 | 1 |

## 4. Find reservation records where check_in matches "2026-07-12" (up to 20).

```sql
SELECT * FROM portfolio."reservation"
WHERE "check_in" IS NOT DISTINCT FROM '2026-07-12'
ORDER BY "reservation_id"
LIMIT 20;
```

| reservation_id | booking_code | guest_id | listing_id | check_in | check_out | guest_count | status |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 3001 | BK-TEST-3001 | 1001 | 2001 | 2026-07-12 | 2026-07-16 | 2 | confirmed |


## Index comparison

| Phase | Median (ms) | Three runs (ms) | Plan nodes | Buffer hits |
| --- | --- | --- | --- | --- |
| Before index | 2.303 | 2.303, 2.437, 2.295 | Sort → Seq Scan | 274 |
| After index | 0.294 | 0.43, 0.294, 0.284 | Sort → Bitmap Heap Scan → Bitmap Index Scan | 55 |

The median execution time changed from 2.303 ms to 0.294 ms. The measured plan used p2_filter_idx. The results matched in both phases. An index adds storage and write-maintenance costs; timings depend on the selected lookup and environment.

## Execution plans

### Before index, run 1

```text
Sort (actual time=2.271..2.274 rows=50 loops=1)
  Seq Scan on reservation (actual time=0.017..2.229 rows=50 loops=1)
Planning Time: 0.311 ms
Execution Time: 2.303 ms
```

### Before index, run 2

```text
Sort (actual time=2.404..2.407 rows=50 loops=1)
  Seq Scan on reservation (actual time=0.018..2.362 rows=50 loops=1)
Planning Time: 0.328 ms
Execution Time: 2.437 ms
```

### Before index, run 3

```text
Sort (actual time=2.264..2.266 rows=50 loops=1)
  Seq Scan on reservation (actual time=0.018..2.223 rows=50 loops=1)
Planning Time: 0.333 ms
Execution Time: 2.295 ms
```

### After index, run 1

```text
Sort (actual time=0.327..0.33 rows=50 loops=1)
  Bitmap Heap Scan on reservation (actual time=0.043..0.266 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.018..0.018 rows=50 loops=1)
Planning Time: 0.792 ms
Execution Time: 0.43 ms
```

### After index, run 2

```text
Sort (actual time=0.234..0.237 rows=50 loops=1)
  Bitmap Heap Scan on reservation (actual time=0.033..0.194 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.013..0.014 rows=50 loops=1)
Planning Time: 0.633 ms
Execution Time: 0.294 ms
```

### After index, run 3

```text
Sort (actual time=0.228..0.231 rows=50 loops=1)
  Bitmap Heap Scan on reservation (actual time=0.031..0.19 rows=50 loops=1)
    Bitmap Index Scan using p2_filter_idx (actual time=0.012..0.013 rows=50 loops=1)
Planning Time: 0.506 ms
Execution Time: 0.284 ms
```

## Reproduce

Use a fresh database with the Portfolio 1 schema and sample data. Run John_Livingstone_301909957_P2_Queries.sql, then John_Livingstone_301909957_P2_Optimisation.sql. The optimisation script creates a separate performance table and runs EXPLAIN (ANALYZE, BUFFERS).

[Query screenshot](screenshots/John_Livingstone_301909957_P2_QueryResults.png) · [Index comparison](screenshots/John_Livingstone_301909957_P2_IndexComparison.png)

## References

- [PostgreSQL — EXPLAIN](https://www.postgresql.org/docs/17/using-explain.html)

