# Airbnb Reservation System — database design

My case study records guest, listing, reservation.

## Users

- Travelers searching for listings and making reservations
- Hosts managing listings
- Booking support staff reviewing reservations

## Main operations

- Search active listings by city and requested dates
- Create or cancel a reservation
- Review reservation details and booking totals by listing

## Entities

| Entity | Information stored |
| --- | --- |
| guest | Traveler identity and contact information. |
| listing | A rental property available for reservations. |
| reservation | A guest's dated booking of a listing. |

## guest

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| guest_id | BIGINT | PK | Yes |
| full_name | TEXT |  | Yes |
| email | TEXT | Unique | Yes |
| created_at | TIMESTAMPTZ |  | Yes |
- Unique key: (email).

## listing

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| listing_id | BIGINT | PK | Yes |
| property_name | TEXT |  | Yes |
| city | TEXT |  | Yes |
| nightly_rate | NUMERIC(18,2) |  | Yes |
| is_active | BOOLEAN |  | Yes |


## reservation

| Field | Type | Key | Required |
| --- | --- | --- | --- |
| reservation_id | BIGINT | PK | Yes |
| booking_code | TEXT | Unique | Yes |
| guest_id | BIGINT | FK | Yes |
| listing_id | BIGINT | FK | Yes |
| check_in | DATE |  | Yes |
| check_out | DATE |  | Yes |
| guest_count | INTEGER |  | Yes |
| status | TEXT |  | Yes |
- guest_id → guest.guest_id
- listing_id → listing.listing_id
- Unique key: (booking_code).

## Relationships and business rules

- Each guest email identifies at most one guest.
- Each reservation references an existing guest.
- Each reservation references an existing listing.
- A booking code identifies at most one reservation and prevents duplicate booking requests from creating duplicate rows.
- A reservation's check-out date must be later than its check-in date.
- Each reservation must have a guest count greater than zero.
- Reservation status must be confirmed or cancelled.

## Assumptions

- A reservation belongs to exactly one guest and one listing; guests and listings may each have multiple reservations.
- Check-in and check-out are calendar dates, and check-out must be later than check-in.
- A reservation is confirmed or cancelled; availability searches consider confirmed reservations.
- A reservation booking code is a unique idempotency key supplied for each booking request.
- For normalization, reservation facts reference the guest by guest_id; guest name and email remain in guest rather than being repeated in reservation.
- Availability searches identify listings without stored confirmed reservations overlapping the requested date range; the search is not a reservation guarantee.
- All records and benchmark inputs are synthetic.

