PRAGMA foreign_keys=ON;

-- create the N_numbers table
CREATE TABLE N_Numbers(
  n_number VARCHAR(6) PRIMARY KEY, -- the "licence plate" number
  serial_number VARCHAR(30),
  mfr_mdl_code VARCHAR(7) REFERENCES Aircraft_Types(atid),  -- manufacturer and model code, see
                            -- aircraft_types
  year_mfr VARCHAR(4),
  name VARCHAR(50),    -- name of entity that registered the aircraft
  street VARCHAR(40),  -- the following columns are their address
  street2 VARCHAR(40),
  city VARCHAR(20),    -- all-caps city, e.g. "SEATTLE".  Can be
                       -- concatenated with state to obtain
                       -- Flights.origin_city or Flights.dest_city
  state VARCHAR(2),    -- all-caps state code, e.g. "WA".  Can be
                       -- concatenated with city to obtain
                       -- Flights.origin_city or Flights.dest_city
  zip_code VARCHAR(10),
  region VARCHAR(1),
  county VARCHAR(3),
  country VARCHAR(2)
);

-- Create aircraft types table
CREATE TABLE Aircraft_Types(
  atid VARCHAR(7) PRIMARY KEY,         -- the id, used by the n_numbers table
  mfr VARCHAR(40),         -- name of the manufacturer
  model VARCHAR(30),       -- name of the model
  num_engines INT,         -- number of engines on this type
  num_seats INT,           -- max number of seats on this type;
                           -- sometimes called the aircraft's
                           -- "capacity".  Never null.
  weight_class VARCHAR(7), -- 1-indexed (1-4)
  avg_speed_mph INT        -- average cruising speed, miles per hour
);

-- create carriers table
CREATE TABLE Carriers(
    cid VARCHAR(8) PRIMARY KEY,     -- the id of the airline
    cname VARCHAR(100)  -- the full name of the airline
);

-- create cancelation codes
CREATE TABLE Cancellation_Codes(
    ccid VARCHAR(1) PRIMARY KEY,         -- the cancellation id
    description VARCHAR(20)  -- why the flight was cancelled
);

-- Create the flights table
CREATE TABLE Flights(
  fid INT PRIMARY KEY,                 -- unique id for each flight
  year INT,
  month INT,               -- 1-indexed (ie, 1-12)
  day_of_month INT,        -- 1-indexed (ie, 1-31)
  day_of_week INT,         -- 1-indexed (ie, 1-7). 1 = Monday,
                           -- 2 = Tuesday, etc
  cid VARCHAR(8) REFERENCES Carriers(cid),          -- id of the airline, see carriers (has foreign key)
  tail_num VARCHAR(6) REFERENCES N_Numbers(n_number),     -- the "license plate" of the aircraft (has foreign key);
                             -- see also N_Numbers table
  op_carrier_flight_num INT, -- carrier-specific flight number. NOT
                               -- unique; different carriers can each
                               -- have a flight numbered "123"
  origin VARCHAR(3),       -- airport code where flight started
  origin_city VARCHAR(40), -- "<city>, <state>", e.g. "Seattle, WA"
  origin_state VARCHAR(2),      
  dest VARCHAR(3),         -- airport code of destination
  dest_city VARCHAR(40),   -- "<city>, <state>", e.g. "Seattle, WA"
  dest_state VARCHAR(2), 
  sched_dep_time INT,      -- scheduled departure time
  dep_time INT,            -- actual departure time
  dep_delay REAL,
  sched_arr_time INT,      -- scheduled arrival time
  arr_time INT,            -- actual arrival time
  arr_delay REAL,
  cancelled INT,           -- 1 if flight was cancelled, else 0
  cancellation_code VARCHAR(1),-- reason for cancellation, or empty
                                 -- see cancellation_codes table
  duration_mins INT,
  distance_mi INT,
  price INT                -- in dollars
);