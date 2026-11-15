-- Run these deliberately invalid statements one at a time, outside a transaction.
-- Each should fail at the named constraint; the sample rows should remain unchanged.

-- 1. reject guest primary key. Expected: pk_guest, SQLSTATE 23505.
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "created_at")
VALUES (1001, 'Jordan Park', 'jordan.park@example.test', '2026-02-01T10:00:00Z');

-- 2. reject guest unique email. Expected: uq_guest_0, SQLSTATE 23505.
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "created_at")
VALUES (9101, 'Morgan Lee', 'avery.chen@example.test', '2026-02-02T10:00:00Z');

-- 3. reject guest id not null. Expected: guest_id, SQLSTATE 23502.
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "created_at")
VALUES (NULL, 'Casey Rivera', 'casey.rivera@example.test', '2026-02-03T10:00:00Z');

-- 4. reject guest full name not null. Expected: full_name, SQLSTATE 23502.
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "created_at")
VALUES (9102, NULL, 'guest9102@example.test', '2026-02-04T10:00:00Z');

-- 5. reject guest email not null. Expected: email, SQLSTATE 23502.
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "created_at")
VALUES (9103, 'Taylor Quinn', NULL, '2026-02-05T10:00:00Z');

-- 6. reject guest created at not null. Expected: created_at, SQLSTATE 23502.
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "created_at")
VALUES (9104, 'Riley Morgan', 'riley.morgan@example.test', NULL);

-- 7. reject listing primary key. Expected: pk_listing, SQLSTATE 23505.
INSERT INTO portfolio."listing" ("listing_id", "property_name", "city", "nightly_rate", "is_active")
VALUES (2001, 'Pine Loft', 'Bend', 120, TRUE);

-- 8. reject listing id not null. Expected: listing_id, SQLSTATE 23502.
INSERT INTO portfolio."listing" ("listing_id", "property_name", "city", "nightly_rate", "is_active")
VALUES (NULL, 'Cedar House', 'Salem', 110, TRUE);

-- 9. reject listing property name not null. Expected: property_name, SQLSTATE 23502.
INSERT INTO portfolio."listing" ("listing_id", "property_name", "city", "nightly_rate", "is_active")
VALUES (9201, NULL, 'Salem', 110, TRUE);

-- 10. reject listing city not null. Expected: city, SQLSTATE 23502.
INSERT INTO portfolio."listing" ("listing_id", "property_name", "city", "nightly_rate", "is_active")
VALUES (9202, 'Maple Studio', NULL, 110, TRUE);

-- 11. reject listing nightly rate not null. Expected: nightly_rate, SQLSTATE 23502.
INSERT INTO portfolio."listing" ("listing_id", "property_name", "city", "nightly_rate", "is_active")
VALUES (9203, 'Maple Studio', 'Salem', NULL, TRUE);

-- 12. reject listing is active not null. Expected: is_active, SQLSTATE 23502.
INSERT INTO portfolio."listing" ("listing_id", "property_name", "city", "nightly_rate", "is_active")
VALUES (9204, 'Maple Studio', 'Salem', 110, NULL);

-- 13. reject reservation primary key. Expected: pk_reservation, SQLSTATE 23505.
INSERT INTO portfolio."reservation" ("reservation_id", "booking_code", "guest_id", "listing_id", "check_in", "check_out", "guest_count", "status")
VALUES (3001, 'BK-TEST-9301', 1001, 2001, '2026-08-01', '2026-08-04', 1, 'confirmed');

-- 14. reject reservation unique booking code. Expected: uq_reservation_0, SQLSTATE 23505.
INSERT INTO portfolio."reservation" ("reservation_id", "booking_code", "guest_id", "listing_id", "check_in", "check_out", "guest_count", "status")
VALUES (9301, 'BK-TEST-3001', 1001, 2001, '2026-08-05', '2026-08-08', 1, 'confirmed');

-- 15. reject reservation guest foreign key. Expected: fk_reservation_0, SQLSTATE 23503.
INSERT INTO portfolio."reservation" ("reservation_id", "booking_code", "guest_id", "listing_id", "check_in", "check_out", "guest_count", "status")
VALUES (9302, 'BK-TEST-9302', 9901, 2001, '2026-08-09', '2026-08-12', 1, 'confirmed');

-- 16. reject reservation listing foreign key. Expected: fk_reservation_1, SQLSTATE 23503.
INSERT INTO portfolio."reservation" ("reservation_id", "booking_code", "guest_id", "listing_id", "check_in", "check_out", "guest_count", "status")
VALUES (9303, 'BK-TEST-9303', 1001, 9902, '2026-08-13', '2026-08-16', 1, 'confirmed');

-- 17. reject reservation id not null. Expected: reservation_id, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "booking_code", "guest_id", "listing_id", "check_in", "check_out", "guest_count", "status")
VALUES (NULL, 'BK-TEST-9304', 1001, 2001, '2026-08-17', '2026-08-20', 1, 'confirmed');

-- 18. reject reservation booking code not null. Expected: booking_code, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "booking_code", "guest_id", "listing_id", "check_in", "check_out", "guest_count", "status")
VALUES (9305, NULL, 1001, 2001, '2026-08-21', '2026-08-24', 1, 'confirmed');

-- 19. reject reservation guest id not null. Expected: guest_id, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "booking_code", "guest_id", "listing_id", "check_in", "check_out", "guest_count", "status")
VALUES (9306, 'BK-TEST-9306', NULL, 2001, '2026-08-25', '2026-08-28', 1, 'confirmed');

-- 20. reject reservation listing id not null. Expected: listing_id, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "booking_code", "guest_id", "listing_id", "check_in", "check_out", "guest_count", "status")
VALUES (9307, 'BK-TEST-9307', 1001, NULL, '2026-08-29', '2026-09-01', 1, 'confirmed');

-- 21. reject reservation check in not null. Expected: check_in, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "booking_code", "guest_id", "listing_id", "check_in", "check_out", "guest_count", "status")
VALUES (9308, 'BK-TEST-9308', 1001, 2001, NULL, '2026-09-04', 1, 'confirmed');

-- 22. reject reservation check out not null. Expected: check_out, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "booking_code", "guest_id", "listing_id", "check_in", "check_out", "guest_count", "status")
VALUES (9309, 'BK-TEST-9309', 1001, 2001, '2026-09-05', NULL, 1, 'confirmed');

-- 23. reject reservation guest count not null. Expected: guest_count, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "booking_code", "guest_id", "listing_id", "check_in", "check_out", "guest_count", "status")
VALUES (9310, 'BK-TEST-9310', 1001, 2001, '2026-09-09', '2026-09-12', NULL, 'confirmed');

-- 24. reject reservation status not null. Expected: status, SQLSTATE 23502.
INSERT INTO portfolio."reservation" ("reservation_id", "booking_code", "guest_id", "listing_id", "check_in", "check_out", "guest_count", "status")
VALUES (9311, 'BK-TEST-9311', 1001, 2001, '2026-09-13', '2026-09-16', 1, NULL);

-- 25. reject reservation stay dates. Expected: valid_stay_dates, SQLSTATE 23514.
INSERT INTO portfolio."reservation" ("reservation_id", "booking_code", "guest_id", "listing_id", "check_in", "check_out", "guest_count", "status")
VALUES (9312, 'BK-TEST-9312', 1001, 2001, '2026-09-20', '2026-09-19', 1, 'confirmed');

-- 26. reject reservation guest count. Expected: positive_guest_count, SQLSTATE 23514.
INSERT INTO portfolio."reservation" ("reservation_id", "booking_code", "guest_id", "listing_id", "check_in", "check_out", "guest_count", "status")
VALUES (9313, 'BK-TEST-9313', 1001, 2001, '2026-09-21', '2026-09-24', 0, 'confirmed');

-- 27. reject reservation status. Expected: valid_reservation_status, SQLSTATE 23514.
INSERT INTO portfolio."reservation" ("reservation_id", "booking_code", "guest_id", "listing_id", "check_in", "check_out", "guest_count", "status")
VALUES (9314, 'BK-TEST-9314', 1001, 2001, '2026-09-25', '2026-09-28', 1, 'pending');
