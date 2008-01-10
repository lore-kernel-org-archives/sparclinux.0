From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Thu, 10 Jan 2008 17:43:10 +0000
Subject: 3Com NIC
Message-Id: <4786592E.6080303@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

	Hello,

	A long time ago, I have some troubles with 3Com (3c905) NIC on i386 and 
amd64. Since 2.6.22, I never have seen this trouble but with 2.6.23.12 
(sparc64/SMP), I randomly obtain a NETDEV WATCHDOG. It's not an hardware 
trouble because I have tested with several NIC.

	ifconfig returns :

eth2      Link encap:Ethernet  HWaddr 00:04:75:df:1c:6d
           inet adr:192.168.253.1  Bcast:192.168.253.255 
Masque:255.255.255.0
           UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
           RX packets:1019611 errors:0 dropped:0 overruns:782 frame:0
           TX packets:1244862 errors:4389 dropped:0 overruns:0 carrier:0
           collisions:0 lg file transmission:1000
           RX bytes:111193503 (106.0 MiB)  TX bytes:1119932615 (1.0 GiB)
           Interruption:17 Adresse de base:0x8000

	and dmesg :

NETDEV WATCHDOG: eth2: transmit timed out
eth2: transmit timed out, tx_status 00 status 8601.
   diagnostics: net 0ccc media 8880 dma 0000003a fifo 0000
eth2: Interrupt posted but not delivered -- IRQ blocked by another device?
   Flags; bus-master 1, dirty 224(0) current 224(0)
   Transmit list 00000000 vs. fffff800a05ce200.
   0: @fffff800a05ce200  length 8000007d status 0001007d
   1: @fffff800a05ce260  length 8000004e status 0001004e
   2: @fffff800a05ce2c0  length 8000004a status 0001004a
   3: @fffff800a05ce320  length 80000048 status 00010048
   4: @fffff800a05ce380  length 8000004a status 0001004a
   5: @fffff800a05ce3e0  length 80000042 status 00010042
   6: @fffff800a05ce440  length 8000004e status 0001004e
   7: @fffff800a05ce4a0  length 80000042 status 00010042
   8: @fffff800a05ce500  length 8000004e status 0001004e
   9: @fffff800a05ce560  length 80000048 status 00010048
   10: @fffff800a05ce5c0  length 8000004a status 0001004a
   11: @fffff800a05ce620  length 8000004e status 0001004e
   12: @fffff800a05ce680  length 80000042 status 00010042
   13: @fffff800a05ce6e0  length 80000042 status 00010042
   14: @fffff800a05ce740  length 80000042 status 80010042
   15: @fffff800a05ce7a0  length 80000052 status 80010052
eth2: Resetting the Tx ring pointer.

rayleigh:[~] > cat /proc/interrupts
            CPU0       CPU2
   0:  561601936  561601824     <NULL>  timer
   1:          0          0      sun4u  PSYCHO_PCIERR
   2:          0          0      sun4u  PSYCHO_UE
   3:          0          0      sun4u  PSYCHO_CE
   8:     461146          0      sun4u  su(kbd)
   9:          0    3350888      sun4u  su(mouse)
  10:          0          0      sun4u  parport0
  11:          2          0      sun4u  floppy
  12:          0          0      sun4u  cs4231(capture)
  13:     360263          0      sun4u  cs4231(play)
  14:          0   36484826      sun4u  eth0
  15:          0   27118288      sun4u  sym53c8xx
  16:         30          0      sun4u  sym53c8xx
  17:     906177    1171078      sun4u  eth2
  18:   19345145          0      sun4u  aic7xxx
  19:          1     584788      sun4u  ohci_hcd:usb2
  20:          0          0      sun4u  ohci_hcd:usb3
  21:          1        467      sun4u  ehci_hcd:usb1
  22:          0          0      sun4u  PSYCHO_PCIERR
  24:   27308743          0      sun4u  eth1
rayleigh:[~] >

	Regards,

	JKB
