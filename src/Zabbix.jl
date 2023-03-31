module Zabbix

# Imports
using HTTP
using JSON

include("common.jl")
include("api.jl")
include("templates.jl")
include("hostgroups.jl")
include("hosts.jl")
include("items.jl")
include("history.jl")
include("triggers.jl")
include("users.jl")
include("server.jl")

end
