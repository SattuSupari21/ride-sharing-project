with stg_rides as (
    select
        *
    from {{ ref('stg_rides') }}
),

rides_daily_stats as (
    select
        ride_date,
        count (*) as total_rides,
        count (*) filter (where ride_status = 'completed') as rides_completed,
        count (*) filter (where ride_status = 'cancelled') as rides_cancelled,
        round (
            100 * count (*) filter (where ride_status = 'cancelled') / count (*),
            2
        ) as cancellation_rate,
        round(avg(total_fare), 2) as average_fare,
        sum(total_fare) as total_revenue
    from stg_rides
    group by ride_date
)

select * from rides_daily_stats