local vim = vim

local cmd = require("sqheaven.cmd")
local ui = require("sqheaven.ui")

local sqheaven = {}

function sqheaven.start()
    ui.start(cmd.connect.sql_file)
end

function sqheaven.execLines()
    local coordinates = ui.motion(0)
    local lines = cmd.extract_lines(coordinates)
    local str_query = ""

    for _, line in pairs(lines) do
        str_query = str_query .. line .. "\n"
    end

    local result = cmd.exec_query(str_query)

    ui.show_win()

    ui.redraw(result)
end

function sqheaven.showDatabases()

end

function sqheaven.getTables()
    local result = cmd.exec_query('\\dt')
    local tables = ''
    for line_num, line in pairs(result) do
        if line_num > 2 then
            for k, v in string.gmatch(line, "|( +)([%w-.|_]+)( +)|") do
                tables = tables..v.."\n"
            end
        end
    end
    return tables
end

function sqheaven.showTables()
    local result = cmd.exec_query('\\dt')
    ui.show_win()
    ui.redraw(result)
end

function sqheaven.descTable(table_name)
    local result = cmd.exec_query('\\d '..table_name)
    ui.show_win()
    ui.redraw(result)
end

function sqheaven.switchConnect(name_connect)
    if name_connect == nil then
        print('Connection not found!')
        return
    end

    cmd.set_connect(name_connect)
    ui.change_query_file(cmd.connect.sql_file)
    sqheaven.showConnect()
end

function sqheaven.showConnect()
    print('Current connection: ' .. cmd.name_connect)
end

return sqheaven
