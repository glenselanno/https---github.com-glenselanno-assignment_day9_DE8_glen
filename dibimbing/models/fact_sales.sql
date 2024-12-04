-- fact_sales
{{
  config(
    materialized='table'
  )
}}

SELECT 
  `Order ID` AS order_id, 
  Date AS date,
  Status AS status,
  {{ dbt_utils.generate_surrogate_key([
				'SKU'
			]) }} as product_id,
  {{ dbt_utils.generate_surrogate_key([
				'Fulfilment', 
				'`fulfilled-by`'
			])}} AS fulfillment_id,
  {{ dbt_utils.generate_surrogate_key([
				'`promotion-ids`'
			]) }} as promotion_id,
  {{ dbt_utils.generate_surrogate_key([
				"ASIN"
			]) }} as shipment_id,
  {{ dbt_utils.generate_surrogate_key([
			"`Sales Channel `"
			]) }} AS sales_channel_id,                
  qty,
  amount,
FROM
    {{ source('bronze', 'amazon_sale_report') }}
