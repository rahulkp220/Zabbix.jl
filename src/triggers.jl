export ZabbixTrigger, get_triggers

struct ZabbixTrigger
  id::Int
  description::String
  expression::String
end
ZabbixTrigger(dict) =
  ZabbixTrigger(
    parse(Int, dict["triggerid"]),
    dict["description"],
    dict["expression"],
  )

showres(t::ZabbixTrigger; offset=0) =
  println(repeat(" ", offset), "ZabbixTrigger: ", t.id, " => ", t.description)

function get_triggers(z, host::ZabbixHost)
  triggers = ZabbixTrigger[]
  _triggers = @checkerr make_request(z, "trigger.get", Dict("hostids"=>host.id))
  for t in _triggers
    push!(triggers, ZabbixTrigger(t))
  end
  triggers
end
