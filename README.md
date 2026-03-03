# 🏠 Airbnb Data Engineering Pipeline  
**Snowflake | dbt | AWS S3**

---

## 📋 Project Overview

This project implements an end-to-end ELT data pipeline for Airbnb booking data. Raw CSV files are stored in AWS S3, loaded into Snowflake, and transformed using dbt following a Medallion Architecture (Bronze → Silver → Gold).

The pipeline supports incremental processing and Slowly Changing Dimensions (SCD Type 2), enabling scalable analytics and historical tracking.

---

## 🔧 Technology Stack

- Snowflake (Data Warehouse)  
- dbt (Transformation Framework)  
- AWS S3 (Storage Layer)  
- SQL + Jinja  
- Python (Orchestration)  

---

## 🏗️ Architecture

### Data Flow

```
Source CSV → AWS S3 → Snowflake (Staging) → Bronze → Silver → Gold → Analytics
```

### Medallion Layers

**Bronze Layer (Raw Ingestion)**
- `bronze_bookings`
- `bronze_hosts`
- `bronze_listings`

Minimal transformation. Mirrors source structure.

**Silver Layer (Cleaned & Standardized)**
- `silver_bookings`
- `silver_hosts`
- `silver_listings`

Handles:
- Deduplication  
- Data validation  
- Standardization  
- Derived fields  

**Gold Layer (Analytics-Ready)**
- `fact` – Star-schema fact table
- `obt` – Denormalized One Big Table
- Ephemeral models for modular joins

Optimized for BI and reporting.

---

## 📁 Project Structure

```
AWS_DBT_Snowflake/
├── SourceData/
├── DDL/
├── aws_dbt_snowflake_project/
│   ├── models/
│   │   ├── bronze/
│   │   ├── silver/
│   │   └── gold/
│   ├── macros/
│   ├── snapshots/
│   ├── tests/
│   └── analyses/
├── main.py
└── pyproject.toml
```

---
## Slowly Changing Dimensions (SCD Type 2)

Snapshots are implemented for:

- `dim_bookings`
- `dim_hosts`
- `dim_listings`

Historical changes are tracked using valid-from and valid-to timestamps, enabling point-in-time analysis.

---

## 🎯 Key Features

### Incremental Models

Bronze and Silver models use incremental materialization to process only new or updated records.

```sql
{{ config(materialized='incremental') }}

{% if is_incremental() %}
WHERE updated_at > (SELECT COALESCE(MAX(updated_at), '1900-01-01') FROM {{ this }})
{% endif %}
```

This reduces compute usage and improves runtime efficiency.

---

### Modular dbt Design

- Layered transformation structure
- Reusable macros
- Ephemeral models for intermediate logic
- Clean separation between staging and analytics layers

---

### Data Quality Controls

Implemented dbt tests:
- `not_null`
- `unique`
- Source validation

Ensures production-grade reliability.

---

## 📈 Business Insights Enabled

The final models support analysis such as:

- Monthly booking trends  
- Revenue per listing  
- Host performance comparison  
- Occupancy rate analysis  
- Historical price evolution  

---

## 👤 Author

Ganesh Jagtap  
Data Engineer | SQL | dbt | Snowflake | AWS
