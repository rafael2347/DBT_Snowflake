{{ config(materialized='view') }}

WITH src_address AS (
    SELECT * FROM {{ source('postgre_db', 'ADDRESSES') }}
),
renamed_casted AS (
    SELECT
          ADDRESS_ID
        , ZIPCODE
        , COUNTRY
        , ADDRESS
        , STATE
        , _FIVETRAN_DELETED
        , _FIVETRAN_SYNCED AS date_load
    FROM src_address
)
SELECT * FROM renamed_casted