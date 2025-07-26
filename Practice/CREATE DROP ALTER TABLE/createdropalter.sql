--=================================================================================
-- Create player table
--=================================================================================
DROP TABLE IF EXISTS player;
CREATE TABLE player(
player_id VARCHAR(15) PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
Salary INTEGER,
Sport VARCHAR(25)
);

--=================================================================================
-- Insert player table value
--=================================================================================
INSERT INTO player
VALUES 
('A101', 'Michael',    'Jordan',   100000, 'Basketball'),
('A102', 'Christiano', 'Ronaldo',  150000, 'Soccer'),
('B201', 'Leonel',     'Messi',    200000, 'Soccer'),
('B202', 'Scottie',    'Pippen',   300000, 'Basketball'),
('C301', 'Gianluca',   'Pagliuca', 75000,  'Soccer');

--=================================================================================
-- Call the player table
--=================================================================================
SELECT * FROM player
