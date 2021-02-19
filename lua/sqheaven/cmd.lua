local vim = vim

local cmd = {
    name_connect = 'default',
    connect = vim.api.nvim_get_var('sqheaven_connections').default
}

--- extract
cmd.extract_lines = function(coordinates)
  local lines = vim.api.nvim_buf_get_lines(coordinates.bufnr, coordinates.from[1] - 1, coordinates.to[1], false)

  print(vim.inspect(lines))

  return lines
end

--- buid_command
cmd.build_command = function(query)
    local args = {
        user = '-U ' .. cmd.connect.user,
        pass = 'PGPASSWORD=' .. cmd.connect.password,
        host = '-h ' .. cmd.connect.host,
        database = '-d ' .. cmd.connect.database,
    }

    local command = string.format("%s psql %s %s %s -c \"%s\"", args.pass, args.host, args.user, args.database, query)
    return command
end

--- exec_query
cmd.exec_query = function(str_query)
    local command = cmd.build_command(str_query)
    return vim.api.nvim_call_function('systemlist', {
            command
        })
end

-- set_connect
cmd.set_connect = function(name_connect)
    cmd.name_connect = name_connect
    cmd.connect = vim.api.nvim_get_var('sqheaven_connections')[name_connect]
end

return cmd
