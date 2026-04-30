{{ config(
    materialized='incremental',
    incremental_strategy='append'
) }}

SELECT 
    _ROW, 
    _FIVETRAN_SYNCED, 
    MONTH, 
    PRODUCT_ID, 
    QUANTITY
FROM {{ source('sql_server_dbo', 'BUDGET') }}

{% if is_incremental() %}
    
    WHERE _FIVETRAN_SYNCED > (SELECT MAX(_FIVETRAN_SYNCED) FROM {{ this }})
{% endif %}