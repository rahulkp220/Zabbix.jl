module Zabbix

using Requests
using JSON

"""
Zabbix API

julia>z = ZabbixAPI("http://SERVER_URL/zabbix/api_jsonrpc.php","USERNAME","PASSWORD")
ZabbixAPI("http://SERVER_URL/zabbix/api_jsonrpc.php", "USERNAME", "PASSWORD", 1, Dict("Content-Type"=>"application/json-rpc"), "2.0")

"""
type ZabbixAPI

# To be supplied fields
server_url::String
username::String
password::String
id::Int64

# By default set fields
headers::Dict
jsonrpc::String

# Inner constructor
ZabbixAPI(server_url,username,password,id=1,headers=Dict("Content-Type"=>"application/json-rpc"),
jsonrpc="2.0") = new(server_url,username,password,id,headers,jsonrpc)

end


"""
Gets the apiinfo.version data from zabbix server

julia>api_version(z)
"3.2.11"

"""
function api_version(z::ZabbixAPI)

   # contruct data
   dict_data = Dict("jsonrpc"=>z.jsonrpc,"id"=>z.id,"method"=>"apiinfo.version","auth"=>nothing,"params"=>Dict())
   json_data = JSON.json(dict_data)

   # requests data from zabbix
   output = Requests.post(z.server_url,data=json_data,headers=z.headers)
   
   # return response
   JSON.parse(convert(String, output.data))["result"]
end



"""
Gets the authentication token from zabbix server

julia> auth_token(z)
"bc86891a1c6c9ef5d41d640eb258a81a"

"""
function auth_token(z::ZabbixAPI)

# construct data
dict_data=Dict("jsonrpc"=>z.jsonrpc,"id"=>z.id,"method"=>"user.login",
        "params"=>Dict("user"=>z.username,"password"=>z.password))
json_data = JSON.json(dict_data)

# requests data from zabbix
output = Requests.post(z.server_url,data=json_data,headers=z.headers)

# return token
JSON.parse(convert(String, output.data))["result"]

end



"""
Gets all host for a user

julia>get_all_hosts(z)
Dict{String,Any} with 3 entries:
  "id"      => 1
  "jsonrpc" => "2.0"
  "result"  => Any[Dict{String,Any}(Pair{String,Any}("host", "localhost"),Pair{…

"""
function get_all_hosts(z::ZabbixAPI)

# get token
token = auth_token(z)

# construct data
dict_data = Dict("jsonrpc"=>z.jsonrpc,"id"=>z.id,"method"=>"host.get","auth"=>token,
                    "params"=>Dict("output"=>["hostid","host"],"selectInterfaces"=>["interfaceid","ip"]))
json_data = JSON.json(dict_data)

# requests data from zabbix
output = Requests.post(z.server_url,data=json_data,headers=z.headers)

# return token
JSON.parse(convert(String, output.data))

end



"""
Make request to the zabbix server

For references on various methods available in Zabbix,
head over to https://www.zabbix.com/documentation/2.2/manual/api/reference
"""
function make_request(z::ZabbixAPI, method::String, params=Dict())
    if method == "apiinfo.version" && params == Dict()
        return api_version(z)
    else
        # get token
        token = auth_token(z)
        
        # construct data
        dict_data = Dict("jsonrpc"=>z.jsonrpc,"id"=>z.id,"method"=>method,"auth"=>token,"params"=>params)
        json_data = JSON.json(dict_data)

        # requests data from zabbix
        output = Requests.post(z.server_url,data=json_data,headers=z.headers)

        # increment the id for further calls
        setfield!(z,:id, z.id+1)
        
        # return token
        JSON.parse(convert(String, output.data))
    end
end


export ZabbixAPI, api_version, get_all_hosts, make_request

end
