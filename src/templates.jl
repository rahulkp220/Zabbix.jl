export ZabbixTemplate, get_templates

struct ZabbixTemplate
  id::Int
  name::String
end
ZabbixTemplate(dict) =
  ZabbixTemplate(
    parse(Int, dict["templateid"]),
    dict["name"]
  )

showres(t::ZabbixTemplate; offset=0) =
  println(repeat(" ", offset), "ZabbixTemplate: ", t.id, " => ", t.name)

function get_templates(z)
  _templates = @checkerr make_request(z, "template.get")
  templates = ZabbixTemplate[]
  for t in _templates
    push!(templates, ZabbixTemplate(t))
  end
  templates
end
