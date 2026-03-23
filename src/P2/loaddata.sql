-- Include your INSERT SQL statements in this file.
-- Make sure to terminate each statement with a semicolon (;)

-- LEAVE this statement on. It is required to connect to your database.
CONNECT TO COMP421;

-- Remember to put the INSERT statements for the tables with foreign key references
--    ONLY AFTER the insert for the parent tables!

-- This is only an example of how you add INSERT statements to this file.
--   You may remove it.
-- A more complex syntax that saves you typing effort.
INSERT INTO employee(emp_id, name, position_title, start_date, email, password) VALUES
 (1, 'John Doe', 'Power Systems Intern', '2025-09-02', 'johndoe@yahoo.com', 'iLikeEmpanadas3'),
 (2, 'Amelia Dubey', 'Senior Power Engineer', '2012-10-02', 'ameliadubey1@gmail.com', 'boopitY91'),
 (3, 'Dave Ciabatta', 'Junior Power Systems Specialist', '2000-1-04', 'davit3cia@rogers.com', 'Ilikebeaches1'),
 (4, 'Maria Carella', 'RFIC Specialist', '2015-11-02', 'mariella1993@yahoo.com', 'ItaliaForLif3'),
 (5, 'Samantha Krey', 'RF Engineer', '2009-03-09', 'samkrocks@sympatico.ca', 'sammywhammy02'),
 (6, 'Hank Burrow', 'Junior Structural Engineer', '2017-11-02', 'hank4ever@hotmail.com', 'carpetStain9'),
 (7, 'Chloe Shaw', 'Senior Materials Engineer', '2020-05-02', 'cshaaw@yahoo.com', 'grenadaIsBeautiful2'),
 (8, 'Luigi Carbonara', 'Electrical Systems Manager', '2015-08-27', 'luigi3521@gmail.com', 'Blue32'),
 (9, 'Felix Liaschuk', 'Electrical Infrastructure Supervisor', '2016-02-11', 'felix2@infra.com', '>structural:['),
 (10, 'Catherine Cortina', 'Senior Advisor: Solids and Structures', '1999-07-02', 'ccortina@belllabs.ca', 'boop'),
 (11, 'Mia Evangelou', 'Mechanical Structures Supervisor', '2021-12-06', 'miaeva@hotmail.com', 'Seafood24'),
 (12, 'Ellie Lock', 'Electrical Subsystems Supervisor', '2014-04-03', 'elock43@gmail.com', 'GiveMeaRaze100%'),
 (13, 'Anna Novikov', 'Project Direction Specialist', '2008-11-02', 'annikov9@sympatico.com', 'iLoveMyJob*'),
 (1405, 'Madeline Mora', 'Chief Technical Officer', '2011-06-14', 'maddiem49@crosstrek.com', 'wheresMyCoffee08'),
 
 -- AI generated data:
 (2001, 'Victor Havel', 'Director of Autonomous Systems', '2010-05-11', 'vhavel@evdesign.com', 'dirPass88'),
 (2002, 'Priya Raman', 'Autonomous Systems Manager', '2016-08-20', 'praman@evdesign.com', 'ctrlAI77'),
 (2003, 'Mateo Alvarez', 'Thermal Engineering Manager', '2014-02-12', 'malvarez@evdesign.com', 'thermoHeat5'),

 (2004, 'Lucas Hartmann', 'Control Systems Engineer', '2021-06-10', 'lhartmann@evdesign.com', 'loopCtrl3'),
 (2005, 'Nadia Petrov', 'Computer Vision Engineer', '2022-09-01', 'npetrov@evdesign.com', 'visionEdge8'),
 (2006, 'Eric Zhang', 'Embedded AI Engineer', '2023-01-15', 'ezhang@evdesign.com', 'tensorNode2'),

 (2007, 'Sofia Lindholm', 'Thermal Systems Engineer', '2019-04-23', 'slindholm@evdesign.com', 'heatFlux7'),
 (2008, 'Daniel Okafor', 'Cryogenic Systems Engineer', '2020-10-12', 'dokafor@evdesign.com', 'coldCore6'),
 (2009, 'Isabella Rossi', 'Battery Safety Engineer', '2018-07-05', 'irossi@evdesign.com', 'safeVolt4'),
 (2010, 'Mark Chen', 'Materials Modeling Engineer', '2022-02-18', 'mchen@evdesign.com', 'matModel9'),

 (2011, 'Akira Sato', 'Sensor Systems Supervisor', '2013-11-04', 'asato@evdesign.com', 'sensorGrid1'),
 (2012, 'Helen Brooks', 'Autonomy Algorithms Supervisor', '2012-03-21', 'hbrooks@evdesign.com', 'navMatrix2'),
 (2013, 'Lars Nyberg', 'Thermal Systems Supervisor', '2011-09-13', 'lnyberg@evdesign.com', 'thermalNord5')
;

INSERT INTO manager(emp_id) VALUES
 (8),
 (10),
 
 -- AI generated data
 (2002),
 (2003)
;

INSERT INTO team(team_id, department, mngr_emp_id) VALUES
 (32, 'Power Systems', 8),
 (21, 'RF & Antennas', 8),
 (8, 'Solids and Structures', 10),
 
 -- AI generated data
  (45, 'Autonomous Systems', 2002),
 (46, 'Thermal Materials', 2003)
;

INSERT INTO standard(emp_id, team_id) VALUES
 (1, 32),
 (2, 32),
 (3, 32),
 (4, 21),
 (5, 21),
 (6, 8),
 (7, 8),
 
 -- AI generated data
 (2004, 45),
 (2005, 45),
 (2006, 45),

 (2007, 46),
 (2008, 46),
 (2009, 46),
 (2010, 46)
;

INSERT INTO project(codename, charter, start_date, deadline_date) VALUES
 ('Bear', 'Contract to design and supply 34 application-specific electric vehicles for the client', '2023-05-02', '2028-07-03'), 
 ('Cobra', 'Contract to design and supply 10 electric supply vehicles for long-distance cargo-hauls', '2024-11-02', '2027-08-31'), 
 
 -- AI generated data
 ('Orion',
  'Development of an autonomous exploration electric vehicle optimized for extreme environments and high reliability sensing',
  '2025-04-01',
  '2029-09-30')
;

INSERT INTO component(codename, cmpt_name, parent_name, is_complete, priority_num) VALUES
 ('Bear', 'Structural', NULL, 'FALSE', 3),
 ('Bear', 'Electrical', NULL, 'FALSE', 5),
 ('Bear', 'Vehicle Frame', 'Structural', 'FALSE', 2),
 ('Bear', 'Concept Proposal', 'Structural', 'TRUE', NULL),
 ('Cobra', 'Electrical', NULL, 'FALSE', 4),
 ('Cobra', 'Power', 'Electrical', 'TRUE', NULL),
 ('Cobra', 'Communications', 'Electrical', 'FALSE', 5),
 ('Cobra', 'RF Electronics', 'Communications', 'FALSE', 5),
 
 -- AI generated data
 ('Orion', 'Autonomous Systems', NULL, 'FALSE', 5),
 ('Orion', 'Thermal Management', NULL, 'FALSE', 4),

 ('Orion', 'Lidar Perception', 'Autonomous Systems', 'FALSE', 4),
 ('Orion', 'Navigation Algorithms', 'Autonomous Systems', 'FALSE', 5),

 ('Orion', 'Cryogenic Battery Cooling', 'Thermal Management', 'FALSE', 1)
;

INSERT INTO supervisor(emp_id, codename, cmpt_name) VALUES
 (11, 'Bear', 'Structural'),
 (9, 'Bear', 'Electrical'),
 (12, 'Cobra', 'Electrical'),
 
 -- AI generated data
 (2011, 'Orion', 'Lidar Perception'),
 (2012, 'Orion', 'Navigation Algorithms'),
 (2013, 'Orion', 'Cryogenic Battery Cooling')
;

INSERT INTO director(emp_id, codename) VALUES
 (13, 'Bear'),
 (1405, 'Cobra'),
 
 -- AI generated data
 (2001, 'Orion')
;

INSERT INTO objective(codename, cmpt_name, obj_id, description, goal_name, is_complete, priority_num) VALUES
 ('Bear', 'Vehicle Frame', 12, 'Ensure that the vehicle frame is structurally stable enough to adhere to withstand impacts and dampen mechanical vibrations', 'Frame Sensitivity', 'FALSE', 1),
 ('Bear', 'Structural', 2, 'Complete the designs of the mechanical structures of the vehicle', 'Design Schematics', 'TRUE', NULL),
 ('Bear', 'Electrical', 3, 'Complete the electrical wiring to provide power to the lighting, HUD, and entertainment systems', 'Wiring', 'FALSE', 6),
 ('Cobra', 'Electrical', 8, 'Prepare the relevant documentation and testing results for the upcoming design review', 'D.R. Documentation', 'FALSE', 3),
 ('Cobra', 'Power', 4, 'Conduct further testing to determine the updated power requirements for the vehicle', 'Power Requirements', 'TRUE', NULL),
 ('Cobra', 'RF Electronics', 9, 'Ensure the RFIC chips  meet operational requirements and lack defects', 'Chip Validation', 'FALSE', 5),
 ('Cobra', 'RF Electronics', 15, 'Ensure the robustness and reliability of the on-board communications systems', 'Comms Reliability', 'FALSE', 8),
 
 -- AI generated data
 ('Orion', 'Lidar Perception', 1,
  'Validate lidar sensor accuracy and robustness in high-noise environments',
  'Sensor Calibration', 'FALSE', 4),

 ('Orion', 'Navigation Algorithms', 2,
  'Develop adaptive path planning algorithms for autonomous exploration',
  'Adaptive Navigation', 'FALSE', 5),

 ('Orion', 'Cryogenic Battery Cooling', 3,
  'Design cooling system capable of maintaining safe battery temperature during high load',
  'Battery Thermal Stability', 'FALSE', 1)
;

INSERT INTO task(codename, cmpt_name, obj_id, task_no, creation_date, closure_date, status, description, priority_num) VALUES
 ('Bear', 'Vehicle Frame', 12, 45, '2026-02-03', NULL, 'IN_PROGRESS', 'Conduct a vibration analysis for the front right strut of the frame in AutoCad', 1),
 ('Bear', 'Structural', 2, 20, '2023-11-12', '2024-02-01', 'DONE', 'Provide designs for the vehicle suspension', NULL),
 ('Bear', 'Electrical', 3, 18, '2024-03-02', '2024-04-27', 'DONE', 'Determine the specifications for the necessary wiring', NULL),
 ('Bear', 'Electrical', 3, 33, '2025-09-21', NULL, 'IN_PROGRESS', 'Simulated electrical stress-testing on the entertainment system circuitry', 4),
 ('Bear', 'Electrical', 3, 52, '2026-02-14', NULL, 'ON_HOLD', 'Acquire the wiring from our third party provider', NULL),
 ('Cobra', 'Electrical', 8, 5, '2026-01-11', NULL, 'IN_PROGRESS', 'Compile electrical testing data for the report', 2),
 ('Cobra', 'Power', 4, 31, '2025-12-22', NULL, 'IN_PROGRESS', 'Conduct power electronics tests in the high frequency range of the VFD', 2),
 ('Cobra', 'RF Electronics', 9, 51, '2026-03-04', NULL, 'IN_PROGRESS', 'Test the RFIC communications chips for defects', 3),
 ('Cobra', 'RF Electronics', 15, 45, '2026-02-14', NULL, 'IN_PROGRESS', 'Produce a sufficient noise filter for RF interference on high-frequency communication channels', 5),
 
 -- AI generated data
 ('Orion','Lidar Perception',1,10,'2025-05-03',NULL,'IN_PROGRESS',
  'Run calibration tests for lidar sensors under simulated noise conditions',2),

 ('Orion','Lidar Perception',1,11,'2025-05-05',NULL,'IN_PROGRESS',
  'Develop preprocessing pipeline for lidar point-cloud filtering',3),

 ('Orion','Navigation Algorithms',2,20,'2025-05-02',NULL,'IN_PROGRESS',
  'Design control-loop architecture for vehicle navigation module',2),

 ('Orion','Navigation Algorithms',2,21,'2025-05-06',NULL,'TODO',
  'Implement reinforcement learning navigation prototype',3),

 ('Orion','Cryogenic Battery Cooling',3,30,'2025-05-04',NULL,'IN_PROGRESS',
  'Simulate cryogenic heat transfer in battery module',2),

 ('Orion','Cryogenic Battery Cooling',3,31,'2025-05-06',NULL,'TODO',
  'Evaluate materials suitable for cryogenic insulation',2),

 ('Orion','Cryogenic Battery Cooling',3,32,'2025-05-07',NULL,'TODO',
  'Perform safety analysis for battery cooling failure scenarios',1)
;

INSERT INTO meeting(meeting_id, title, start_time, end_time, description) VALUES
 (1252, 'Team 32 weekly meeting', '2024-11-12 13.30.00', '2024-11-12 14.30.00', 'To go over the new team objectives for the week and provide progress updates'),
 (1634, 'Bear: Objective 12 status', '2026-02-23 09.30.00', '2026-02-23 11.00.00', 'To discuss the progress on objective 12 with the manager, supervisor, and director'),
 (1322, 'John Doe Performance Review', '2025-12-23 14.00.00', '2025-12-23 15.00.00', 'Annual Performance Review for John Doe'),
 (900, 'Team 21 Kickstarter meeting for project Cobra', '2024-11-05 08.30.00', '2024-11-05 09.30.00', 'To provide an overview of the current responsibilities for the team'),
 
 -- AI generated data
 (3000,'Power Systems Standup','2025-01-10 09.00.00','2025-01-10 09.30.00','Weekly engineering sync for power systems team'),
(3001,'RF Electronics Debugging','2025-01-12 11.00.00','2025-01-12 12.00.00','Investigating signal interference in RF board prototypes'),
(3002,'Structural Frame Review','2025-01-14 13.00.00','2025-01-14 14.00.00','Review of vehicle frame stress simulation results'),
(3003,'Autonomous Systems Kickoff','2025-05-01 10.00.00','2025-05-01 11.00.00','Kickoff meeting for Orion autonomous subsystem'),
(3004,'Battery Cooling Brainstorm','2025-05-03 14.00.00','2025-05-03 15.00.00','Discussing cryogenic cooling concepts'),
(3005,'Navigation Algorithm Review','2025-05-05 10.00.00','2025-05-05 11.00.00','Initial review of navigation architecture'),
(3006,'Team 45 Weekly Standup','2025-05-07 09.00.00','2025-05-07 09.30.00','Autonomous systems team weekly sync'),
(3007,'Thermal Materials Sync','2025-05-09 13.00.00','2025-05-09 14.00.00','Progress review for cryogenic battery cooling'),
(3008,'Component Integration Planning','2025-06-01 10.00.00','2025-06-01 11.00.00','Planning integration between electrical and mechanical subsystems'),
(3009,'Lidar Calibration Discussion','2025-06-03 11.00.00','2025-06-03 12.00.00','Discuss calibration methodology'),

(3010,'Orion Architecture Review','2025-06-10 10.00.00','2025-06-10 11.30.00','Director-level architecture overview'),
(3011,'Power Electronics Testing','2025-06-12 09.30.00','2025-06-12 10.30.00','Testing procedures for high-frequency power electronics'),
(3012,'Communications Systems Planning','2025-06-15 14.00.00','2025-06-15 15.00.00','Planning RF communications subsystem development'),
(3013,'Autonomy Software Check-in','2025-06-17 10.00.00','2025-06-17 11.00.00','Progress review for autonomy code modules'),
(3014,'Battery Safety Review','2025-06-20 13.00.00','2025-06-20 14.00.00','Safety analysis of new battery module'),
(3015,'Cryogenic Materials Study','2025-06-23 11.00.00','2025-06-23 12.00.00','Evaluating materials for cryogenic insulation'),

(3016,'Vehicle Frame Progress','2025-07-01 09.00.00','2025-07-01 10.00.00','Frame design progress update'),
(3017,'RFIC Testing Coordination','2025-07-04 14.00.00','2025-07-04 15.00.00','Coordinate chip testing schedule'),
(3018,'Systems Integration Review','2025-07-07 10.00.00','2025-07-07 11.00.00','Integration discussion between teams'),
(3019,'Team 46 Weekly Standup','2025-07-10 09.00.00','2025-07-10 09.30.00','Thermal team weekly meeting'),


(3075,'New Year Engineering Kickoff','2026-01-05 10.00.00','2026-01-05 11.00.00','Engineering kickoff for new year'),
(3076,'Autonomy Roadmap Planning','2026-01-07 13.00.00','2026-01-07 14.00.00','Planning autonomy roadmap'),
(3077,'Power Electronics Check','2026-01-10 11.00.00','2026-01-10 12.00.00','Power electronics check'),
(3078,'Thermal Materials Testing','2026-01-12 09.30.00','2026-01-12 10.30.00','Testing materials'),
(3079,'Navigation System Sync','2026-01-15 10.00.00','2026-01-15 11.00.00','Navigation sync'),

(3080,'RF Hardware Debug','2026-01-18 13.00.00','2026-01-18 14.00.00','Hardware debugging'),
(3081,'Battery Safety Analysis','2026-01-20 11.00.00','2026-01-20 12.00.00','Safety analysis meeting'),
(3082,'Systems Reliability Review','2026-01-22 10.00.00','2026-01-22 11.00.00','Reliability review'),
(3083,'Autonomy Integration Planning','2026-01-25 14.00.00','2026-01-25 15.00.00','Integration planning'),
(3084,'Engineering Leadership Sync','2026-01-28 09.30.00','2026-01-28 10.30.00','Leadership sync'),

(3100,'Orion Sensor Calibration Sync','2026-02-10 10.00.00','2026-02-10 11.00.00','Discussion of recent lidar calibration results for the Orion vehicle'),
(3101,'Battery Cooling Progress Review','2026-02-12 14.00.00','2026-02-12 15.00.00','Review of cryogenic cooling simulations and next engineering steps'),
(3102,'Navigation Algorithm Debugging','2026-02-14 11.00.00','2026-02-14 12.00.00','Investigating instability in the autonomous navigation algorithm'),
(3103,'Project Orion Integration Sync','2026-02-16 09.30.00','2026-02-16 10.30.00','Cross-team integration discussion between autonomy and thermal teams'),
(3104,'RF Electronics Testing Discussion','2026-02-18 13.00.00','2026-02-18 14.00.00','Discuss RF subsystem test results for communication reliability'),

(3105,'Vehicle Frame Engineering Review','2026-02-20 10.00.00','2026-02-20 11.00.00','Structural engineering review of frame vibration simulations'),
(3106,'Autonomous Systems Standup','2026-02-22 09.00.00','2026-02-22 09.30.00','Weekly standup for the autonomous systems engineering team'),
(3107,'Thermal Materials Research Update','2026-02-24 11.00.00','2026-02-24 12.00.00','Latest findings on cryogenic insulation materials'),
(3108,'Power Electronics Testing Coordination','2026-02-26 13.00.00','2026-02-26 14.00.00','Coordination meeting for upcoming power electronics tests'),
(3109,'Orion Project Leadership Check-in','2026-02-27 15.00.00','2026-02-27 16.00.00','Directors and managers review Orion milestone progress'),

(3110,'AI Navigation Model Review','2026-03-02 10.00.00','2026-03-02 11.00.00','Performance review of the latest AI navigation model'),
(3111,'Battery Safety Engineering Meeting','2026-03-04 13.00.00','2026-03-04 14.00.00','Discussion of battery safety testing and risk mitigation'),
(3112,'RF Communications Reliability Meeting','2026-03-05 11.00.00','2026-03-05 12.00.00','Improving RF communications reliability in noisy environments'),
(3113,'Autonomous Control Systems Sync','2026-03-07 09.30.00','2026-03-07 10.30.00','Coordination between control systems and AI navigation engineers'),
(3114,'Engineering Coordination Meeting','2026-03-08 14.00.00','2026-03-08 15.00.00','General coordination meeting across multiple engineering teams'),
(3115, 'Autonomous Navigation Implementation Discussion','2026-03-09 15.00.00', '2026-03-09 15.45.00', 
	'Lucas Hartmann and Eric Zhang discuss implementation details for the navigation control loop and AI integration')
;

INSERT INTO attends(emp_id, meeting_id) VALUES
 (1, 1252), (2, 1252), (3, 1252), (8, 1252),
 (7, 1634), (10, 1634), (11, 1634), (13, 1634),
 (1, 1322), (8, 1322),
 (4, 900), (5, 900), (8, 900),
 
 -- AI generated data
 (1,3000),(2,3000),(8,3000),

(4,3001),(5,3001),(8,3001),

(6,3002),(7,3002),(10,3002),

(2002,3003),(2004,3003),(2005,3003),(2006,3003),

(2003,3004),(2007,3004),(2008,3004),

(2012,3005),(2004,3005),(2006,3005),

(2002,3006),(2004,3006),(2005,3006),

(2003,3007),(2007,3007),(2009,3007),

(8,3008),(10,3008),(2002,3008),(2003,3008),

(2011,3009),(2005,3009),(2006,3009),

(2001,3010),(2002,3010),(2003,3010),(2012,3010),

(8,3011),(3,3011),(2,3011),

(5,3012),(8,3012),(12,3012),

(2004,3013),(2006,3013),(2012,3013),

(2009,3014),(2003,3014),(2013,3014),

(2007,3015),(2013,3015),(2010,3015),

(6,3016),(10,3016),(11,3016),

(4,3017),(5,3017),(8,3017),

(2002,3018),(2003,3018),(2001,3018),

(2003,3019),(2007,3019),(2008,3019),(2009,3019),

(2001,3075),(2002,3075),(2003,3075),(13,3075),
(2006,3076),(2004,3076),(2012,3076),
(3,3077),(2,3077),(8,3077),
(2010,3078),(2007,3078),(2013,3078),
(2004,3079),(2006,3079),(2012,3079),

(4,3080),(5,3080),(8,3080),
(2009,3081),(2003,3081),(2013,3081),
(2001,3082),(2002,3082),(2003,3082),
(2006,3083),(2004,3083),(2012,3083),
(13,3084),(10,3084),(8,3084),(2001,3084),

(2011,3100),(2005,3100),(2006,3100),

(2003,3101),(2007,3101),(2013,3101),

(2004,3102),(2006,3102),(2012,3102),

(2001,3103),(2002,3103),(2003,3103),(2012,3103),

(4,3104),(5,3104),(12,3104),

(6,3105),(7,3105),(10,3105),

(2002,3106),(2004,3106),(2005,3106),(2006,3106),

(2007,3107),(2010,3107),(2013,3107),

(2,3108),(3,3108),(8,3108),

(2001,3109),(2002,3109),(2003,3109),(1405,3109),

(2004,3110),(2006,3110),(2012,3110),

(2009,3111),(2007,3111),(2003,3111),

(4,3112),(5,3112),(8,3112),

(2004,3113),(2006,3113),(2012,3113),

(2001,3114),(2002,3114),(2003,3114),(13,3114),

(2004, 3115), (2006, 3115)
;

INSERT INTO assigns(codename, cmpt_name, obj_id, task_no, std_emp_id, mngr_emp_id) VALUES

 ('Bear', 'Vehicle Frame', 12, 45, 7, 10),
 ('Bear', 'Structural', 2, 20, 6, 10),
 ('Bear', 'Electrical', 3, 18, 3, 8),
 ('Bear', 'Electrical', 3, 33, 3, 8),
 ('Bear', 'Electrical', 3, 52, 2, 8),
 ('Cobra', 'Electrical', 8, 5, 3, 8),
 ('Cobra', 'Power', 4, 31, 2, 8),
 ('Cobra', 'RF Electronics', 9, 51, 4, 8),
 ('Cobra', 'RF Electronics', 15, 45, 5, 8),
 
 -- AI generated data
 
 ('Orion','Lidar Perception',1,10,2005,2002),
 ('Orion','Lidar Perception',1,11,2006,2002),

 ('Orion','Navigation Algorithms',2,20,2004,2002),
 ('Orion','Navigation Algorithms',2,21,2006,2002),

 ('Orion','Cryogenic Battery Cooling',3,30,2007,2003),
 ('Orion','Cryogenic Battery Cooling',3,31,2010,2003),
 ('Orion','Cryogenic Battery Cooling',3,32,2009,2003)
;

INSERT INTO Distributes(codename, cmpt_name, obj_id, spvr_emp_id, team_id) VALUES
 ('Bear', 'Vehicle Frame', 12, 11, 8),
 ('Bear', 'Structural', 2, 11, 8),
 ('Bear', 'Electrical', 3, 9, 32),
 ('Cobra', 'Electrical', 8, 12, 32),
 ('Cobra', 'Power', 4, 12, 32),
 ('Cobra', 'RF Electronics', 9, 12, 21),
 ('Cobra', 'RF Electronics', 15, 12, 21),
 
 -- AI generated data
 ('Orion','Lidar Perception',1,2011,45),
 ('Orion','Navigation Algorithms',2,2012,45),

 ('Orion','Cryogenic Battery Cooling',3,2013,46)
;
