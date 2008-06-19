From: BERTRAND Joel <joel.bertrand@systella.fr>
Date: Thu, 19 Jun 2008 12:09:37 +0000
Subject: NETDEV WATCHDOG on U60/SMP
Message-Id: <485A4C81.50101@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	My U60 runs linux debian with official 2.6.25 linux kernel (I'm
currently trying 2.6.25.7) and sometimes, when eth2 is stressed, eth2
hangs with NETDEV WATCHDOG :

NETDEV WATCHDOG: eth2: transmit timed out
eth2: transmit timed out, tx_status 00 status 8601.
   diagnostics: net 0ccc media 8880 dma 0000003a fifo 0000
eth2: Interrupt posted but not delivered -- IRQ blocked by another device?
   Flags; bus-master 1, dirty 2283344(0) current 2283344(0)
   Transmit list 00000000 vs. fffff800af098200.
   0: @fffff800af098200  length 00000042 status 0c01059a
   1: @fffff800af098260  length 00000042 status 0c01059a
   2: @fffff800af0982c0  length 00000042 status 0c01059a
   3: @fffff800af098320  length 00000042 status 0c01059a
   4: @fffff800af098380  length 00000042 status 0c01059a
   5: @fffff800af0983e0  length 00000042 status 0c01059a
   6: @fffff800af098440  length 00000042 status 0c01059a
   7: @fffff800af0984a0  length 00000042 status 0c01059a
   8: @fffff800af098500  length 8000002a status 0001002a
   9: @fffff800af098560  length 8000002a status 0001002a
   10: @fffff800af0985c0  length 8000002a status 0001002a
   11: @fffff800af098620  length 8000002a status 0001002a
   12: @fffff800af098680  length 8000002a status 0001002a
   13: @fffff800af0986e0  length 8000002a status 0001002a
   14: @fffff800af098740  length 8000002a status 8001002a
   15: @fffff800af0987a0  length 8000002a status 8001002a
eth2: Resetting the Tx ring pointer.
eth2:  setting full-duplex.
NETDEV WATCHDOG: eth2: transmit timed out
eth2: transmit timed out, tx_status 00 status 8601.
   diagnostics: net 0ccc media 8880 dma 0000003a fifo 0000
eth2: Interrupt posted but not delivered -- IRQ blocked by another device?
   Flags; bus-master 1, dirty 16(0) current 16(0)
   Transmit list 00000000 vs. fffff800af098200.
   0: @fffff800af098200  length 8000002a status 0001002a
   1: @fffff800af098260  length 8000002a status 0001002a
   2: @fffff800af0982c0  length 8000002a status 0001002a
   3: @fffff800af098320  length 8000002a status 0001002a
   4: @fffff800af098380  length 8000002a status 0001002a
   5: @fffff800af0983e0  length 8000002a status 0001002a
   6: @fffff800af098440  length 8000002a status 0001002a
   7: @fffff800af0984a0  length 8000002a status 0001002a
   8: @fffff800af098500  length 8000002a status 0001002a
   9: @fffff800af098560  length 8000002a status 0001002a
   10: @fffff800af0985c0  length 8000002a status 0001002a
   11: @fffff800af098620  length 8000002a status 0001002a
   12: @fffff800af098680  length 8000002a status 0001002a
   13: @fffff800af0986e0  length 8000002a status 0001002a
   14: @fffff800af098740  length 8000002a status 8001002a
   15: @fffff800af0987a0  length 8000002a status 8001002a
eth2: Resetting the Tx ring pointer.
eth2:  setting full-duplex.
...

	I have to reboot this server to restore eth2.
This adapter is a 3Com NIC (3C905). I have tried with several different
3Com adapters with the same result.

	I have seen this bug since 2.6.20 even on amd64 (but I'm not sure that
this bug remains in amd64 kernel because I don't have any amd64
workstation to test).

lspci returns :
0000:00:00.0 Host bridge: Sun Microsystems Computer Corp. Psycho PCI Bus
Module
0000:00:01.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
0000:00:01.1 Ethernet controller: Sun Microsystems Computer Corp. Happy
Meal 10/100 Ethernet [hme] (rev 01)
0000:00:02.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M
[Tornado] (rev 78)
0000:00:03.0 SCSI storage controller: LSI Logic / Symbios Logic 53c875
(rev 14)
0000:00:03.1 SCSI storage controller: LSI Logic / Symbios Logic 53c875
(rev 14)
0000:00:04.0 SCSI storage controller: Adaptec AIC-7892A U160/m (rev 02)
0000:00:05.0 USB Controller: NEC Corporation USB (rev 43)
0000:00:05.1 USB Controller: NEC Corporation USB (rev 43)
0000:00:05.2 USB Controller: NEC Corporation USB 2.0 (rev 04)
0001:00:00.0 Host bridge: Sun Microsystems Computer Corp. Psycho PCI Bus
Module
0001:80:01.0 Bridge: Sun Microsystems Computer Corp. EBUS (rev 01)
0001:80:01.1 Ethernet controller: Sun Microsystems Computer Corp. Happy
Meal 10/100 Ethernet [hme] (rev 01)

ifconfig:
eth0      Link encap:Ethernet  HWaddr 08:00:20:a1:4b:33
           inet adr:192.168.0.128  Bcast:192.168.0.255  Masque:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:16709366 errors:0 dropped:0 overruns:0 frame:1
           TX packets:21355942 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 lg file transmission:1000
           RX bytes:2391901923 (2.2 GiB)  TX bytes:21605391421 (20.1 GiB)
           Interruption:14 Adresse de base:0x3000

eth1      Link encap:Ethernet  HWaddr 08:00:20:a1:4b:33
           inet adr:192.168.254.1  Bcast:192.168.254.255
Masque:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:20207169 errors:0 dropped:0 overruns:0 frame:0
           TX packets:17280402 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 lg file transmission:1000
           RX bytes:19068335140 (17.7 GiB)  TX bytes:8246313479 (7.6 GiB)
           Interruption:24 Adresse de base:0x1800

eth2      Link encap:Ethernet  HWaddr 00:04:75:df:1c:6d
           inet adr:192.168.253.1  Bcast:192.168.253.255
Masque:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:1843643 errors:0 dropped:0 overruns:0 frame:0
           TX packets:2416959 errors:13 dropped:0 overruns:0 carrier:0
           collisions:0 lg file transmission:1000
           RX bytes:157416047 (150.1 MiB)  TX bytes:2313298605 (2.1 GiB)
           Interruption:17 Adresse de base:0x8000

lo        Link encap:Boucle locale
           inet adr:127.0.0.1  Masque:255.0.0.0
           UP LOOPBACK RUNNING  MTU:16436  Metric:1
           RX packets:7839862 errors:0 dropped:0 overruns:0 frame:0
           TX packets:7839862 errors:0 dropped:0 overruns:0 carrier:0
           collisions:0 lg file transmission:0
           RX bytes:3713209874 (3.4 GiB)  TX bytes:3713209874 (3.4 GiB)

Interruptions:
            CPU0       CPU2
   0: 1253580857 1253580260     <NULL>  timer
   1:          0          0      sun4u  PSYCHO_PCIERR
   2:          0          0      sun4u  PSYCHO_UE
   3:          0          0      sun4u  PSYCHO_CE
   8:     733411          0      sun4u  su(kbd)
   9:          0    4396224      sun4u  su(mouse)
  10:          0          0      sun4u  parport0
  11:          4          0      sun4u  floppy
  12:          0          0      sun4u  cs4231(capture)
  13:          0          0      sun4u  cs4231(play)
  14:          0   37976886      sun4u  eth0
  15:          0  218660455      sun4u  sym53c8xx
  16:         30          0      sun4u  sym53c8xx
  17:    2042976    2011664      sun4u  eth2
  18:  137883796          0      sun4u  aic7xxx
  19:          0    1208028      sun4u  ohci_hcd:usb2
  20:          0     650947      sun4u  ohci_hcd:usb3
  21:          1          4      sun4u  ehci_hcd:usb1
  22:          0          0      sun4u  PSYCHO_PCIERR
  24:    4957716   33460983      sun4u  eth1

	Any idea ?

	Regards,

	JKB

