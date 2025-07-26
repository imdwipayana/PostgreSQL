# CREATE DROP ALTER
Basically CREATE command for create a table, DROP command for delete a table and ALTER command for modify a table. Here, a table named player will be created. At first we need to drop the player table in the case it exists.
## 1. DROP
```sql
DROP TABLE IF EXISTS player;
```
After the table is dropped, we can create a new table.

## 2. CREATE
```sql
CREATE TABLE player(
player_id VARCHAR(15) PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
Salary INTEGER,
Sport VARCHAR(25)
);
```
Then insert the value of the table through:
```sql
INSERT INTO player
VALUES 
('A101', 'Michael',    'Jordan',   100000, 'Basketball'),
('A102', 'Christiano', 'Ronaldo',  150000, 'Soccer'),
('B201', 'Leonel',     'Messi',    200000, 'Soccer'),
('B202', 'Scottie',    'Pippen',   300000, 'Basketball'),
('C301', 'Gianluca',   'Pagliuca', 75000,  'Soccer');
```

Call the player table with:
```sql
SELECT * FROM player
```

The player table will be shown as:
![create_drop_alter](https://github.com/imdwipayana/PostgreSQL/blob/main/Practice/CREATE%20DROP%20ALTER%20TABLE/image/player_table.png)



## 3. ALTER



```sql
UPDATE members
SET member_address = '125 Oak St'
WHERE member_id = 'C103';
```
