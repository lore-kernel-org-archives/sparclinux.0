From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Mon, 01 Mar 2010 11:30:05 +0000
Subject: Re: linux-image-2.6.26-1-sparc64-smp: [sparc] SunFire480R cassini network driver kernel panic
Message-Id: <20100301113005.GA2769@lemon.iwr.uni-heidelberg.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20100113082925.GA15798@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20100113082925.GA15798@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Jan 13, 2010 at 09:29:25AM +0100, Hermann Lauer wrote:
> I tried again with vanilla 2.6.32 (2.6.27-2.6.31 are unusable due to a kernel
> memory corruption bug), the driver is still crashing my Sunfire V480R.

Tried today vanilla 2.6.33, then did a:

# modprobe -v cassini cassini_debug=-1
insmod /lib/modules/2.6.33/kernel/drivers/net/cassini.ko cassini_debug=-1

In kern.log the messages appeared:

Mar  1 12:17:14 tantalus kernel: cassini.c:v1.6 (21 May 2008)
Mar  1 12:17:14 tantalus kernel: PCI: Enabling device: (0002:00:02.0), cmd 146
Mar  1 12:17:15 tantalus kernel: cassini: MAC address not found in ROM VPD
Mar  1 12:17:15 tantalus kernel: eth0: Sun Cassini+ (64bit/33MHz PCI/Cu) Ethernet[24] 08:00:20:cb:31:01
Mar  1 12:17:15 tantalus kernel: PCI: Enabling device: (0003:00:01.0), cmd 146
Mar  1 12:17:15 tantalus kernel: cassini: MAC address not found in ROM VPD
Mar  1 12:17:15 tantalus kernel: udev: renamed network interface eth0 to eth15
Mar  1 12:17:15 tantalus kernel: eth0: Sun Cassini+ (64bit/66MHz PCI/Cu) Ethernet[30] 08:00:20:bc:c7:b7
Mar  1 12:17:15 tantalus kernel: udev: renamed network interface eth0 to eth16
Mar  1 12:20:48 tantalus kernel: eth15: Link up at 1000 Mbps, full-duplex.
Mar  1 12:20:48 tantalus kernel: eth15: TX pause enabled
Mar  1 12:20:59 tantalus kernel: eth15: no IPv6 routers present

As before, setting up the interface with ifconfig works.
After sending out 68 pings the machine crashed with the usual 
Hardware FATAL RESET.

What can be done to debug this further ?

Thanks,
  Hermann 

<...registerdump omitted...>
2:0>Device Type = 5 
NUM OF BITS IN CSR/EMU Reg in device# 60  = 15 
	BITS [14..0] = 00000000 

Initiating Hardware FATAL RESET recovery
Resetting...

RSC Alert: Host System has Reset

ERROR: Hardware FATAL RESET Recovery

Executing POST w/%o0 = 0000.0800.0201.4041
0:0>
0:0>@(#)Sun Fire[TM] V480/V490 POST 4.22.34 2007/07/23 13:12 
       /export/delivery/delivery/4.22/4.22.34/post4.22.x/Camelot/cstone/integrated  (root)  
0:0>Copyright 2007 Sun Microsystems, Inc. All rights reserved

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
