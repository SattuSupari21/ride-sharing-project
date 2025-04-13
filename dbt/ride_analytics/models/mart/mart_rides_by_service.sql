with stg_rides as (
    select
        *
    from {{ ref('stg_rides' )}}
),

rides_by_service as (
    select
        services as service_type,
        count (*) as total_rides,
        count (*) filter (where ride_status = 'completed') as completed_rides,
        count (*) filter (where ride_status = 'cancelled') as cancelled_rides,
        sum(total_fare) as total_revenue_generated,
        round(sum(total_fare) / count (*), 2) as average_fare,
        round(sum(distance) / count (*), 2) as average_distance,	
        round(sum(duration) / count (*), 2) as average_duration,
        round(100.0 * count (*) filter (where ride_status = 'cancelled') / count (*), 2) as cancellation_rate
    from stg_rides
    group by service_type
)

select * from rides_by_service