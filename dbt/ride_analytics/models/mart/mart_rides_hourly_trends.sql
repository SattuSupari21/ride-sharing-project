with stg_rides as (
    select
        *
    from {{ ref('stg_rides') }}
),

rides_hourly_trends as (
    select
        extract (hour from ride_time) as ride_hour,
        services as service_type,
        count (*) as total_rides,
        count (*) filter (where ride_status = 'cancelled') as cancelled_rides,
        round(100.0 * count (*) filter (where ride_status = 'completed') / count (*), 2) as completion_rate,
        round(sum(total_fare) / count (*), 2) as average_fare,
        round(sum(duration) / count (*)) as average_duration,
        round(100.0 * count (*) filter (where ride_status = 'cancelled') / count (*), 2) as cancellation_rate,
        case
            when extract(dow from cast(ride_date as date)) in (0, 6) then true
            else false
        end as is_weekend
    from stg_rides
    group by ride_hour, service_type, ride_date
)

select * from rides_hourly_trends