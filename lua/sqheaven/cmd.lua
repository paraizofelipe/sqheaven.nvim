local vim = vim

local cmd = {}

--- extract
cmd.extract_lines = function(coordinates)
  local lines = vim.api.nvim_buf_get_lines(coordinates.bufnr, coordinates.from[1] - 1, coordinates.to[1], false)

  return lines
end

--- buid_command
cmd.build_command = function(query)
    local connect = vim.api.nvim_get_var('sqheaven_connections').default

    local args = {
        user = '-U ' .. connect.user,
        pass = 'PGPASSWORD=' .. connect.password,
        host = '-h ' .. connect.host,
        database = '-d ' .. connect.database,
    }

    local command = string.format("%s psql %s %s %s -c \"%s\"", args.pass, args.host, args.user, args.database, query)
    return command
end

cmd.exec_query = function(str_query)
    local command = cmd.build_command(str_query)
    return vim.api.nvim_call_function('systemlist', {
            command
        })
end

return cmd
