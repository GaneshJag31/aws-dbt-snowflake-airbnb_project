{% snapshot dim_hosts %}

{{
    config(
      target_database='AIRBNB',
      target_schema='gold',
      unique_key='HOST_ID',
      strategy='timestamp',
      updated_at='HOST_CRATED_AT',
      dbt_valid_to_current="to_date('9999-12-31')"
    )
}}

-- The logic from ephemeral model goes here:
SELECT
    HOST_ID,
    HOST_NAME,
    HOST_SINCE,
    IS_SUPERHOST,
    RESPONSE_RATE_QUALITY,
    HOST_CRATED_AT
FROM {{ ref('obt') }}

{% endsnapshot %}