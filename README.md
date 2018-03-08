[![Build Status](https://travis-ci.org/rahulkp220/Zabbix.jl.svg?branch=master)](https://travis-ci.org/rahulkp220/Zabbix.jl)
[![codecov.io](http://codecov.io/github/rahulkp220/Zabbix.jl/coverage.svg?branch=master)](http://codecov.io/github/rahulkp220/Zabbix.jl?branch=master)

# Zabbix.jl 
Julia API for Zabbix :ghost:

## Installation
```julia
Pkg.clone("https://github.com/rahulkp220/Zabbix.jl.git")
using Zabbix
```

## Usage

* Creating a ZabbixAPI instance
```julia
julia> zabbix = Zabbix.ZabbixAPI("http://SERVER_IP/zabbix/api_jsonrpc.php","USERNAME","******")
Zabbix.ZabbixAPI("http://SERVER_IP/zabbix/api_jsonrpc.php", "USERNAME", "******", 1, Dict("Content-Type"=>"application/json-rpc"), "2.0")
```

* Get the Zabbix API's version Info
```julia
julia> Zabbix.api_version(zabbix)
"3.2.11"
```

* Get the auth token
```julia
julia> Zabbix.auth_token(zabbix)
"e8f8354d66f7fac2691f5c7441b8dfa0"
```

* Get all hosts for a user
```julia
julia> Zabbix.get_all_hosts(zabbix)
Dict{String,Any} with 3 entries:
  "id"      => 1
  "jsonrpc" => "2.0"
  "result"  => Any[Dict{String,Any}(Pair{String,Any}("host", "localhost"),Pair{String,Any}("interfaces", Any[Dict{String,Any}(Pair{String,An…
```

* Make any request to the zabbix server

The `make_request` function requires you to pass `methods`(aka Zabbix methods like `hosts.get` etc) and params ie.
parameters in a form of a Dict() object. A easy sample is given on Zabbix's official [website](https://www.zabbix.com/documentation/2.2/manual/api)
```julia
julia> Zabbix.make_request(zabbix, "apiinfo.version", Dict())
"3.2.11"
```


