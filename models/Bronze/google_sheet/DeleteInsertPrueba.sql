{{ config(
    materialized='incremental',
    unique_key=['MONTH', 'PRODUCT_ID'], 
    incremental_strategy='delete+insert'
) }}

SELECT 
    MONTH, 
    PRODUCT_ID, 
    SUM(QUANTITY) AS total_quantity
FROM {{ source('sql_server_dbo', 'BUDGET') }}

{% if is_incremental() %}
    WHERE MONTH >= DATEADD(day, -3, CURRENT_DATE())
{% endif %}

GROUP BY 1, 2