export ZabbixHost, get_hosts

struct ZabbixHost
  id::Int
  name::String
end
ZabbixHost(dict) =
  ZabbixHost(
    parse(Int, dict["hostid"]),
    dict["name"]
  )

showres(h::ZabbixHost; offset=0) =
  println(repeat(" ", offset), "ZabbixHost: ", h.id, " => ", h.name)

function get_hosts(z)
  _hosts = @checkerr make_request(z, "host.get")
  hosts = ZabbixHost[]
  for h in _hosts
    push!(hosts, ZabbixHost(h))
  end
  hosts
end
