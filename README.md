# 🚗 Ride-Sharing Data Analytics Project

An end-to-end data engineering and analytics pipeline using **PostgreSQL**, **dbt**, **Apache Airflow**, and **Apache Superset**. This project analyzes ride-sharing data to uncover trends in usage, cancellations, revenue, and route efficiency.

## 🧱 Project Overview

**Objective**: Analyze ride-sharing data to provide insights into service performance, rider behavior, and operational optimizations.

**Key Outcomes**:
- Identify peak usage hours and high-performing service types
- Analyze cancellation patterns by time, service, and route
- Visualize route-based revenue and trip volume


## 🛠 Tech Stack

- **PostgreSQL (Docker)** – Database for storing raw and transformed data
- **dbt** – Data transformation, modeling, and testing
- **Apache Airflow** – Workflow orchestration and scheduling
- **Apache Superset** – Interactive dashboards and visualizations
- **Google Docs** – Final reporting and documentation


## ⚙️ Setup Instructions

### 1. Clone the Repository
```bash
git clone https://github.com/SattuSupari21/ride-sharing-project.git
cd ride-sharing-analytics
```

### 2. Initialize Airflow Database
```
docker compose up init-airflow -d
```
Wait for 3-4 seconds.

### 3. Create and Start the containers
```
docker compose up
```

## 📈 Visualizations in Superset

- 📊 Daily Ride Trends
- 🕒 Hourly Demand by Service
- ❌ Cancellation Rate by Service & Hour
- 🛣 Revenue by Route
- 📉 Cancellations Over Time

> Superset exports and screenshots are located in `/dashboards` and `/visualizations`.

## 📊 Key Analyses & Dashboards
|Analysis Model|Description|
|---|---|
|`rides_by_route`|Most frequent and profitable source-destination pairs|
|`rides_by_service`|Comparison of ride volume, fares, and cancellations by service type|
|`rides_hourly_trends`|Ride activity patterns by hour and service type|
|`rides_daily_stats`|Daily KPIs: total rides, average fare, total distance, cancellation rate|
|`ride_cancellation_factors`|Insights into when, where, and why rides are cancelled|

## 🧪 Data Quality & Tests

Implemented via `dbt`:

- `not_null` on required fields (ride_id, date, etc.)
- `unique` on `ride_id`
- Clean handling of nulls and type mismatches

## 📄 Final Report

A professional project report is available in `final_report.pdf`, including:

- Project overview and architecture
- Visualizations and insights
- Data model summary and metrics

