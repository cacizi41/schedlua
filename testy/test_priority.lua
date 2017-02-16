package.path = "../?.lua;"..package.path

local queue = require("schedlua.queue")
local tutils = require("schedlua.tabutils")
local Scheduler = require("schedlua.scheduler")()
local Task = require("schedlua.task")

local q1 = queue();

--print("Q Length (0): ", q1:length())


local t1 = {Priority = 1000, TimePriority = 2000,  name = "A"}
local t2 = {Priority = 500, TimePriority = 1000, name = "B"}
local t3 = {Priority = 200, TimePriority = 500, name = "C"}
local t4 = {Priority = 550, TimePriority = 400, name = "D"}
local t5 = {Priority = 650, TimePriority = 2000, name = "E"}
local t6 = {Priority = 800, TimePriority = 1000, name = "F"}



local function priority_comp( a,b )
    a.pscore = 0.8*a['Priority'] + 0.2*a['TimePriority']
    b.pscore = 0.8*b['Priority'] + 0.2*b['TimePriority']
   return a.pscore < b.pscore
end

q1:pinsert(t1, priority_comp);
q1:pinsert(t2, priority_comp);
q1:pinsert(t3, priority_comp);
q1:pinsert(t4, priority_comp);
q1:pinsert(t5, priority_comp);
q1:pinsert(t6, priority_comp);


print("Q Length : ", q1.first, q1.last, q1:length())


for entry in q1:Entries() do
    print("Entry: ", entry.pscore, entry.name)
end
