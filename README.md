# Create-triggers-on-all-PKs-in-Oracle-DB

This script uses the Oracle DB Dictionary to create a trigger on each table to insert into the primary key automatically. <br>
This trigger uses the values from a sequence created for that particular primary key.

This script is perfect for tables with numerical primary keys, and uses sequence that starts with 1 for alphabetical primary keys.
It also discards any composite keys.
