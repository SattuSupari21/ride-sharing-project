with source as (
    select * from rides
),
cleaned as (
    select
        ride_id,
        services,
        date::date as ride_date,
        time::time as ride_time,
        (date || ' ' || time)::timestamp as ride_datetime,
        source,
        destination,
        duration::numeric,
        distance::numeric,
        coalesce(ride_charge::numeric, 0) as ride_charge,
        coalesce(misc_charge::numeric, 0) as misc_charge,
        coalesce(total_fare::numeric, 0) as total_fare,
        coalesce(payment_method, 'not_applicable') as payment_method,
        ride_status
    from source
    where ride_id is not null
)

select * from cleaned