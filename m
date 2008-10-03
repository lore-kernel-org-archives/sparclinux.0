From: Jim Gifford <maillist@jg555.com>
Date: Fri, 03 Oct 2008 17:13:11 +0000
Subject: Netra X1 - Tulip Issues - Since 2.6.24
Message-Id: <48E652A7.3010202@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Currently running 2.6.24-gentoo-r8 and 2.6.25-gentoo-r7. Also have tried 
the vanilla kernel as well.

It appears the issues seems to be isolated tot he Sparc X1's my x86's 
using the tulip driver are not having the issue.

Not sure if it's a reporting issue or just a problem with the driver. 
Every packet seems to be an error. I've ran out of resources trying to 
figure this out on my own, but no luck. Seems to be TX issue only.

Here's what I'm seeing

mail ~ # mii-diag eth0
Basic registers of MII PHY #1:  2100 780d 0181 b840 01e1 0000 0000 0000.
 Basic mode control register 0x2100: Auto-negotiation disabled, with
 Speed fixed at 100 mbps, full-duplex.
 You have link beat, and everything is working OK.
 Link partner information is not exchanged when in fixed speed mode.
   End of basic transceiver information.

mail ~ # mii-diag eth1
Basic registers of MII PHY #1:  2100 780d 0181 b840 01e1 0000 0000 0000.
 Basic mode control register 0x2100: Auto-negotiation disabled, with
 Speed fixed at 100 mbps, full-duplex.
 You have link beat, and everything is working OK.
 Link partner information is not exchanged when in fixed speed mode.
   End of basic transceiver information.

mail ~ # ifconfig
eth0      Link encap:Ethernet  HWaddr 00:03:BA:0F:37:73
          inet addr:172.16.0.50  Bcast:172.16.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:147120 errors:0 dropped:0 overruns:0 frame:0
          TX packets:33290 errors:556 dropped:0 overruns:2 carrier:554
          collisions:12 txqueuelen:1000
          RX bytes:11800444 (11.2 Mb)  TX bytes:5032585 (4.7 Mb)
          Interrupt:9

eth1      Link encap:Ethernet  HWaddr 00:03:BA:0F:37:74
          inet addr:10.0.0.50  Bcast:10.0.0.255  Mask:255.255.255.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:3941 errors:0 dropped:0 overruns:0 frame:0
          TX packets:1 errors:4835 dropped:0 overruns:0 carrier:4835
          collisions:0 txqueuelen:1000
          RX bytes:1089347 (1.0 Mb)  TX bytes:54 (54.0 b)
          Interrupt:10 Base address:0x100

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:51 errors:0 dropped:0 overruns:0 frame:0
          TX packets:51 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:3906 (3.8 Kb)  TX bytes:3906 (3.8 Kb)

Oct  2 23:26:59 mail kernel: [ 9822.736777] NETDEV WATCHDOG: eth0: 
transmit timed out
Oct  2 23:27:07 mail kernel: [ 9830.732649] NETDEV WATCHDOG: eth0: 
transmit timed out
Oct  2 23:27:15 mail kernel: [ 9838.728518] NETDEV WATCHDOG: eth0: 
transmit timed out
Oct  2 23:27:23 mail kernel: [ 9846.724386] NETDEV WATCHDOG: eth0: 
transmit timed out
Oct  2 23:27:31 mail kernel: [ 9854.720177] NETDEV WATCHDOG: eth0: 
transmit timed out
Oct  2 23:27:39 mail kernel: [ 9862.716124] NETDEV WATCHDOG: eth0: 
transmit timed out
Oct  2 23:27:47 mail kernel: [ 9870.711943] NETDEV WATCHDOG: eth0: 
transmit timed out
Oct  2 23:27:55 mail kernel: [ 9878.707824] NETDEV WATCHDOG: eth0: 
transmit timed out
Oct  2 23:28:03 mail kernel: [ 9886.703675] NETDEV WATCHDOG: eth0: 
transmit timed out
Oct  2 23:28:11 mail kernel: [ 9894.699598] NETDEV WATCHDOG: eth0: 
transmit timed out
Oct  2 23:28:19 mail kernel: [ 9902.695467] NETDEV WATCHDOG: eth0: 
transmit timed out
Oct  2 23:28:27 mail kernel: [ 9910.691336] NETDEV WATCHDOG: eth0: 
transmit timed out
Oct  2 23:28:35 mail kernel: [ 9918.687122] NETDEV WATCHDOG: eth0: 
transmit timed out


