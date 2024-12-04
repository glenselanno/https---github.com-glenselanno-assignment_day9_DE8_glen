{{
  config(
    materialized='table'
  )
}}

With t_data AS (
SELECT DISTINCT 
  ASIN AS asin,
  `ship-service-level` AS ship_service_level,
  `ship-city` AS ship_city,
  `ship-state` AS ship_state,
  `ship-postal-code` AS ship_postal_code,
  `ship-country` AS ship_country,
  `Courier Status` AS courier_status
FROM
    {{ source('bronze', 'amazon_sale_report') }}
)

SELECT {{ dbt_utils.generate_surrogate_key([
				"ASIN"
			]) }} as shipment_id, *
FROM t_data