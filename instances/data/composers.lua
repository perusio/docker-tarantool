--- Data for the composers database.
-- @script   composers.lua
-- @author António P. P. Almeida <appa@perusio.net>
--
--

local insert = table.insert
-- Avoid polluting the global environment.
-- If we are in Lua 5.1 this function exists.
if _G.setfenv then
  setfenv(1, {})
else -- Lua 5.2.
  _ENV = nil
end

-- Composers table.
local composers = {}

--- Inserts a given composer into the composers table.
--
-- @param composers table with all composers.
-- @param current_composer table the composer being added.
--
-- @return nothing
--   Side effects only.
--
local function add_composer(composers, current_composer)
  insert(composers, current_composer)
end

add_composer(composers,
             {
               name = 'Johann Sebastian Bach',
               birth = 1685,
               death =  1750,
               period = 'Baroque',
               country = 'Germany',
               compositions = {
                 'B Minor Mass, BWV 232',
                 'Goldberg Variations, BWV 988',
                 'Tocatta and Fuge, BWV 565',
                 'St. Matthew Passion, BWV 244',
               }
             }
            )

add_composer(composers,
             {
               name = 'Heinrich Ignaz Franz Biber',
               birth = 1644,
               death = 1704,
               period = 'Baroque',
               country = 'Austria',
               compositions = {
                 'Rosary Sonatas',
                 'Requiem à 15 in Concerto',
                 'Harmonia artificioso-ariosa: diversi modi accordata',
                 'Missa Salisburgensis',
               }
             }
            )

add_composer(composers,
             {
               name = 'Antonio Vivaldi',
               birth = 1678,
               death = 1741,
               period = 'Baroque',
               country = 'Italy',
               compositions = {
                 "L'estro Armonico",
                 "I'll cimento dell'armonia e dell'invenzione",
                 'Orlando Furioso',
                 'Nulla in mundo pax sincera',
               }
             }
            )

add_composer(composers,
             {
               name = 'Marin Marais',
               birth = 1656,
               death = 1728,
               period = 'Baroque',
               country = 'France',
               compositions = {
                 'Sonnerie de Sainte-Geneviève du Mont de Paris',
                 'Alcyone',
                 'Les Voix Humaines',
                 "Les Folies d'Espagne",
               }
             }
            )

add_composer(composers,
             {
               name = 'Jan Dismas Zelenka',
               birth = 1679,
               death = 1745,
               period = 'Baroque',
               country = 'Czech Republic',
               compositions = {
                 'Missa Dei Patris',
                 'Missa Sancti Josephi',
                 'Ave Regina coelorum',
                 'Il Diamante',
               }
             }
            )

add_composer(composers,
             {
               name = 'Gaspar Sainz',
               birth = 1640,
               death = 1710,
               period = 'Baroque',
               country = 'Spain',
               compositions = {
                 'Españoletas',
                 'Zarabanda',
                 'Canarios',
                 'La Coquina Francesa',
               }
             }
            )

add_composer(composers,
             {
               name = 'Carlos Seixas',
               birth = 1704,
               death = 1742,
               period = 'Baroque',
               country = 'Portugal',
               compositions = {
                 'Ouverture in B',
                 'Tantum Ergo',
                 'Concert in F',
                 'Sonatas for Harpsichord',
               }
             }
            )

return composers
