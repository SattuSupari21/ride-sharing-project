with stg_rides as (
    select
        *
    from {{ ref('stg_rides') }}
),

ride_cancellation_factors as (
    select
        services as service_type,
        extract (hour from ride_time) as ride_hour,
        count (*) as total_rides,
        count (*) filter (where ride_status = 'completed') as completed_rides,
        count (*) filter (where ride_status = 'cancelled') as cancelled_rides,
        round(100.0 * count (*) filter (where ride_status = 'cancelled') / count (*), 2) as cancellation_rate
    from stg_rides
    group by ride_hour, service_type
)

select * from ride_cancellation_factors