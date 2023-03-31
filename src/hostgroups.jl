export ZabbixHostgroup, get_hostgroups

struct ZabbixHostgroup
  id::Int
  name::String
end
ZabbixHostgroup(dict) =
  ZabbixHostgroup(
    parse(Int, dict["groupid"]),
    dict["name"]
  )

showres(h::ZabbixHostgroup; offset=0) =
  println(repeat(" ", offset), "ZabbixHostgroup: ", h.id, " => ", h.name)

function get_hostgroups(z)
  _hostgroups = @checkerr make_request(z, "hostgroup.get")
  hostgroups = ZabbixHostgroup[]
  for h in _hostgroups
    push!(hostgroups, ZabbixHostgroup(h))
  end
  hostgroups
end
