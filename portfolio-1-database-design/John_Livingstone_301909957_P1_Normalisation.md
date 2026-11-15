# Airbnb Reservation System — normalisation

The example uses the saved sample records. The full set of fields is in the design and schema.

## Starting grouped records

| guest_id | reservation records (list) |
| --- | --- |
| 1001 | [3001] |


The record IDs are grouped in a list. In 1NF, each record has its own row and each cell holds one value.

## 1NF: one value per cell

| reservation.reservation_id | reservation.booking_code | reservation.guest_id | reservation.listing_id | guest.guest_id | guest.full_name | listing.listing_id | listing.property_name |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 3001 | BK-TEST-3001 | 1001 | 2001 | 1001 | Avery Chen | 2001 | Harbor Cottage |

Key: reservation_id.

## 2NF: depend on the whole key

The declared candidate keys do not introduce a partial dependency here, so the 1NF rows stay unchanged at this step.

## reservation_example

| reservation.reservation_id | reservation.booking_code | reservation.guest_id | reservation.listing_id | guest.guest_id | guest.full_name | listing.listing_id | listing.property_name |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 3001 | BK-TEST-3001 | 1001 | 2001 | 1001 | Avery Chen | 2001 | Harbor Cottage |

## 3NF: store each entity’s details once

The entity keys determine their own descriptions. Related records keep foreign keys rather than repeating those descriptions.

## guest

| guest_id | full_name | email | created_at |
| --- | --- | --- | --- |
| 1001 | Avery Chen | avery.chen@example.test | 2026-01-10T09:30:00+00:00 |

## listing

| listing_id | property_name | city | nightly_rate | is_active |
| --- | --- | --- | --- | --- |
| 2001 | Harbor Cottage | Portland | 145.5 | true |

## reservation

| reservation_id | booking_code | guest_id | listing_id | check_in | check_out | guest_count | status |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 3001 | BK-TEST-3001 | 1001 | 2001 | 2026-07-12 | 2026-07-16 | 2 | confirmed |

## Dependencies

- guest: (guest_id) → full_name, email, created_at
- listing: (listing_id) → property_name, city, nightly_rate, is_active
- reservation: (reservation_id) → booking_code, guest_id, listing_id, check_in, check_out, guest_count, status

Joining the decomposed sample tables reproduces the original 1 example rows. The design assumes the declared keys describe the relevant business dependencies.
