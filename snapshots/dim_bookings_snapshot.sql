{% snapshot dim_bookings %}

{{
    config(
      target_database='AIRBNB',
      target_schema='gold',
      unique_key='BOOKING_ID',
      strategy='timestamp',
      updated_at='CREATED_AT',
      dbt_valid_to_current="to_date('9999-12-31')"
    )
}}

-- The logic from your ephemeral model goes here:
SELECT
    BOOKING_ID,
    BOOKING_DATE,
    BOOKING_STATUS,
    CREATED_AT
FROM {{ ref('obt') }}

{% endsnapshot %}