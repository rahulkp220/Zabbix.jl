export ZabbixItem, get_items

struct ZabbixItem
  id::Int
  name::String
end
ZabbixItem(dict) =
  ZabbixItem(
    parse(Int, dict["itemid"]),
    dict["name"]
  )

showres(i::ZabbixItem; offset=0) =
  println(repeat(" ", offset), "ZabbixItem: ", i.id, " => ", i.name)

function get_items(z, host::ZabbixHost)
  items = ZabbixItem[]
  params = Dict("hostids"=>host.id)
  _items = @checkerr make_request(z, "item.get", params)
  for i in _items
    push!(items, ZabbixItem(i))
  end
  items
end
