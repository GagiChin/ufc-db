# ufc-db

UFC data engineering and analytics project implementing a Bronze / Silver / Gold architecture in MySQL, with an analytics layer for exploratory and explanatory analysis of fight outcomes, fighter performance, and event dynamics.

# Project Overview

The goal of this project is to showcase practical data engineering and analytics skills using real-world sports data.

The project emphasizes:
• Data modeling and schema design
• Analytical correctness and grain control
• Explainability of observed patterns (not just descriptive statistics)

#Architecture Overview

• Bronze Layer – Raw data ingestion
• Silver Layer – Cleaned, standardized, and typed data
• Gold Layer – Dimensional star schema optimized for analytics
• Analytics Layer – Read-only analytical queries built on Gold

# Bronze Layer

The Bronze layer is responsible for ingesting raw UFC CSV datasets into MySQL. All columns are stored as VARCHAR and no transformations are applied during ingestion.

# Silver Layer

The Silver layer transforms the raw Bronze data into clean, standardized datasets suitable for modeling and analysis. In this layer, columns are cast to appropriate data types, dates are normalized, and invalid or duplicate records are handled.

# Gold Layer

The Gold layer implements a dimensional star schema designed specifically for analytical workloads. Core dimension tables describe fighters, events, and dates, while fact tables capture bout-level outcomes and fighter-level participation in bouts.

# Analytics Layer

The analytics layer consists of read-only SQL queries built on top of the Gold schema. These queries are organized by analytical theme and grain and are designed to explore performance patterns, validate assumptions, and explain observed outcomes.

# Example Insights

Analysis performed in this project shows that red corner fighters have a higher observed win rate than blue corner fighters. Further investigation demonstrates that this advantage is largely explained by assignment bias rather than an intrinsic corner effect. Fighters assigned to the red corner tend to be more experienced, have higher career win percentages, and face weaker opponents on average.

# Notes

This repository is intended as a demonstration of data engineering and analytics concepts rather than a production system. The analysis is exploratory and explanatory in nasture. Source CSV files are not included in the repository.
