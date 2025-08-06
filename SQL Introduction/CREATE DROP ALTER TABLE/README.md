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
![create_drop_alter](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/CREATE%20DROP%20ALTER%20TABLE/image/table_player.png)



## 3. ALTER
We want to add one column about status the athlete either still active or already retired. For that reason, we use the ALTER command.
```sql
ALTER TABLE player
ADD Column Status VARCHAR(50) DEFAULT('Active');
```
Syntax above will put all the status are active. For the retired player, we can use the following syntax:
```sql
UPDATE player
SET Status = 'Retired'
WHERE player_id 
    IN ('B201', 'B202');
```
Call the player table again to find the update result as:
![create_drop_alter](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/CREATE%20DROP%20ALTER%20TABLE/image/alter_table.png)

For example, if Milos Raonic decides to retired, then we need to update his status to be retired. To do this, we use the syntax:
```sql
UPDATE player
SET  status = 'Retired'
WHERE player_id = 'C301';
```
Then call again the player table to see the status has been changed.
```sql
SELECT * FROM player
```
![create_drop_alter](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/CREATE%20DROP%20ALTER%20TABLE/image/update_status.png)

Avril Lavigne wants to be a member of the club. She gives the data with syntax:
```sql
INSERT INTO player(player_id, first_name, last_name, sport, status)
VALUES('D101', 'Avril', 'Lavigne', 'Skateboard', 'Active');
```
Then call again the player table to see a new member has been added.
```sql
SELECT * FROM player
```

![create_drop_alter](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/CREATE%20DROP%20ALTER%20TABLE/image/new%20member.png)

After some time, Avril realizes that she is a singer and wants to withdraw from the club as member. To fulfill that, we use the syntax:

```sql
DELETE FROM player
WHERE   player_id =   'D101';
```
Then call again the player table to see the update table.
```sql
SELECT * FROM player
```
![create_drop_alter](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/CREATE%20DROP%20ALTER%20TABLE/image/member_withdraw.png)




