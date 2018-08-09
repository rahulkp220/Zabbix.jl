using Zabbix
using Test

z = Zabbix.ZabbixAPI("https://www.example.com/zabbix/api_jsonrpc.php","username","password") 
@test typeof(z) == ZabbixAPI
