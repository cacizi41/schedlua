package.path = package.path..";../?.lua"

Scheduler = require("schedlua.scheduler")()
Kernel = require("schedlua.kernel")()
Task = require("schedlua.task")
local taskID = 0;


local function getNewTaskID()
    taskID = taskID + 1;
    return taskID;
end

local function coopP(priority, func, ...)
    local task = Task(func, ...)
    task.TaskID = getNewTaskID();
    task.Priority = priority;
    Scheduler:scheduleTaskP(task, {...});

    return task;
end

local function priority_comp( a,b )
   return a.Priority > b.Priority
end

local function task1()
    print("task1, take one")
    Kernel:yield();
    print("task1, take two")
end

local function task2()
    print("task2, take one")
    Kernel:yield();
    print("task2, take two")
end

local function task3()
    print("task3, take one")
    Kernel:yield();
    print("task3, take two")
end

local function main()
    local t1 = coopP(500, task1)
    local t2 = coopP(100, task2)
    local t3 = coopP(300, task3)


    while (true) do
        --print("STATUS: ", t1:getStatus(), t2:getStatus())
        if t1:getStatus() == "dead" and t2:getStatus() == "dead" then
            break;
        end
        Scheduler:step()
    end
end

main()