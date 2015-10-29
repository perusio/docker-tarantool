--- Defintion of a test database with Baroque composers for tarantool.
-- @script   composers.lua
-- @author António P. P. Almeida <appa@perusio.net>
-- @license MIT
--
--

-- Some local definitions.
local env = os.getenv
local format = string.format
-- Defaults for DB initialization.
local defaults = {
  listen = '3301',
  wal_dir = '/data/db',
  snap_dir = '/data/db',
  db_user = 'tarantool_user',
  db_password = 'some_password',
  db_name = 'composers',
}

-- Tarantool instance configuration.
box.cfg({
          listen = defaults.listen,
          wal_dir = defaults.wal_dir,
          snap_dir = defaults.snap_dir,
        })

local sch = box.schema
local spa = box.space
-- Add a user
local db_user = defaults.db_user
if sch.user.exists(db_user) then sch.user.drop(db_user) end
sch.user.create(db_user, { password = defaults.db_password })
-- Privileges.
sch.user.grant(db_user, 'read,write,execute', 'universe')

-- Create the DB.
local db_name = defaults.db_name
-- If it exists drop it first.
if type(spa[db_name]) == 'table' then spa[db_name]:drop() end
sch.space.create(db_name)

-- Get the data.
local composers = require 'data/composers'
-- Create the indexes.
-- 1. ID.
spa.composers:create_index('primary', { parts = { 1, 'NUM' }})
-- 2. Composers name is the secondary index.
spa.composers:create_index('name', { parts = { 2, 'STR' }, unique = true })
-- 3. Birth year
spa.composers:create_index('birth_year', { parts = { 3, 'NUM' }, unique = false })
-- 4. Death year.
spa.composers:create_index('death_year', { parts = { 4, 'NUM' }, unique = false })

-- Ingest the data.
local len = #composers
for i = 1, len do
  spa.composers:insert({ i, composers[i].name, composers[i].birth,
                         composers[i].death, composers[i].compositions })
end

--- Get a given composer chronology.
--
-- @param name string the composer name.
--
-- @return string or nil
--   Chronology as name: birth-death or nil.
function get_cronology_from_name(name)
  local record = spa.composers.index.name:select({ name })
  return #record ~= 0 and format('%s: %d-%d', name, record[1][3], record[1][4]) or nil
end
