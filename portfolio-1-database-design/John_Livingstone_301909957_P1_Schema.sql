-- Airbnb Reservation System: tables, keys and business constraints.
-- Run once in a fresh PostgreSQL database.
BEGIN;
SET LOCAL standard_conforming_strings = on;
CREATE SCHEMA portfolio;
CREATE TABLE portfolio."guest" (
  "guest_id" bigint NOT NULL,
  "full_name" text NOT NULL,
  "email" text NOT NULL,
  "created_at" timestamptz NOT NULL,
  CONSTRAINT "pk_guest" PRIMARY KEY ("guest_id"),
  CONSTRAINT "uq_guest_0" UNIQUE ("email")
);
CREATE TABLE portfolio."listing" (
  "listing_id" bigint NOT NULL,
  "property_name" text NOT NULL,
  "city" text NOT NULL,
  "nightly_rate" numeric(18,2) NOT NULL,
  "is_active" boolean NOT NULL,
  CONSTRAINT "pk_listing" PRIMARY KEY ("listing_id")
);
CREATE TABLE portfolio."reservation" (
  "reservation_id" bigint NOT NULL,
  "booking_code" text NOT NULL,
  "guest_id" bigint NOT NULL,
  "listing_id" bigint NOT NULL,
  "check_in" date NOT NULL,
  "check_out" date NOT NULL,
  "guest_count" bigint NOT NULL,
  "status" text NOT NULL,
  CONSTRAINT "pk_reservation" PRIMARY KEY ("reservation_id"),
  CONSTRAINT "uq_reservation_0" UNIQUE ("booking_code")
);
ALTER TABLE portfolio."reservation" ADD CONSTRAINT "fk_reservation_0" FOREIGN KEY ("guest_id") REFERENCES portfolio."guest" ("guest_id");
ALTER TABLE portfolio."reservation" ADD CONSTRAINT "fk_reservation_1" FOREIGN KEY ("listing_id") REFERENCES portfolio."listing" ("listing_id");
ALTER TABLE portfolio."reservation" ADD CONSTRAINT "valid_stay_dates" CHECK ("check_out" > "check_in");
ALTER TABLE portfolio."reservation" ADD CONSTRAINT "positive_guest_count" CHECK ("guest_count" > 0);
ALTER TABLE portfolio."reservation" ADD CONSTRAINT "valid_reservation_status" CHECK (("status" = 'confirmed') OR ("status" = 'cancelled'));
COMMIT;
