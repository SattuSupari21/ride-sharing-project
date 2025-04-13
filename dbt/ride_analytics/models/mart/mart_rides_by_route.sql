with stg_rides as (
    select 
        *
    from {{ ref('stg_rides') }}
),

rides_by_route as (
    select
        source,
        destination,
        count(*) as total_rides,
        count(*) filter (where ride_status = 'completed') as completed_rides,
        count(*) filter (where ride_status = 'cancelled') as cancelled_rides,
        sum(total_fare) as total_fare,
        round(sum(total_fare) / count (*), 2) as average_fare,
        round(sum(duration) / count (*), 2) as average_ride_duration,
    	round(sum(distance) / count (*), 2) as average_ride_distance
    from stg_rides
    group by source, destination
    order by total_rides desc
)

select * from rides_by_route