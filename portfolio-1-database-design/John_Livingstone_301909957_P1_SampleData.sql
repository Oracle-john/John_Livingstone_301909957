-- Fictional sample records for Airbnb Reservation System.
BEGIN;
SET LOCAL standard_conforming_strings = on;
INSERT INTO portfolio."guest" ("guest_id", "full_name", "email", "created_at") VALUES (1001, 'Avery Chen', 'avery.chen@example.test', '2026-01-10T09:30:00Z');
INSERT INTO portfolio."listing" ("listing_id", "property_name", "city", "nightly_rate", "is_active") VALUES (2001, 'Harbor Cottage', 'Portland', 145.5, TRUE);
INSERT INTO portfolio."reservation" ("reservation_id", "booking_code", "guest_id", "listing_id", "check_in", "check_out", "guest_count", "status") VALUES (3001, 'BK-TEST-3001', 1001, 2001, '2026-07-12', '2026-07-16', 2, 'confirmed');
COMMIT;
