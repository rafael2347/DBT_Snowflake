{% snapshot users_timestamp_snp %}

{{
    config(
      target_schema='snapshots',
      unique_key='_row',
      strategy='timestamp',
      updated_at='_fivetran_synced',
      hard_deletes='new_record',
    )
}}

SELECT
    Nombre,
    DNI,
    email,
    fecha_alta_sistema
FROM {{ source('google_sheets', 'users') }}

{% endsnapshot %}