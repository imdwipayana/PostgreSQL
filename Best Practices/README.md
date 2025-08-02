# Best Practices


![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/WHERE%20Before%20JOIN/image/table1.png)

Create second table:
```sql
DROP TABLE IF EXISTS sales_join;

CREATE TABLE sales_join (
product_id VARCHAR(10) PRIMARY KEY,
total_sales INTEGER
);

INSERT INTO sales_join
VALUES
('P101', 50000),
('P102', 200000),
('P103', 75000),
('P104', 125000),
('P105', 90000),
('P106', 65000),
('P107', 85000);

SELECT * FROM sales_join
```

And here is the final result:
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/Best%20Practices/WHERE%20Before%20JOIN/image/number2part2.png)

By filtering the first table, then the row size of the table is decreasing. It will make the join process faster. The first attempt is not efficient because the data that we don't want will do the JOIN process then filtered through WHERE. You get the feeling.
