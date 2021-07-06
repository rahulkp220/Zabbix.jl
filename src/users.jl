export ZabbixUser, get_users

struct ZabbixUser
  id::Int
  name::String
  surname::String
  alias::String
  _type::Int
  theme::String
end
ZabbixUser(dict) =
  ZabbixUser(
    parse(Int, dict["userid"]),
    dict["name"],
    dict["surname"],
    dict["alias"],
    parse(Int, dict["type"]),
    dict["theme"],
  )

function showres(u::ZabbixUser; offset=0)
  print(repeat(" ", offset), "ZabbixUser: ", u.id, " => ")
  if u.name != ""
    if u.surname != "" && u.name != u.surname
      print(u.surname, ", ")
    end
    print(u.name)
  else
    print(u.alias)
  end
  println()
end

function get_users(z)
  # TODO: getAccess
  _users = @checkerr make_request(z, "user.get")
  users = ZabbixUser[]
  for u in _users
    push!(users, ZabbixUser(u))
  end
  users
end
