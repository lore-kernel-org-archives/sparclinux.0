From: Felix Matenaar <pleed@chaos-disciple.org>
Date: Fri, 25 Jan 2008 16:16:37 +0000
Subject: sunhme dual port, mac address assignment problem
Message-Id: <479A0B65.1050504@chaos-disciple.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

i ve got a sun netra t1 105 running gentoo with linux-2.6.23.
On booting the second device eth1 is shown as eth1_rename
and all init scripts using eth1 fail.

/var/log/messages:

4396 Jan 25 15:58:26 voyager net eth1_rename: device_rename:
sysfs_create_symlink failed (-17)

Now i think this is because both interfaces are getting the same MAC
address.
SUN has this MAC address problem in his help and it s solving it by setting
"setenv local-mac-address? true" in ok prompt but that didnt help me.

I also changed the mac address in /etc/udev/rules.d/70-persistent-net.rules.
Changing the MAC with ifconfig i can use the eth1_rename device as usual
but that configuration doesnt survive any reboot.

So i know you ve got more important stuff to do but i would be very glad
if you have
any solution/workaround for that problem?


thanks and greets,

Felix Matenaar



ifconfig -a:

eth0      Link encap:Ethernet  HWaddr 08:00:20:DA:3C:B6 
          inet addr:192.168.179.100  Bcast:192.168.179.255 
Mask:255.255.255.0
          inet6 addr: 2001:6f8:111d:1234:a00:20ff:feda:3cb6/64 Scope:Global
          inet6 addr: fe80::a00:20ff:feda:3cb6/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:943 errors:0 dropped:0 overruns:0 frame:0
          TX packets:815 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:86612 (84.5 Kb)  TX bytes:524194 (511.9 Kb)
          Interrupt:12 Base address:0x1800

eth1_rena Link encap:Ethernet  HWaddr 08:00:20:DA:3C:B6 
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)
          Interrupt:14 Base address:0x800

lo        Link encap:Local Loopback 
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 b)  TX bytes:0 (0.0 b)

# prtconf -pv |grep idprom                 
    idprom: 
01800800.20da3cb6.ffffffff.da3cb6a9.ffffffff.ffffffff.40ffffff.ffef5f00

# prtconf -pv |grep local-mac-address
        local-mac-address?: 'true'
                local-mac-address:  080020da.3cb6
                local-mac-address:  080020da.3cb7
voyager rules.d #






