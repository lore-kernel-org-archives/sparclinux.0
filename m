From: Jim Gifford <maillist@jg555.com>
Date: Mon, 27 Oct 2008 18:03:23 +0000
Subject: Re: Tulip Driver Issues
Message-Id: <4906026B.1020202@jg555.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Jim Gifford wrote:
> I originally posted this on the Sparc list, with no solutions yet. I 
> have included the detail from that email as well, but the newer 
> kernels are still having the same issue.
>
> Now I'm running 2.6.27-gentoo and have tried 2.6.26-gentoo.
>
> The errors are still showing up and still locking up the system randomly.
>
> mail ~ # mii-tool -v eth0
> eth0: no autonegotiation, 100baseTx-HD, link ok
>  product info: vendor 00:60:6e, model 4 rev 0
>  basic mode:   autonegotiation enabled
>  basic status: autonegotiation complete, link ok
>  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
>  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
>  link partner: 100baseTx-HD
> mail ~ # mii-tool -v eth1
> eth1: no autonegotiation, 100baseTx-HD, link ok
>  product info: vendor 00:60:6e, model 4 rev 0
>  basic mode:   autonegotiation enabled
>  basic status: autonegotiation complete, link ok
>  capabilities: 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
>  advertising:  100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
>  link partner: 100baseTx-HD
> mail ~ #
> Oct 26 08:35:03 mail kernel: [488077.248697] 0000:00:0c.0: 
> tulip_stop_rxtx() failed (CSR5 0xfc508100 CSR6 0x22ec000)
> Oct 26 08:35:11 mail kernel: [488085.244689] 0000:00:0c.0: 
> tulip_stop_rxtx() failed (CSR5 0xfc508100 CSR6 0x22ec000)
> Oct 26 08:35:19 mail kernel: [488093.240680] 0000:00:0c.0: 
> tulip_stop_rxtx() failed (CSR5 0xfc508100 CSR6 0x22ec000)
> Oct 26 08:35:27 mail kernel: [488101.236601] 0000:00:0c.0: 
> tulip_stop_rxtx() failed (CSR5 0xfc508100 CSR6 0x22ec000)
> Oct 26 08:35:35 mail kernel: [488109.232606] 0000:00:0c.0: 
> tulip_stop_rxtx() failed (CSR5 0xfc508100 CSR6 0x22ec000)
> Oct 26 08:35:43 mail kernel: [488117.228723] 0000:00:0c.0: 
> tulip_stop_rxtx() failed (CSR5 0xfc508100 CSR6 0x22ec000)
> Oct 26 08:35:51 mail kernel: [488125.224724] 0000:00:0c.0: 
> tulip_stop_rxtx() failed (CSR5 0xfc508100 CSR6 0x22ec000)
> Oct 26 08:35:59 mail kernel: [488133.220705] 0000:00:0c.0: 
> tulip_stop_rxtx() failed (CSR5 0xfc508100 CSR6 0x22ec000)
> Oct 26 08:36:07 mail kernel: [488141.216733] 0000:00:0c.0: 
> tulip_stop_rxtx() failed (CSR5 0xfc508100 CSR6 0x22ec000)
> Oct 26 08:36:15 mail kernel: [488149.212736] 0000:00:0c.0: 
> tulip_stop_rxtx() failed (CSR5 0xfc508100 CSR6 0x22ec000)
> Oct 26 08:36:23 mail kernel: [488157.208619] 0000:00:0c.0: 
> tulip_stop_rxtx() failed (CSR5 0xfc508100 CSR6 0x22ec000)
> Oct 26 08:36:31 mail kernel: [488165.204740] 0000:00:0c.0: 
> tulip_stop_rxtx() failed (CSR5 0xfc508100 CSR6 0x22ec000)
> Oct 26 08:36:39 mail kernel: [488173.200705] 0000:00:0c.0: 
> tulip_stop_rxtx() failed (CSR5 0xfc508100 CSR6 0x22ec000)
> Oct 26 08:36:47 mail kernel: [488181.196633] 0000:00:0c.0: 
> tulip_stop_rxtx() failed (CSR5 0xfc508100 CSR6 0x22ec000)
> Oct 26 08:36:52 mail kernel: [488185.874327] 0000:00:0c.0: 
> tulip_stop_rxtx() failed (CSR5 0xfc500100 CSR6 0x22ec000)
>
>
>
> Original Email to Sparc Linux Below
> -----
>
> Currently running 2.6.24-gentoo-r8 and 2.6.25-gentoo-r7. Also have 
> tried the vanilla kernel as well.
>
> It appears the issues seems to be isolated tot he Sparc X1's my x86's 
> using the tulip driver are not having the issue.
>
> Not sure if it's a reporting issue or just a problem with the driver. 
> Every packet seems to be an error. I've ran out of resources trying to 
> figure this out on my own, but no luck. Seems to be TX issue only.
>
> Here's what I'm seeing
>
> mail ~ # mii-diag eth0
> Basic registers of MII PHY #1:  2100 780d 0181 b840 01e1 0000 0000 0000.
> Basic mode control register 0x2100: Auto-negotiation disabled, with
> Speed fixed at 100 mbps, full-duplex.
> You have link beat, and everything is working OK.
> Link partner information is not exchanged when in fixed speed mode.
>  End of basic transceiver information.
>
> mail ~ # mii-diag eth1
> Basic registers of MII PHY #1:  2100 780d 0181 b840 01e1 0000 0000 0000.
> Basic mode control register 0x2100: Auto-negotiation disabled, with
> Speed fixed at 100 mbps, full-duplex.
> You have link beat, and everything is working OK.
> Link partner information is not exchanged when in fixed speed mode.
>  End of basic transceiver information.
>
> mail ~ # ifconfig
> eth0      Link encap:Ethernet  HWaddr 00:03:BA:0F:37:73
>         inet addr:172.16.0.50  Bcast:172.16.0.255  Mask:255.255.255.0
>         UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>         RX packets:147120 errors:0 dropped:0 overruns:0 frame:0
>         TX packets:33290 errors:556 dropped:0 overruns:2 carrier:554
>         collisions:12 txqueuelen:1000
>         RX bytes:11800444 (11.2 Mb)  TX bytes:5032585 (4.7 Mb)
>         Interrupt:9
>
> eth1      Link encap:Ethernet  HWaddr 00:03:BA:0F:37:74
>         inet addr:10.0.0.50  Bcast:10.0.0.255  Mask:255.255.255.0
>         UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
>         RX packets:3941 errors:0 dropped:0 overruns:0 frame:0
>         TX packets:1 errors:4835 dropped:0 overruns:0 carrier:4835
>         collisions:0 txqueuelen:1000
>         RX bytes:1089347 (1.0 Mb)  TX bytes:54 (54.0 b)
>         Interrupt:10 Base address:0x100
>
> lo        Link encap:Local Loopback
>         inet addr:127.0.0.1  Mask:255.0.0.0
>         UP LOOPBACK RUNNING  MTU:16436  Metric:1
>         RX packets:51 errors:0 dropped:0 overruns:0 frame:0
>         TX packets:51 errors:0 dropped:0 overruns:0 carrier:0
>         collisions:0 txqueuelen:0
>         RX bytes:3906 (3.8 Kb)  TX bytes:3906 (3.8 Kb)
>
> Oct  2 23:26:59 mail kernel: [ 9822.736777] NETDEV WATCHDOG: eth0: 
> transmit timed out
> Oct  2 23:27:07 mail kernel: [ 9830.732649] NETDEV WATCHDOG: eth0: 
> transmit timed out
> Oct  2 23:27:15 mail kernel: [ 9838.728518] NETDEV WATCHDOG: eth0: 
> transmit timed out
> Oct  2 23:27:23 mail kernel: [ 9846.724386] NETDEV WATCHDOG: eth0: 
> transmit timed out
> Oct  2 23:27:31 mail kernel: [ 9854.720177] NETDEV WATCHDOG: eth0: 
> transmit timed out
> Oct  2 23:27:39 mail kernel: [ 9862.716124] NETDEV WATCHDOG: eth0: 
> transmit timed out
> Oct  2 23:27:47 mail kernel: [ 9870.711943] NETDEV WATCHDOG: eth0: 
> transmit timed out
> Oct  2 23:27:55 mail kernel: [ 9878.707824] NETDEV WATCHDOG: eth0: 
> transmit timed out
> Oct  2 23:28:03 mail kernel: [ 9886.703675] NETDEV WATCHDOG: eth0: 
> transmit timed out
> Oct  2 23:28:11 mail kernel: [ 9894.699598] NETDEV WATCHDOG: eth0: 
> transmit timed out
> Oct  2 23:28:19 mail kernel: [ 9902.695467] NETDEV WATCHDOG: eth0: 
> transmit timed out
> Oct  2 23:28:27 mail kernel: [ 9910.691336] NETDEV WATCHDOG: eth0: 
> transmit timed out
> Oct  2 23:28:35 mail kernel: [ 9918.687122] NETDEV WATCHDOG: eth0: 
> transmit timed out
>
>
> -- 
> To unsubscribe from this list: send the line "unsubscribe linux-net" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
Was able to get more watching it boot up a bit. Finally got someone to 
attach a console cable so I can watch it.

[   77.677266] tulip0: Old style EEPROM with no media selection information.
[   77.677530] tulip0:  MII transceiver #1 config 1000 status 782d 
advertising 01e1.
[   77.680490] eth0: Davicom DM9102/DM9102A rev 49 at Port 
0x1fe02010000, EEPROM not present, 00:03:ba:0f:37:73, IRQ 9.
[   77.683206] tulip1: Old style EEPROM with no media selection information.
[   77.683469] tulip1:  MII transceiver #1 config 1000 status 782d 
advertising 01e1.
[   77.686416] eth1: Davicom DM9102/DM9102A rev 49 at Port 
0x1fe02010100, EEPROM not present, 00:03:ba:0f:37:74, IRQ 10.
[   78.964507] ioctl32(blogd:622): Unknown cmd fd(0) 
cmd(40045432){t:'T';sz:4} arg(ffa5db4c) on /dev/console
[   79.650247] EXT3 FS on hda2, internal journal
[   80.578195] Adding 1510088k swap on /dev/hda4.  Priority:-1 extents:1 
across:1510088k
[ 1120.671137] ------------[ cut here ]------------
[ 1120.671164] WARNING: at net/sched/sch_generic.c:219 
dev_watchdog+0x250/0x280()
[ 1120.671178] NETDEV WATCHDOG: eth0 (tulip): transmit timed out
[ 1120.671187] Modules linked in: openpromfs tulip
[ 1120.671203] Call Trace:
[ 1120.671219]  [00000000005ece50] dev_watchdog+0x250/0x280
[ 1120.671242]  [000000000045f64c] run_timer_softirq+0x16c/0x1e0
[ 1120.671260]  [000000000045ab7c] __do_softirq+0x5c/0xe0
[ 1120.671286]  [000000000042e3f0] do_softirq+0x70/0xa0
[ 1120.671300]  [000000000045a764] irq_exit+0x84/0xc0
[ 1120.671316]  [000000000043327c] timer_interrupt+0x5c/0xc0
[ 1120.671335]  [00000000004209d4] tl0_irq14+0x14/0x20
[ 1120.671350]  [000000000042803c] cpu_idle+0x1c/0xc0
[ 1120.671374]  [000000000070c8bc] start_kernel+0x27c/0x2c0
[ 1120.671389]  [0000000000643684] tlb_fixup_done+0x80/0x9c
[ 1120.671402]  [0000000000000000] 0x0
[ 1120.671411] ---[ end trace b22e2d0475606961 ]---
[ 1120.672767] 0000:00:0c.0: tulip_stop_rxtx() failed (CSR5 0xfc508100 
CSR6 0x20e8000)
[ 1128.667904] 0000:00:0c.0: tulip_stop_rxtx() failed (CSR5 0xfc508100 
CSR6 0x20e8000)
[ 1136.663348] 0000:00:0c.0: tulip_stop_rxtx() failed (CSR5 0xfc508100 
CSR6 0x20e8000)
[ 1144.658798] 0000:00:0c.0: tulip_stop_rxtx() failed (CSR5 0xfc508100 
CSR6 0x20e8000)
[ 1152.654254] 0000:00:0c.0: tulip_stop_rxtx() failed (CSR5 0xfc508100 
CSR6 0x20e8000)

