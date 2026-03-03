{% snapshot dim_listings %}

{{
    config(
      target_database='AIRBNB',
      target_schema='gold',
      unique_key='LISTING_ID',
      strategy='timestamp',
      updated_at='LISTING_CREATED_AT',
      dbt_valid_to_current="to_date('9999-12-31')"
    )
}}

-- The logic from ephemeral model goes here:
SELECT
    LISTING_ID,
    PROPERTY_TYPE,
    ROOM_TYPE,
    CITY,
    COUNTRY,
    PRICE_PER_NIGHT_TAG,
    LISTING_CREATED_AT
FROM {{ ref('obt') }}

{% endsnapshot %}