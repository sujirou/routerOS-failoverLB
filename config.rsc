/interface bridge
add name=bridge-trunk protocol-mode=none vlan-filtering=yes
/interface ethernet
set [ find default-name=ether1 ] name=ether1-pldt
set [ find default-name=ether2 ] name=ether2-starlink
/interface vlan
add interface=bridge-trunk name=vlan201-hotspot vlan-id=201
add interface=bridge-trunk name=vlan202-pppoe vlan-id=202
/interface list
add name=WAN
add name=LAN
/ip hotspot profile
add dns-name=jnt2.local hotspot-address=10.10.201.1 html-directory=hotspot name=hsprof1
/ip hotspot user profile
set [ find default=yes ] on-login=":put (\",,0,,,noexp,Disable,\")" parent-queue=none
/ip pool
add name=pool-hotspot ranges=10.10.201.10-10.10.201.254
add name=pool-mgmt ranges=10.10.100.10-10.10.100.50
add name=pool-pppoe ranges=10.10.202.10-10.10.202.254
/ip dhcp-server
add address-pool=pool-hotspot interface=vlan201-hotspot name=dhcp-hs201
add address-pool=pool-mgmt interface=bridge-trunk name=dhcp-mgmt
/ip hotspot
add address-pool=pool-hotspot disabled=no interface=vlan201-hotspot name=hotspot1 profile=hsprof1
/queue type
add cake-diffserv=besteffort cake-nat=yes kind=cake name=cake-rx
add cake-diffserv=besteffort cake-nat=yes kind=cake name=cake-tx
/queue simple
add max-limit=50M/50M name=Global-CAKE queue=cake-tx/cake-rx target=10.10.201.0/24,10.10.202.0/24 total-queue=default
/ip hotspot user profile
add address-pool=pool-hotspot name=1min-test on-login=":put (\",remc,0,1m,0,,Enable,\"); {:local comment [ /ip hotspot user get [/ip hotspot user find where name=\"\$user\"] comment]\
    ; :local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ :local date [ /system clock get date ];:local year [ :pick \$date 0 4 ];:\
    local month [ :pick \$date 5 7 ]; /sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"1m\"; :delay 5s; :local exp [ /sys sch get [ /sys sch find where name=\"\$u\
    ser\" ] next-run]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\$year \$t\"); /\
    ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\$date \$exp\" [find where name=\"\$user\"];}; :if (\$\
    getxp > 15) do={ /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];};:delay 5s; /sys sch remove [find where name=\"\$user\"]; :local mac \$\"mac-address\"; :loc\
    al time [/system clock get time ]; /system script add name=\"\$date-|-\$time-|-\$user-|-0-|-\$address-|-\$mac-|-1m-|-1min-test-|-\$comment\" owner=\"\$month\$year\" source=\"\$da\
    te\" comment=\"mikhmon\"; [:local mac \$\"mac-address\"; /ip hotspot user set mac-address=\$mac [find where name=\$user]]}}" parent-queue=Global-CAKE rate-limit=10M/10M
add address-pool=pool-hotspot name=2d-val-2d on-login=":put (\",rem,30.00,2d,30.00,,Disable,\"); {:local comment [ /ip hotspot user get [/ip hotspot user find where name=\"\$user\"] \
    comment]; :local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ :local date [ /system clock get date ];:local year [ :pick \$date\
    \_0 4 ];:local month [ :pick \$date 5 7 ]; /sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"2d\"; :delay 5s; :local exp [ /sys sch get [ /sys sch find where n\
    ame=\"\$user\" ] next-run]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\$year \
    \$t\"); /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\$date \$exp\" [find where name=\"\$user\"];}\
    ; :if (\$getxp > 15) do={ /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];};:delay 5s; /sys sch remove [find where name=\"\$user\"]}}" parent-queue=\
    Global-CAKE rate-limit=5M/5M
add address-pool=pool-hotspot name=5p-2h-4d on-login=":put (\",rem,5,4d,5,,Disable,\"); {:local comment [ /ip hotspot user get [/ip hotspot user find where name=\"\$user\"] comment];\
    \_:local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ :local date [ /system clock get date ];:local year [ :pick \$date 0 4 ];:\
    local month [ :pick \$date 5 7 ]; /sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"4d\"; :delay 5s; :local exp [ /sys sch get [ /sys sch find where name=\"\$u\
    ser\" ] next-run]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\$year \$t\"); /\
    ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\$date \$exp\" [find where name=\"\$user\"];}; :if (\$\
    getxp > 15) do={ /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];};:delay 5s; /sys sch remove [find where name=\"\$user\"]}}" parent-queue=Global-CAKE \
    rate-limit=5M/5M
add address-pool=pool-hotspot name=10p-4h-4d on-login=":put (\",rem,10,4d,10,,Disable,\"); {:local comment [ /ip hotspot user get [/ip hotspot user find where name=\"\$user\"] commen\
    t]; :local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ :local date [ /system clock get date ];:local year [ :pick \$date 0 4 ]\
    ;:local month [ :pick \$date 5 7 ]; /sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"4d\"; :delay 5s; :local exp [ /sys sch get [ /sys sch find where name=\"\
    \$user\" ] next-run]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\$year \$t\")\
    ; /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\$date \$exp\" [find where name=\"\$user\"];}; :if \
    (\$getxp > 15) do={ /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];};:delay 5s; /sys sch remove [find where name=\"\$user\"]}}" parent-queue=Global-CAKE \
    rate-limit=5M/5M
add address-pool=pool-hotspot name=D10 on-login=":put (\",rem,10,1d,10,,Disable,\"); {:local comment [ /ip hotspot user get [/ip hotspot user find where name=\"\$user\"] comment]; :l\
    ocal ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ :local date [ /system clock get date ];:local year [ :pick \$date 0 4 ];:loca\
    l month [ :pick \$date 5 7 ]; /sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"1d\"; :delay 5s; :local exp [ /sys sch get [ /sys sch find where name=\"\$user\
    \" ] next-run]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\$year \$t\"); /ip \
    hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\$date \$exp\" [find where name=\"\$user\"];}; :if (\$get\
    xp > 15) do={ /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];};:delay 5s; /sys sch remove [find where name=\"\$user\"]}}" parent-queue=Global-CAKE \
    rate-limit=4M/4M
add address-pool=pool-hotspot name=wavlink-hotspot on-login=":put (\",rem,30,3d,30,,Disable,\"); {:local comment [ /ip hotspot user get [/ip hotspot user find where name=\"\$user\"] \
    comment]; :local ucode [:pic \$comment 0 2]; :if (\$ucode = \"vc\" or \$ucode = \"up\" or \$comment = \"\") do={ :local date [ /system clock get date ];:local year [ :pick \$date\
    \_0 4 ];:local month [ :pick \$date 5 7 ]; /sys sch add name=\"\$user\" disable=no start-date=\$date interval=\"3d\"; :delay 5s; :local exp [ /sys sch get [ /sys sch find where n\
    ame=\"\$user\" ] next-run]; :local getxp [len \$exp]; :if (\$getxp = 15) do={ :local d [:pic \$exp 0 6]; :local t [:pic \$exp 7 16]; :local s (\"/\"); :local exp (\"\$d\$s\$year \
    \$t\"); /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];}; :if (\$getxp = 8) do={ /ip hotspot user set comment=\"\$date \$exp\" [find where name=\"\$user\"];}\
    ; :if (\$getxp > 15) do={ /ip hotspot user set comment=\"\$exp\" [find where name=\"\$user\"];};:delay 5s; /sys sch remove [find where name=\"\$user\"]}}" parent-queue=\
    Global-CAKE rate-limit=5M/5M
/ppp profile
add comment="default 10Mbps PPPoE plan" dns-server=1.1.1.1,8.8.8.8 local-address=10.10.202.1 name=profile-pppoe parent-queue=Global-CAKE rate-limit=10M/10M remote-address=pool-pppoe
add dns-server=1.1.1.1,8.8.8.8 local-address=10.10.202.1 name=8mb parent-queue=Global-CAKE rate-limit=8M/8M remote-address=pool-pppoe
add dns-server=1.1.1.1,8.8.8.8 local-address=10.10.202.1 name=30mb/20mb parent-queue=Global-CAKE rate-limit=30mb/20mb remote-address=pool-pppoe
/routing table
add fib name=to_WAN1
add fib name=to_WAN2
/interface bridge port
add bridge=bridge-trunk comment="Trunk Port 1" interface=ether3
add bridge=bridge-trunk comment="Trunk Port 2" interface=ether4
/interface bridge vlan
add bridge=bridge-trunk tagged=bridge-trunk,ether3,ether4 vlan-ids=201
add bridge=bridge-trunk tagged=bridge-trunk,ether3,ether4 vlan-ids=202
/interface list member
add interface=ether1-pldt list=WAN
add interface=ether2-starlink list=WAN
add interface=vlan201-hotspot list=LAN
add interface=vlan202-pppoe list=LAN
add interface=ether4 list=WAN
add interface=ether5 list=WAN
/interface pppoe-server server
add default-profile=profile-pppoe disabled=no interface=vlan202-pppoe one-session-per-host=yes service-name=pppoe-service
/ip address
add address=10.10.201.1/24 interface=vlan201-hotspot network=10.10.201.0
add address=10.10.100.1/24 interface=bridge-trunk network=10.10.100.0
/ip dhcp-client
add default-route-tables=main interface=ether1-pldt script=\
    ":if (\$bound=1) do={ /ip route set [find comment=\"PLDT_GW\"] gateway=\$\"gateway-address\" disabled=no } else={ /ip route set [find comment=\"PLDT_GW\"] disabled=yes }" \
    use-peer-dns=no use-peer-ntp=no
add add-default-route=no default-route-tables=main interface=ether2-starlink script=":if (\$bound=1) do={ /ip route set [find comment=\"Starlink_GW\"] gateway=\$\"gateway-address\" d\
    isabled=no } else={ /ip route set [find comment=\"Starlink_GW\"] disabled=yes }" use-peer-dns=no use-peer-ntp=no
/ip dhcp-server network
add address=10.10.100.0/24 comment="Management Network" dns-server=10.10.100.1 gateway=10.10.100.1
add address=10.10.201.0/24 dns-server=10.10.201.1 gateway=10.10.201.1
/ip dns
set allow-remote-requests=yes servers=8.8.8.8,8.8.4.4
/ip firewall address-list
add address=10.10.201.0/24 list=local_subnets
add address=10.10.202.0/24 list=local_subnets
add address=10.10.100.0/24 list=local_subnets
/ip firewall filter
add action=passthrough chain=unused-hs-chain comment="place hotspot rules here" disabled=yes
/ip firewall mangle
add action=accept chain=prerouting dst-address-list=local_subnets in-interface-list=LAN
add action=mark-connection chain=input in-interface=ether1-pldt new-connection-mark=WAN1_conn
add action=mark-connection chain=input in-interface=ether2-starlink new-connection-mark=WAN2_conn
add action=mark-routing chain=output connection-mark=WAN1_conn new-routing-mark=to_WAN1 passthrough=no
add action=mark-routing chain=output connection-mark=WAN2_conn new-routing-mark=to_WAN2 passthrough=no
add action=mark-connection chain=prerouting connection-state=new dst-address-list=!local_subnets in-interface-list=LAN new-connection-mark=WAN1_conn per-connection-classifier=\
    src-address:4/0
add action=mark-connection chain=prerouting connection-state=new dst-address-list=!local_subnets in-interface-list=LAN new-connection-mark=WAN1_conn per-connection-classifier=\
    src-address:4/1
add action=mark-connection chain=prerouting connection-state=new dst-address-list=!local_subnets in-interface-list=LAN new-connection-mark=WAN1_conn per-connection-classifier=\
    src-address:4/2
add action=mark-connection chain=prerouting connection-state=new dst-address-list=!local_subnets in-interface-list=LAN new-connection-mark=WAN2_conn per-connection-classifier=\
    src-address:4/3
add action=mark-routing chain=prerouting connection-mark=WAN1_conn in-interface-list=LAN new-routing-mark=to_WAN1 passthrough=no
add action=mark-routing chain=prerouting connection-mark=WAN2_conn in-interface-list=LAN new-routing-mark=to_WAN2 passthrough=no
add action=mark-connection chain=output dst-address=1.1.1.1 new-connection-mark=WAN2_conn
add action=mark-routing chain=output connection-mark=WAN2_conn dst-address=1.1.1.1 new-routing-mark=to_WAN2 passthrough=no
add action=mark-connection chain=output dst-address-list=!local_subnets new-connection-mark=WAN1_conn out-interface=ether1-pldt
add action=mark-connection chain=output dst-address-list=!local_subnets new-connection-mark=WAN2_conn out-interface=ether2-starlink
add action=mark-routing chain=output connection-mark=WAN1_conn new-routing-mark=to_WAN1 passthrough=no
add action=mark-routing chain=output connection-mark=WAN2_conn new-routing-mark=to_WAN2 passthrough=no
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment="place hotspot rules here" disabled=yes
add action=masquerade chain=srcnat comment="NAT for Dual WAN" out-interface-list=WAN
/ip hotspot user
add name=admin
/ip route
add comment=PLDT_GW disabled=no dst-address=8.8.8.8/32 gateway=192.168.160.1 routing-table=to_WAN1 scope=10
add comment=Starlink_GW disabled=no dst-address=1.1.1.1/32 gateway=192.168.170.1 routing-table=to_WAN2 scope=10
add dst-address=192.168.160.0/24 gateway=ether1-pldt routing-table=to_WAN1
add dst-address=192.168.170.0/24 gateway=ether2-starlink routing-table=to_WAN2
add check-gateway=ping distance=2 dst-address=0.0.0.0/0 gateway=192.168.170.1
add check-gateway=ping dst-address=0.0.0.0/0 gateway=192.168.160.1 routing-table=to_WAN1
add check-gateway=ping dst-address=0.0.0.0/0 gateway=192.168.170.1 routing-table=to_WAN2
add dst-address=8.8.8.8/32 gateway=192.168.160.1 routing-table=to_WAN1
add dst-address=8.8.8.8/32 gateway=192.168.170.1 routing-table=to_WAN2
/ip service
set telnet disabled=yes
set www disabled=yes
/ppp secret
add name=ppptest profile=profile-pppoe service=pppoe
/system logging
add action=disk prefix=-> topics=hotspot,info,debug
/system ntp client
set enabled=yes
/system ntp client servers
add address=ph.pool.ntp.org
add address=pool.ntp.org
/system scheduler
add comment="Monitor Profile 1min-test" interval=2m18s name=1min-test on-event=":local dateint do={:local montharray ( \"01\",\"02\",\"03\",\"04\",\"05\",\"06\",\"07\",\"08\",\"09\",\
    \"10\",\"11\",\"12\" );:local days [ :pick \$d 8 10 ];:local month [ :pick \$d 5 7 ];:local year [ :pick \$d 0 4 ];:local monthint ([ :find \$montharray \$month]);:local month (\
    \$monthint + 1);:if ( [len \$month] = 1) do={:local zero (\"0\");:return [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\$year\$month\$days\")];}}; :local ti\
    meint do={ :local hours [ :pick \$t 0 2 ]; :local minutes [ :pick \$t 3 5 ]; :return (\$hours * 60 + \$minutes) ; }; :local date [ /system clock get date ]; :local time [ /system\
    \_clock get time ]; :local today [\$dateint d=\$date] ; :local curtime [\$timeint t=\$time] ; :foreach i in [ /ip hotspot user find where profile=\"1min-test\" ] do={ :local comm\
    ent [ /ip hotspot user get \$i comment]; :local name [ /ip hotspot user get \$i name]; :local gettime [:pic \$comment 11 19]; :if ([:pic \$comment 4] = \"-\" and [:pic \$comment \
    7] = \"-\") do={:local expd [\$dateint d=\$comment] ; :local expt [\$timeint t=\$gettime] ; :if ((\$expd < \$today and \$expt < \$curtime) or (\$expd < \$today and \$expt > \$cur\
    time) or (\$expd = \$today and \$expt < \$curtime)) do={ [ /ip hotspot user remove \$i ]; [ /ip hotspot active remove [find where user=\$name] ];}}}" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2025-12-17 start-time=05:41:41
add comment="Monitor Profile 2d-val-2d" interval=2m25s name=2d-val-2d on-event=":local dateint do={:local montharray ( \"01\",\"02\",\"03\",\"04\",\"05\",\"06\",\"07\",\"08\",\"09\",\
    \"10\",\"11\",\"12\" );:local days [ :pick \$d 8 10 ];:local month [ :pick \$d 5 7 ];:local year [ :pick \$d 0 4 ];:local monthint ([ :find \$montharray \$month]);:local month (\
    \$monthint + 1);:if ( [len \$month] = 1) do={:local zero (\"0\");:return [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\$year\$month\$days\")];}}; :local ti\
    meint do={ :local hours [ :pick \$t 0 2 ]; :local minutes [ :pick \$t 3 5 ]; :return (\$hours * 60 + \$minutes) ; }; :local date [ /system clock get date ]; :local time [ /system\
    \_clock get time ]; :local today [\$dateint d=\$date] ; :local curtime [\$timeint t=\$time] ; :foreach i in [ /ip hotspot user find where profile=\"2d-val-2d\" ] do={ :local comm\
    ent [ /ip hotspot user get \$i comment]; :local name [ /ip hotspot user get \$i name]; :local gettime [:pic \$comment 11 19]; :if ([:pic \$comment 4] = \"-\" and [:pic \$comment \
    7] = \"-\") do={:local expd [\$dateint d=\$comment] ; :local expt [\$timeint t=\$gettime] ; :if ((\$expd < \$today and \$expt < \$curtime) or (\$expd < \$today and \$expt > \$cur\
    time) or (\$expd = \$today and \$expt < \$curtime)) do={ [ /ip hotspot user remove \$i ]; [ /ip hotspot active remove [find where user=\$name] ];}}}" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2025-12-17 start-time=03:46:14
add comment="Monitor Profile 5p-2h-4d" interval=2m47s name=5p-2h-4d on-event=":local dateint do={:local montharray ( \"01\",\"02\",\"03\",\"04\",\"05\",\"06\",\"07\",\"08\",\"09\",\"\
    10\",\"11\",\"12\" );:local days [ :pick \$d 8 10 ];:local month [ :pick \$d 5 7 ];:local year [ :pick \$d 0 4 ];:local monthint ([ :find \$montharray \$month]);:local month (\$m\
    onthint + 1);:if ( [len \$month] = 1) do={:local zero (\"0\");:return [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\$year\$month\$days\")];}}; :local timei\
    nt do={ :local hours [ :pick \$t 0 2 ]; :local minutes [ :pick \$t 3 5 ]; :return (\$hours * 60 + \$minutes) ; }; :local date [ /system clock get date ]; :local time [ /system cl\
    ock get time ]; :local today [\$dateint d=\$date] ; :local curtime [\$timeint t=\$time] ; :foreach i in [ /ip hotspot user find where profile=\"5p-2h-4d\" ] do={ :local comment [\
    \_/ip hotspot user get \$i comment]; :local name [ /ip hotspot user get \$i name]; :local gettime [:pic \$comment 11 19]; :if ([:pic \$comment 4] = \"-\" and [:pic \$comment 7] =\
    \_\"-\") do={:local expd [\$dateint d=\$comment] ; :local expt [\$timeint t=\$gettime] ; :if ((\$expd < \$today and \$expt < \$curtime) or (\$expd < \$today and \$expt > \$curtim\
    e) or (\$expd = \$today and \$expt < \$curtime)) do={ [ /ip hotspot user remove \$i ]; [ /ip hotspot active remove [find where user=\$name] ];}}}" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2025-12-17 start-time=05:16:44
add comment="Monitor Profile 10p-4h-4d" interval=2m52s name=10p-4h-4d on-event=":local dateint do={:local montharray ( \"01\",\"02\",\"03\",\"04\",\"05\",\"06\",\"07\",\"08\",\"09\",\
    \"10\",\"11\",\"12\" );:local days [ :pick \$d 8 10 ];:local month [ :pick \$d 5 7 ];:local year [ :pick \$d 0 4 ];:local monthint ([ :find \$montharray \$month]);:local month (\
    \$monthint + 1);:if ( [len \$month] = 1) do={:local zero (\"0\");:return [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\$year\$month\$days\")];}}; :local ti\
    meint do={ :local hours [ :pick \$t 0 2 ]; :local minutes [ :pick \$t 3 5 ]; :return (\$hours * 60 + \$minutes) ; }; :local date [ /system clock get date ]; :local time [ /system\
    \_clock get time ]; :local today [\$dateint d=\$date] ; :local curtime [\$timeint t=\$time] ; :foreach i in [ /ip hotspot user find where profile=\"10p-4h-4d\" ] do={ :local comm\
    ent [ /ip hotspot user get \$i comment]; :local name [ /ip hotspot user get \$i name]; :local gettime [:pic \$comment 11 19]; :if ([:pic \$comment 4] = \"-\" and [:pic \$comment \
    7] = \"-\") do={:local expd [\$dateint d=\$comment] ; :local expt [\$timeint t=\$gettime] ; :if ((\$expd < \$today and \$expt < \$curtime) or (\$expd < \$today and \$expt > \$cur\
    time) or (\$expd = \$today and \$expt < \$curtime)) do={ [ /ip hotspot user remove \$i ]; [ /ip hotspot active remove [find where user=\$name] ];}}}" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2025-12-17 start-time=02:47:20
add comment="Monitor Profile D10" interval=2m44s name=D10 on-event=":local dateint do={:local montharray ( \"01\",\"02\",\"03\",\"04\",\"05\",\"06\",\"07\",\"08\",\"09\",\"10\",\"11\
    \",\"12\" );:local days [ :pick \$d 8 10 ];:local month [ :pick \$d 5 7 ];:local year [ :pick \$d 0 4 ];:local monthint ([ :find \$montharray \$month]);:local month (\$monthint +\
    \_1);:if ( [len \$month] = 1) do={:local zero (\"0\");:return [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\$year\$month\$days\")];}}; :local timeint do={ \
    :local hours [ :pick \$t 0 2 ]; :local minutes [ :pick \$t 3 5 ]; :return (\$hours * 60 + \$minutes) ; }; :local date [ /system clock get date ]; :local time [ /system clock get \
    time ]; :local today [\$dateint d=\$date] ; :local curtime [\$timeint t=\$time] ; :foreach i in [ /ip hotspot user find where profile=\"D10\" ] do={ :local comment [ /ip hotspot \
    user get \$i comment]; :local name [ /ip hotspot user get \$i name]; :local gettime [:pic \$comment 11 19]; :if ([:pic \$comment 4] = \"-\" and [:pic \$comment 7] = \"-\") do={:l\
    ocal expd [\$dateint d=\$comment] ; :local expt [\$timeint t=\$gettime] ; :if ((\$expd < \$today and \$expt < \$curtime) or (\$expd < \$today and \$expt > \$curtime) or (\$expd =\
    \_\$today and \$expt < \$curtime)) do={ [ /ip hotspot user remove \$i ]; [ /ip hotspot active remove [find where user=\$name] ];}}}" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2025-12-17 start-time=01:16:29
add comment="Monitor Profile wavlink-hotspot" interval=2m27s name=wavlink-hotspot on-event=":local dateint do={:local montharray ( \"01\",\"02\",\"03\",\"04\",\"05\",\"06\",\"07\",\"\
    08\",\"09\",\"10\",\"11\",\"12\" );:local days [ :pick \$d 8 10 ];:local month [ :pick \$d 5 7 ];:local year [ :pick \$d 0 4 ];:local monthint ([ :find \$montharray \$month]);:lo\
    cal month (\$monthint + 1);:if ( [len \$month] = 1) do={:local zero (\"0\");:return [:tonum (\"\$year\$zero\$month\$days\")];} else={:return [:tonum (\"\$year\$month\$days\")];}}\
    ; :local timeint do={ :local hours [ :pick \$t 0 2 ]; :local minutes [ :pick \$t 3 5 ]; :return (\$hours * 60 + \$minutes) ; }; :local date [ /system clock get date ]; :local tim\
    e [ /system clock get time ]; :local today [\$dateint d=\$date] ; :local curtime [\$timeint t=\$time] ; :foreach i in [ /ip hotspot user find where profile=\"wavlink-hotspot\" ] \
    do={ :local comment [ /ip hotspot user get \$i comment]; :local name [ /ip hotspot user get \$i name]; :local gettime [:pic \$comment 11 19]; :if ([:pic \$comment 4] = \"-\" and \
    [:pic \$comment 7] = \"-\") do={:local expd [\$dateint d=\$comment] ; :local expt [\$timeint t=\$gettime] ; :if ((\$expd < \$today and \$expt < \$curtime) or (\$expd < \$today an\
    d \$expt > \$curtime) or (\$expd = \$today and \$expt < \$curtime)) do={ [ /ip hotspot user remove \$i ]; [ /ip hotspot active remove [find where user=\$name] ];}}}" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon start-date=2025-12-17 start-time=04:38:47
/system script
add comment=mikhmon dont-require-permissions=no name=2025-12-17-|-16:54:15-|-admin2-|-0-|-10.10.201.252-|-EE:0F:28:FA:55:BF-|-1m-|-1min-test-|- owner=202-17 policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=2025-12-17
add comment=mikhmon dont-require-permissions=no name=2025-12-17-|-17:09:04-|-admin2-|-0-|-10.10.201.252-|-EE:0F:28:FA:55:BF-|-1m-|-1min-test-|- owner=122025 policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=2025-12-17
/tool romon
set enabled=yes
