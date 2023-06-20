--# selene: allow(unused_variable)
---@diagnostic disable: unused-local

-- Make the `control` key more useful: If the `control` key is tapped, treat it
-- as the `escape` key. If the `control` key is held down and used in
-- combination with another key, then provide the normal `control` key
-- behavior.
---@class spoon.ControlEscape
local M = {}
spoon.ControlEscape = M

-- Start sending `escape` when `control` is pressed and released in isolation
function M:start() end

-- Stop sending `escape` when `control` is pressed and released in isolation
function M:stop() end

