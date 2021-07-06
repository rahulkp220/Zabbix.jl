export ZabbixServer, get_server

struct ZabbixServer
  templates::Vector{ZabbixTemplate}
  hostgroups::Vector{ZabbixHostgroup}
  hosts::Vector{ZabbixHost}
end

function showres(s::ZabbixServer; offset=0)
  println("ZabbixServer:")
  for t in s.templates
    showres(t; offset=offset+1)
  end
  for h in s.hostgroups
    showres(h; offset=offset+1)
  end
  for h in s.hosts
    showres(h; offset=offset+1)
  end
end

function get_server(z)
  # Templates
  templates = get_templates(z)

  # Host groups
  hostgroups = get_hostgroups(z)

  # Hosts
  hosts = get_hosts(z)
  for host in hosts
    # Items
    items = get_items(z, host)

    # Triggers
    triggers = get_triggers(z, host)

    break
  end

  # Users
  users = get_users(z)
  @showres users
  exit()

  ZabbixServer(
    templates,
    hostgroups,
    hosts,
  )
end
