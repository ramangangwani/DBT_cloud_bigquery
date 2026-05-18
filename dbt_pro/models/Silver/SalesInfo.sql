WITH Sales as (
    Select 
         sales_id,
         date_sk,
         product_sk,
         customer_sk,
         store_sk,
         {{multiply('quantity','unit_price')}} as calculated_gross_amount,
         gross_amount,
         payment_method
    from {{ ref('Bronze_sales') }}
),
Customers as (
    Select customer_sk, gender from {{ ref('Bronze_customers') }}
),
products as (
    Select product_sk, category from {{ ref('Bronze_product') }}
),
Joined_query as(
    select 
        s.sales_id,
        s.gross_amount,
        s.payment_method,
        p.category,
        c.gender
       from sales as s 
join products as p
on s.product_sk = p.product_sk
join Customers as c
on s.customer_sk = c.customer_sk
)
select category,gender, payment_method, sum(gross_amount) as total_gross_amount
from Joined_query
group by category,gender, payment_method