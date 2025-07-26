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
Sport VARCHAR(25)
);
```
Then insert the value of the table through:
```sql
INSERT INTO player
VALUES 
('A101', 'Leylah', 'Fernandez', 'Tennis'),
('A102', 'Andrew', 'Wiggins',   'Basketball'),
('B201', 'Wayne',  'Gretzky',   'Ice Hockey'),
('B202', 'Steve',  'Nash',      'Basketball'),
('C301', 'Milos',  'Raonic',    'Tennis'),
('C302', 'Connor', 'McDavid',   'Ice Hockey');
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
