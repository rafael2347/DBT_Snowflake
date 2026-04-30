{% snapshot users_timestamp_snp_v2 %}

{{
    config(
      target_schema='snapshots',
      unique_key='DNI',
      strategy='timestamp',
      updated_at='fecha_alta_sistema',
      invalidate_hard_deletes=True
    )
}}

SELECT
    Nombre,
    DNI,
    email,
    fecha_alta_sistema
FROM {{ source('google_sheets', 'users') }}

{% endsnapshot %}