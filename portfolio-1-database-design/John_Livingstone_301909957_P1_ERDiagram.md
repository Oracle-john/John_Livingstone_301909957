# Airbnb Reservation System — ER diagram

```mermaid
erDiagram
    direction LR
    guest {
        bigint guest_id PK
        text full_name
        text email UK
        timestamptz created_at
    }
    listing {
        bigint listing_id PK
        text property_name
        text city
        numeric nightly_rate
        boolean is_active
    }
    reservation {
        bigint reservation_id PK
        text booking_code UK
        bigint guest_id FK
        bigint listing_id FK
        date check_in
        date check_out
        integer guest_count
        text status
    }
    guest ||--o{ reservation : "guest_id"
    listing ||--o{ reservation : "listing_id"
```

PK identifies a record; FK links to another table; UK marks a single-field unique value. The relationship ends show exactly one, zero or one, or zero or many records. Composite unique keys and conditional rules are listed in the schema and design.

[Diagram image](../images/John_Livingstone_301909957_ERDiagram.png)
