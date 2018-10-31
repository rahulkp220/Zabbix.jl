export ZabbixHistory, get_history

struct ZabbixHistory
  id::Int
  name::String
end
ZabbixHistory(dict) =
  ZabbixHistory(
    parse(Int, dict["historyid"]),
    dict["name"]
  )

showres(h::ZabbixHistory; offset=0) =
  println(repeat(" ", offset), "ZabbixHistory: ", h.id, " => ", h.name)

function get_history(z, item::ZabbixItem)
  history = ZabbixHistory[]
  params = Dict("itemids"=>item.id)
  _history = @checkerr make_request(z, "history.get", params)
  for h in _history
    push!(history, ZabbixHistory(h))
  end
  history
end
