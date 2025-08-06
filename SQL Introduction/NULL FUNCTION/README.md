# NULL FUNCTIONS


Here is the data of chess player in one tournament.
```sql
DROP TABLE IF EXISTS chess_player;

CREATE TABLE chess_player(
player_id VARCHAR(10) PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
time_check_in TIMESTAMP,
time_check_out TIMESTAMP,
winner_prize FLOAT
);

INSERT INTO chess_player
VALUES
('F101', 'Zhu',     'Jinner',       '2025-08-01 07:15:25', '2025-08-01 17:30:21', 100000),
('M201', 'Magnus',   NULL,          '2025-08-01 07:40:15', '2025-08-01 15:51:51', 90000),
('F102', 'Hou',     'Yivan',        '2025-08-01 07:28:11', '2025-08-01 16:23:29', 80000),
('M202', 'Wei',     'Yi',           '2025-08-01 07:25:05', '2025-08-01 18:43:13', NULL),
('M203', 'Fabiano', 'Caruana',      '2025-08-01 07:26:02', '2025-08-01 17:32:07', 70000),
('M204', 'Hikaru',   NULL,          '2025-08-01 07:21:21', '2025-08-01 18:29:31', 70000),
('M205', 'Susanto', 'Megaranto',    '2025-08-01 07:22:35', '2025-08-01 18:15:41', 50000),
('M206', 'Anish',   'Giri',         '2025-08-01 07:29:01', '2025-08-01 19:19:59', NULL),
('M207', 'Garry',   'Kasparov',     '2025-08-01 07:30:15', '2025-08-01 19:03:25', 70000),
('M208', NULL,      'Neponimiachi', '2025-08-01 07:32:25', '2025-08-01 17:49:27', 80000),
('F103', NULL,       NULL,          '2025-08-01 07:24:59', '2025-08-01 17:41:31', 50000);

SELECT * FROM chess_player;
```
The result of table is shown as follow:
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/NULL%20FUNCTION/image/null_chess_player.png)

### 1. How long each chess player spend their time in the tournament?
```sql
SELECT
	*,
	time_check_out - time_check_in as time_in_tournament
FROM chess_player;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/NULL%20FUNCTION/image/number1.png)

### 2. Find out all players that last name are missing
```sql
SELECT
	*
FROM chess_player
WHERE last_name is NULL;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/NULL%20FUNCTION/image/number2.png)

### 3. who is missing his/her first name?
```sql
SELECT
	*
FROM chess_player
WHERE first_name is NULL;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/NULL%20FUNCTION/image/number3.png)

### 4. who is missing either his/her first name or his/her last_name?
```sql
SELECT
	*
FROM chess_player
WHERE first_name is NULL AND last_name is NULL;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/NULL%20FUNCTION/image/number4.png)

### 5. Nick name usually is last name. But if it is empty, replace it by first name.
```sql
SELECT
	*,
	COALESCE(last_name,first_name) as nick_name
FROM chess_player;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/NULL%20FUNCTION/image/number5.png)

### 6. What happened when the position is reversed
```sql
SELECT
	*,
	COALESCE(first_name,last_name) as nick_name
FROM chess_player;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/NULL%20FUNCTION/image/number6.png)

### 7. Without first name and last name, the player must be unknown
```sql
SELECT
	*,
	COALESCE(first_name,last_name, 'unknown') as nick_name
FROM chess_player;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/NULL%20FUNCTION/image/number7.png)


### 8. Find out all full name of the chess players. If it is not complete, just use either first name or last name. If both are NULL then the player is unknown 

```sql
SELECT
	*,
	CONCAT(first_name, ' ', last_name)  as full_name,
	CASE
		WHEN CONCAT(first_name, ' ', last_name) = ' ' THEN 'unknown'
		ELSE CONCAT(first_name, ' ', last_name)
	END as full_name_unknown
FROM chess_player;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/NULL%20FUNCTION/image/number8.png)

### 9. Every player is awarded 5000 as appearance money. Count the total money that every players is collected.
```sql
SELECT
	*,
	winner_prize + 5000 as total_money
FROM chess_player;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/NULL%20FUNCTION/image/number9part1.png)

If we assume that NULL means the winner prize is 0, then:
```sql
SELECT
	*,
	COALESCE(winner_prize,0) + 5000 as total_money
FROM chess_player;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/NULL%20FUNCTION/image/number9part2.png)

### 10. In aggregate functions, the NULL value is calculated differently.
```sql
SELECT
	player_id,
	winner_prize,
	SUM(winner_prize) OVER() as money_with_null,
	SUM(COALESCE(winner_prize,0)) OVER() as money_without_null,
	AVG(winner_prize) OVER()::numeric(10,2) as avg_with_null,
	AVG(COALESCE(winner_prize,0)) OVER() avg_without_null,
	MIN(winner_prize) OVER()::numeric(10,2) as MIN_with_null,
	MIN(COALESCE(winner_prize,0)) OVER() MIN_without_null
FROM chess_player;
```
![Library_project](https://github.com/imdwipayana/PostgreSQL/blob/main/SQL%20Introduction/NULL%20FUNCTION/image/number10.png)
