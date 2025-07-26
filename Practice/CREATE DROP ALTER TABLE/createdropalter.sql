--=================================================================================
-- DROP player table if it exists
--=================================================================================
DROP TABLE IF EXISTS player;

--=================================================================================
-- CREATE player table
--=================================================================================
CREATE TABLE player(
player_id VARCHAR(15) PRIMARY KEY,
first_name VARCHAR(50),
last_name VARCHAR(50),
Sport VARCHAR(25)
);

--=================================================================================
-- INSERT player table value
--=================================================================================
INSERT INTO player
VALUES 
('A101', 'Leylah', 'Fernandez', 'Tennis'),
('A102', 'Andrew', 'Wiggins',   'Basketball'),
('B201', 'Wayne',  'Gretzky',   'Ice Hockey'),
('B202', 'Steve',  'Nash',      'Basketball'),
('C301', 'Milos',  'Raonic',    'Tennis'),
('C302', 'Connor', 'McDavid',   'Ice Hockey');

--=================================================================================
-- Call the player table
--=================================================================================
SELECT * FROM player

--=================================================================================
-- Modify the player table by adding Status column
--=================================================================================
ALTER TABLE player
ADD Column Status VARCHAR(50) DEFAULT('Active');

--=================================================================================
-- Update the player whose Status is retired 
--=================================================================================
UPDATE player
SET Status = 'Retired'
WHERE player_id 
    IN ('B201', 'B202');

--=================================================================================
-- Call the player table again to see the update
--=================================================================================
SELECT * FROM player;
