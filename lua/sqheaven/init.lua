local vim = vim

local cmd = require("sqheaven.cmd")
local ui = require("sqheaven.ui")

local sqheaven = {}


function sqheaven.execLines()
    local coordinates = ui.motion(0)
    local lines = cmd.extract_lines(coordinates)
    local str_query = ""

    for _, line in pairs(lines) do
        str_query = str_query .. line
    end

    local result = cmd.exec_query(str_query)

    ui.show_win()

    ui.redraw(result)
end

return sqheaven
