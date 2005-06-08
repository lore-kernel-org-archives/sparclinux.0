From: Turbo Fredriksson <turbo@swe.net>
Date: Wed, 08 Jun 2005 19:42:51 +0000
Subject: Re: ipt_recent && spamd (!?) && kernel panic
Message-Id: <878y1kskhw.fsf@pumba.bayour.com>
List-Id: <sparclinux.vger.kernel.org>
References: <87oeahuwt3.fsf@pumba.bayour.com>
In-Reply-To: <87oeahuwt3.fsf@pumba.bayour.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

--=-=-
>>>>> "David" = David S Miller <davem@davemloft.net> writes:

    David> From: Turbo Fredriksson <turbo@swe.net> Date: Wed, 08 Jun
    David> 2005 09:34:00 +0200

    >> I'm not exactly sure WHERE the problem is (the panic mentions
    >> spamd - spamassassin daemon), but I can't see what that can do
    >> to cause this:

    David> The crash clearly shows that it's a bzero() call made by
    David> the match() function in ipt_recent.c of the kernel.

    David> What ipt_recent rules do you have loaded?

Included the FULL list that I _WANT_ to run. I disabled spamassassin
and qmail, flushed the tables and loaded the REAL table rules, did
'iptables -L -n' down to this file and then loaded the one I'm running
now (almost the same, just without the ipt_recent stuff)... All in a
oneliner to minimize the risk of crash :)

[I thought about obfuscate it, but thought against it. 'Everyone'
 already know about my machines :)]


--=-=-Content-Disposition: inline; filename=iptables.txt
Content-Description: iptables -L -n

Chain INPUT (policy ACCEPT)
target     prot opt source               destination         
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:67 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:67 
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:772 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:772 
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:69 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:69 
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:111 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:111 
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:161 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:161 
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:162 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:162 
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:389 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:389 
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:636 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:636 
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:749 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:749 
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:783 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:783 
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:873 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:873 
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:3306 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:3306 
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:2988 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:2988 
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:3000 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:3000 
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:9101 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:9101 
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:9102 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:9102 
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:9103 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:9103 
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:3551 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:3551 
ACCEPT     tcp  --  212.214.70.0/24      212.214.70.50      tcp dpt:6544 
ACCEPT     udp  --  212.214.70.0/24      212.214.70.50      udp dpt:6544 
ACCEPT     tcp  --  82.182.174.117       212.214.70.50      
ACCEPT     udp  --  82.182.174.117       212.214.70.50      
           tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:22 state NEW recent: SET name: SSH
SSH_WHITELIST  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:22 state NEW 
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:22 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: SSHLOG flags 0 level 4 prefix `SSH_brute_force' 
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:22 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: SSH
           tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:23 state NEW recent: SET name: TELNET
TELNET_WHITELIST  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:23 state NEW 
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:23 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: TELNETLOG flags 0 level 4 prefix `TELNET_brute_force' 
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:23 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: TELNET
           tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:88 state NEW recent: SET name: KRB5
KRB5_WHITELIST  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:88 state NEW 
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:88 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: KRB5LOG flags 0 level 4 prefix `KRB5_brute_force' 
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:88 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: KRB5
           tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:107 state NEW recent: SET name: RTELNET
RTELNET_WHITELIST  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:107 state NEW 
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:107 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: RTELNETLOG flags 0 level 4 prefix `RTELNET_brute_force' 
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:107 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: RTELNET
           tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:389 state NEW recent: SET name: LDAP
LDAP_WHITELIST  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:389 state NEW 
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:389 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: LDAPLOG flags 0 level 4 prefix `LDAP_brute_force' 
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:389 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: LDAP
           tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:543 state NEW recent: SET name: RLOGIN
RLOGIN_WHITELIST  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:543 state NEW 
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:543 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: RLOGINLOG flags 0 level 4 prefix `RLOGIN_brute_force' 
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:543 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: RLOGIN
           tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:636 state NEW recent: SET name: LDAPS
LDAPS_WHITELIST  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:636 state NEW 
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:636 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: LDAPSLOG flags 0 level 4 prefix `LDAPS_brute_force' 
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:636 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: LDAPS
           tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:749 state NEW recent: SET name: KRB5ADM
KRB5ADM_WHITELIST  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:749 state NEW 
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:749 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: KRB5ADMLOG flags 0 level 4 prefix `KRB5ADM_brute_force' 
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:749 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: KRB5ADM
           tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:751 state NEW recent: SET name: KRB5AUTH
KRB5AUTH_WHITELIST  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:751 state NEW 
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:751 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: KRB5AUTHLOG flags 0 level 4 prefix `KRB5AUTH_brute_force' 
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:751 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: KRB5AUTH
           tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:992 state NEW recent: SET name: TELNETS
TELNETS_WHITELIST  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:992 state NEW 
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:992 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: TELNETSLOG flags 0 level 4 prefix `TELNETS_brute_force' 
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:992 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: TELNETS
           tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:2105 state NEW recent: SET name: EKLOGIN
EKLOGIN_WHITELIST  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:2105 state NEW 
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:2105 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: EKLOGINLOG flags 0 level 4 prefix `EKLOGIN_brute_force' 
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:2105 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: EKLOGIN
           tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:3306 state NEW recent: SET name: MYSQL
MYSQL_WHITELIST  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:3306 state NEW 
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:3306 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: MYSQLLOG flags 0 level 4 prefix `MYSQL_brute_force' 
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:3306 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: MYSQL
           tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:5432 state NEW recent: SET name: PGSQL
PGSQL_WHITELIST  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:5432 state NEW 
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:5432 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: PGSQLLOG flags 0 level 4 prefix `PGSQL_brute_force' 
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:5432 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: PGSQL
           tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:8080 state NEW recent: SET name: SQUID
SQUID_WHITELIST  tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:8080 state NEW 
LOG        tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:8080 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: SQUIDLOG flags 0 level 4 prefix `SQUID_brute_force' 
DROP       tcp  --  0.0.0.0/0            0.0.0.0/0          tcp dpt:8080 state NEW recent: UPDATE seconds: 60 hit_count: 4 TTL-Match name: SQUID
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpts:0:19 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpts:26:52 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpts:54:79 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpts:81:87 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpts:89:109 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpt:111 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpts:115:142 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpts:144:442 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpts:444:542 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpts:545:627 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpts:629:992 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpt:994 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpts:996:1023 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpt:3306 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpt:6000 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpt:3128 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpt:3551 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpt:3000 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpt:4000 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpt:6544 reject-with tcp-reset 
REJECT     tcp  --  0.0.0.0/0            212.214.70.50      tcp dpt:8180 reject-with tcp-reset 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpts:0:19 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpts:26:52 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpts:54:79 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpts:81:87 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpts:89:109 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpt:111 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpts:115:142 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpts:144:442 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpts:444:542 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpts:545:627 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpts:629:992 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpt:994 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpts:996:1023 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpt:3306 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpt:6000 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpt:3128 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpt:3551 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpt:3000 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpt:4000 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpt:6544 
DROP       udp  --  0.0.0.0/0            212.214.70.50      udp dpt:8180 
REJECT     tcp  --  202.141.1.0/24       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  202.141.1.0/24       212.214.70.50      
REJECT     tcp  --  212.211.81.19        212.214.70.50      reject-with tcp-reset 
DROP       udp  --  212.211.81.19        212.214.70.50      
REJECT     tcp  --  212.211.89.9         212.214.70.50      reject-with tcp-reset 
DROP       udp  --  212.211.89.9         212.214.70.50      
REJECT     tcp  --  213.7.186.208        212.214.70.50      reject-with tcp-reset 
DROP       udp  --  213.7.186.208        212.214.70.50      
REJECT     tcp  --  24.62.47.212         212.214.70.50      reject-with tcp-reset 
DROP       udp  --  24.62.47.212         212.214.70.50      
REJECT     tcp  --  64.195.6.8           212.214.70.50      reject-with tcp-reset 
DROP       udp  --  64.195.6.8           212.214.70.50      
REJECT     tcp  --  68.14.75.78          212.214.70.50      reject-with tcp-reset 
DROP       udp  --  68.14.75.78          212.214.70.50      
REJECT     tcp  --  195.232.52.49        212.214.70.50      reject-with tcp-reset 
DROP       udp  --  195.232.52.49        212.214.70.50      
REJECT     tcp  --  218.154.16.196       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  218.154.16.196       212.214.70.50      
REJECT     tcp  --  195.116.71.42        212.214.70.50      reject-with tcp-reset 
DROP       udp  --  195.116.71.42        212.214.70.50      
REJECT     tcp  --  64.146.105.187       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  64.146.105.187       212.214.70.50      
REJECT     tcp  --  193.224.154.0/24     212.214.70.50      reject-with tcp-reset 
DROP       udp  --  193.224.154.0/24     212.214.70.50      
REJECT     tcp  --  212.95.82.54         212.214.70.50      reject-with tcp-reset 
DROP       udp  --  212.95.82.54         212.214.70.50      
REJECT     tcp  --  62.233.205.186       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  62.233.205.186       212.214.70.50      
REJECT     tcp  --  212.213.244.120      212.214.70.50      reject-with tcp-reset 
DROP       udp  --  212.213.244.120      212.214.70.50      
REJECT     tcp  --  172.128.0.0/10       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  172.128.0.0/10       212.214.70.50      
REJECT     tcp  --  24.30.145.242        212.214.70.50      reject-with tcp-reset 
DROP       udp  --  24.30.145.242        212.214.70.50      
REJECT     tcp  --  211.220.19.245       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  211.220.19.245       212.214.70.50      
REJECT     tcp  --  67.109.54.39         212.214.70.50      reject-with tcp-reset 
DROP       udp  --  67.109.54.39         212.214.70.50      
REJECT     tcp  --  203.131.147.240      212.214.70.50      reject-with tcp-reset 
DROP       udp  --  203.131.147.240      212.214.70.50      
REJECT     tcp  --  165.165.252.86       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  165.165.252.86       212.214.70.50      
REJECT     tcp  --  64.222.46.60         212.214.70.50      reject-with tcp-reset 
DROP       udp  --  64.222.46.60         212.214.70.50      
REJECT     tcp  --  65.42.84.121         212.214.70.50      reject-with tcp-reset 
DROP       udp  --  65.42.84.121         212.214.70.50      
REJECT     tcp  --  212.194.21.170       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  212.194.21.170       212.214.70.50      
REJECT     tcp  --  24.100.215.155       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  24.100.215.155       212.214.70.50      
REJECT     tcp  --  221.163.10.3         212.214.70.50      reject-with tcp-reset 
DROP       udp  --  221.163.10.3         212.214.70.50      
REJECT     tcp  --  81.128.121.175       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  81.128.121.175       212.214.70.50      
REJECT     tcp  --  81.217.6.84          212.214.70.50      reject-with tcp-reset 
DROP       udp  --  81.217.6.84          212.214.70.50      
REJECT     tcp  --  64.222.163.237       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  64.222.163.237       212.214.70.50      
REJECT     tcp  --  219.137.1.148        212.214.70.50      reject-with tcp-reset 
DROP       udp  --  219.137.1.148        212.214.70.50      
REJECT     tcp  --  213.42.2.180         212.214.70.50      reject-with tcp-reset 
DROP       udp  --  213.42.2.180         212.214.70.50      
REJECT     tcp  --  68.236.193.231       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  68.236.193.231       212.214.70.50      
REJECT     tcp  --  193.203.244.210      212.214.70.50      reject-with tcp-reset 
DROP       udp  --  193.203.244.210      212.214.70.50      
REJECT     tcp  --  212.143.119.26       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  212.143.119.26       212.214.70.50      
REJECT     tcp  --  82.48.13.9           212.214.70.50      reject-with tcp-reset 
DROP       udp  --  82.48.13.9           212.214.70.50      
REJECT     tcp  --  61.249.50.44         212.214.70.50      reject-with tcp-reset 
DROP       udp  --  61.249.50.44         212.214.70.50      
REJECT     tcp  --  218.170.103.209      212.214.70.50      reject-with tcp-reset 
DROP       udp  --  218.170.103.209      212.214.70.50      
REJECT     tcp  --  62.30.182.119        212.214.70.50      reject-with tcp-reset 
DROP       udp  --  62.30.182.119        212.214.70.50      
REJECT     tcp  --  24.87.47.181         212.214.70.50      reject-with tcp-reset 
DROP       udp  --  24.87.47.181         212.214.70.50      
REJECT     tcp  --  64.223.155.75        212.214.70.50      reject-with tcp-reset 
DROP       udp  --  64.223.155.75        212.214.70.50      
REJECT     tcp  --  221.140.69.144       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  221.140.69.144       212.214.70.50      
REJECT     tcp  --  218.148.110.156      212.214.70.50      reject-with tcp-reset 
DROP       udp  --  218.148.110.156      212.214.70.50      
REJECT     tcp  --  64.222.46.178        212.214.70.50      reject-with tcp-reset 
DROP       udp  --  64.222.46.178        212.214.70.50      
REJECT     tcp  --  24.165.209.70        212.214.70.50      reject-with tcp-reset 
DROP       udp  --  24.165.209.70        212.214.70.50      
REJECT     tcp  --  220.65.59.77         212.214.70.50      reject-with tcp-reset 
DROP       udp  --  220.65.59.77         212.214.70.50      
REJECT     tcp  --  63.159.12.141        212.214.70.50      reject-with tcp-reset 
DROP       udp  --  63.159.12.141        212.214.70.50      
REJECT     tcp  --  220.91.136.228       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  220.91.136.228       212.214.70.50      
REJECT     tcp  --  210.219.250.124      212.214.70.50      reject-with tcp-reset 
DROP       udp  --  210.219.250.124      212.214.70.50      
REJECT     tcp  --  211.214.35.170       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  211.214.35.170       212.214.70.50      
REJECT     tcp  --  212.119.176.194      212.214.70.50      reject-with tcp-reset 
DROP       udp  --  212.119.176.194      212.214.70.50      
REJECT     tcp  --  217.160.240.131      212.214.70.50      reject-with tcp-reset 
DROP       udp  --  217.160.240.131      212.214.70.50      
REJECT     tcp  --  218.149.164.73       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  218.149.164.73       212.214.70.50      
REJECT     tcp  --  69.67.166.74         212.214.70.50      reject-with tcp-reset 
DROP       udp  --  69.67.166.74         212.214.70.50      
REJECT     tcp  --  222.64.0.0/13        212.214.70.50      reject-with tcp-reset 
DROP       udp  --  222.64.0.0/13        212.214.70.50      
REJECT     tcp  --  222.72.0.0/15        212.214.70.50      reject-with tcp-reset 
DROP       udp  --  222.72.0.0/15        212.214.70.50      
REJECT     tcp  --  202.108.181.0/24     212.214.70.50      reject-with tcp-reset 
DROP       udp  --  202.108.181.0/24     212.214.70.50      
REJECT     tcp  --  221.224.0.0/13       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  221.224.0.0/13       212.214.70.50      
REJECT     tcp  --  218.78.0.0/15        212.214.70.50      reject-with tcp-reset 
DROP       udp  --  218.78.0.0/15        212.214.70.50      
REJECT     tcp  --  218.80.0.0/14        212.214.70.50      reject-with tcp-reset 
DROP       udp  --  218.80.0.0/14        212.214.70.50      
REJECT     tcp  --  211.252.198.222      212.214.70.50      reject-with tcp-reset 
DROP       udp  --  211.252.198.222      212.214.70.50      
REJECT     tcp  --  200.80.38.1          212.214.70.50      reject-with tcp-reset 
DROP       udp  --  200.80.38.1          212.214.70.50      
REJECT     tcp  --  194.137.97.98        212.214.70.50      reject-with tcp-reset 
DROP       udp  --  194.137.97.98        212.214.70.50      
REJECT     tcp  --  172.191.135.86       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  172.191.135.86       212.214.70.50      
REJECT     tcp  --  220.88.0.0/13        212.214.70.50      reject-with tcp-reset 
DROP       udp  --  220.88.0.0/13        212.214.70.50      
REJECT     tcp  --  221.0.0.0/8          212.214.70.50      reject-with tcp-reset 
DROP       udp  --  221.0.0.0/8          212.214.70.50      
REJECT     tcp  --  217.83.176.188       212.214.70.50      reject-with tcp-reset 
DROP       udp  --  217.83.176.188       212.214.70.50      
REJECT     tcp  --  220.95.232.11        212.214.70.50      reject-with tcp-reset 
DROP       udp  --  220.95.232.11        212.214.70.50      
REJECT     tcp  --  68.142.251.0/24      212.214.70.50      reject-with tcp-reset 
DROP       udp  --  68.142.251.0/24      212.214.70.50      
REJECT     tcp  --  82.105.20.18         212.214.70.50      reject-with tcp-reset 
DROP       udp  --  82.105.20.18         212.214.70.50      
REJECT     tcp  --  211.114.170.161      212.214.70.50      reject-with tcp-reset 
DROP       udp  --  211.114.170.161      212.214.70.50      
REJECT     tcp  --  68.142.249.0/24      212.214.70.50      reject-with tcp-reset 
DROP       udp  --  68.142.249.0/24      212.214.70.50      

Chain FORWARD (policy ACCEPT)
target     prot opt source               destination         

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination         

Chain EKLOGIN_WHITELIST (1 references)
target     prot opt source               destination         
ACCEPT     all  --  127.0.0.1            212.214.70.50      recent: REMOVE name: EKLOGIN
ACCEPT     all  --  212.214.70.50        212.214.70.50      recent: REMOVE name: EKLOGIN
ACCEPT     all  --  82.182.174.117       212.214.70.50      recent: REMOVE name: EKLOGIN

Chain KRB5ADM_WHITELIST (1 references)
target     prot opt source               destination         
ACCEPT     all  --  127.0.0.1            212.214.70.50      recent: REMOVE name: KRB5ADM
ACCEPT     all  --  212.214.70.50        212.214.70.50      recent: REMOVE name: KRB5ADM
ACCEPT     all  --  82.182.174.117       212.214.70.50      recent: REMOVE name: KRB5ADM

Chain KRB5AUTH_WHITELIST (1 references)
target     prot opt source               destination         
ACCEPT     all  --  127.0.0.1            212.214.70.50      recent: REMOVE name: KRB5AUTH
ACCEPT     all  --  212.214.70.50        212.214.70.50      recent: REMOVE name: KRB5AUTH
ACCEPT     all  --  82.182.174.117       212.214.70.50      recent: REMOVE name: KRB5AUTH

Chain KRB5_WHITELIST (1 references)
target     prot opt source               destination         
ACCEPT     all  --  127.0.0.1            212.214.70.50      recent: REMOVE name: KRB5
ACCEPT     all  --  212.214.70.50        212.214.70.50      recent: REMOVE name: KRB5
ACCEPT     all  --  82.182.174.117       212.214.70.50      recent: REMOVE name: KRB5

Chain LDAPS_WHITELIST (1 references)
target     prot opt source               destination         
ACCEPT     all  --  127.0.0.1            212.214.70.50      recent: REMOVE name: LDAPS
ACCEPT     all  --  212.214.70.50        212.214.70.50      recent: REMOVE name: LDAPS
ACCEPT     all  --  82.182.174.117       212.214.70.50      recent: REMOVE name: LDAPS

Chain LDAP_WHITELIST (1 references)
target     prot opt source               destination         
ACCEPT     all  --  127.0.0.1            212.214.70.50      recent: REMOVE name: LDAP
ACCEPT     all  --  212.214.70.50        212.214.70.50      recent: REMOVE name: LDAP
ACCEPT     all  --  82.182.174.117       212.214.70.50      recent: REMOVE name: LDAP

Chain MYSQL_WHITELIST (1 references)
target     prot opt source               destination         
ACCEPT     all  --  127.0.0.1            212.214.70.50      recent: REMOVE name: MYSQL
ACCEPT     all  --  212.214.70.50        212.214.70.50      recent: REMOVE name: MYSQL
ACCEPT     all  --  82.182.174.117       212.214.70.50      recent: REMOVE name: MYSQL

Chain PGSQL_WHITELIST (1 references)
target     prot opt source               destination         
ACCEPT     all  --  127.0.0.1            212.214.70.50      recent: REMOVE name: PGSQL
ACCEPT     all  --  212.214.70.50        212.214.70.50      recent: REMOVE name: PGSQL
ACCEPT     all  --  82.182.174.117       212.214.70.50      recent: REMOVE name: PGSQL

Chain RLOGIN_WHITELIST (1 references)
target     prot opt source               destination         
ACCEPT     all  --  127.0.0.1            212.214.70.50      recent: REMOVE name: RLOGIN
ACCEPT     all  --  212.214.70.50        212.214.70.50      recent: REMOVE name: RLOGIN
ACCEPT     all  --  82.182.174.117       212.214.70.50      recent: REMOVE name: RLOGIN

Chain RTELNET_WHITELIST (1 references)
target     prot opt source               destination         
ACCEPT     all  --  127.0.0.1            212.214.70.50      recent: REMOVE name: RTELNET
ACCEPT     all  --  212.214.70.50        212.214.70.50      recent: REMOVE name: RTELNET
ACCEPT     all  --  82.182.174.117       212.214.70.50      recent: REMOVE name: RTELNET

Chain SQUID_WHITELIST (1 references)
target     prot opt source               destination         
ACCEPT     all  --  127.0.0.1            212.214.70.50      recent: REMOVE name: SQUID
ACCEPT     all  --  212.214.70.50        212.214.70.50      recent: REMOVE name: SQUID
ACCEPT     all  --  82.182.174.117       212.214.70.50      recent: REMOVE name: SQUID

Chain SSH_WHITELIST (1 references)
target     prot opt source               destination         
ACCEPT     all  --  127.0.0.1            212.214.70.50      recent: REMOVE name: SSH
ACCEPT     all  --  212.214.70.50        212.214.70.50      recent: REMOVE name: SSH
ACCEPT     all  --  82.182.174.117       212.214.70.50      recent: REMOVE name: SSH

Chain TELNETS_WHITELIST (1 references)
target     prot opt source               destination         
ACCEPT     all  --  127.0.0.1            212.214.70.50      recent: REMOVE name: TELNETS
ACCEPT     all  --  212.214.70.50        212.214.70.50      recent: REMOVE name: TELNETS
ACCEPT     all  --  82.182.174.117       212.214.70.50      recent: REMOVE name: TELNETS

Chain TELNET_WHITELIST (1 references)
target     prot opt source               destination         
ACCEPT     all  --  127.0.0.1            212.214.70.50      recent: REMOVE name: TELNET
ACCEPT     all  --  212.214.70.50        212.214.70.50      recent: REMOVE name: TELNET
ACCEPT     all  --  82.182.174.117       212.214.70.50      recent: REMOVE name: TELNET

--=-=-=--
