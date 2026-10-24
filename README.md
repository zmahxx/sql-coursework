# SQL Coursework

Two individual database-coursework query scripts demonstrate filtering, joins, aggregation, grouping, subqueries, and anti-join patterns. The owner confirms they wrote the substantive query implementations. These are query exercises, not a database application or production database system.

## Included scripts

- `sql/lab3_part1.sql` — employee/project queries; selects the `lab3_part1` schema and uses MySQL-specific syntax including `BINARY` and backtick aliases.
- `sql/lab3_part2_retail_queries.sql` — retail-store queries against `lab4_retail_store_db`; the filename's `part2` versus the Lab 4/course header mismatch is retained and not resolved by available records.

## Prerequisites and use

A compatible MySQL server must already contain the referenced schemas and tables. Schema definitions, sample records, database dumps, and assignment handouts are not included. After provisioning the corresponding schema, run each script with a MySQL client, for example `mysql -u <user> -p < sql/lab3_part1.sql`; the script itself selects its database. The SQL was not executed, and the exact server/version is not established.

## Attribution and starter-material review

The archived answer-script variants correspond to the two included queries; removing the personal student identifier from those archived variants yields the staged query contents. The owner confirms individual assignment status and substantive authorship. No instructor-provided schema/setup file is included, and no identifiable instructor-authored query implementation or license notice was found in the two candidate scripts. The owner recalls starter/template use in coursework generally, but no specific supplied query block was identifiable here. This does not claim every line was independently written. No license is included.

## Limitations

The scripts depend on externally provisioned schemas and MySQL-specific behavior. Query correctness has not been tested against a database. No schema, data, or credentials are included.
