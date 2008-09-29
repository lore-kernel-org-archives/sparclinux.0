From: Hermann Lauer <Hermann.Lauer@iwr.uni-heidelberg.de>
Date: Mon, 29 Sep 2008 08:19:54 +0000
Subject: Re: kernel crashes on Sun Fire 480R with cassini network driver
Message-Id: <20080929081954.GA20331@lemon.iwr.uni-heidelberg.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="ZPt4rx8FFjLCG7dd"
List-Id: <sparclinux.vger.kernel.org>
References: <20080923133152.GC17211@lemon.iwr.uni-heidelberg.de>
In-Reply-To: <20080923133152.GC17211@lemon.iwr.uni-heidelberg.de>
To: sparclinux@vger.kernel.org


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello all,

On Wed, Sep 24, 2008 at 12:12:35AM +0200, Hermann Lauer wrote:
> while trying to run vanilla linux-2.6.26.5 or the debian etchnhalf kernel
> (2.6.24.x) I noticed the cassini network driver for the builtin gigabit
> network is unstable and brings the kernel down on a dualprocessor sparc
> SunFire 480R with a Hardware FATAL RESET.

Tried to exchange a slower CPU module (contain 2 CPU and the memory)
from a V880 running sparc linux to the crashing 480R to rule out
CPU/memory related problems. Did not change the behavior of both
machines, so the cassini network driver looks to me still as the
main source of trouble.

I now noticed that even a few pings are possible with the cassini
network driver if you configure it statically, but then the machine again 
crashes with the known: 
ERROR: System Hardware FATAL RESET from  CPU0 CPU2

I appended the lspci -v output now.
Could I provide something else which would be usefull ?

Thanks,
  Hermann

-- 
Netzwerkadministration/Zentrale Dienste, Interdiziplinaeres 
Zentrum fuer wissenschaftliches Rechnen der Universitaet Heidelberg
IWR; INF 368; 69120 Heidelberg; Tel: (06221)54-8236 Fax: -5224
Email: Hermann.Lauer@iwr.uni-heidelberg.de
--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lspci-v.out"

0000:00:03.0 SCSI storage controller: QLogic Corp. QLA2200 64-bit Fibre Channel Adapter (rev 05)
        Subsystem: QLogic Corp. Device 4082
        Flags: 66MHz, medium devsel, IRQ 6
        I/O ports at 0300 [disabled] [size=256]
        Memory at 00100000 (32-bit, non-prefetchable) [disabled] [size=8K]
        [virtual] Memory at fffff80200000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Memory at fffff80200000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Memory at fffff80200000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Memory at fffff80200000000 (32-bit, non-prefetchable) [disabled] [size=1]
        Expansion ROM at 00120000 [disabled] [size=128K]
        Capabilities: [44] Power Management version 1

0000:00:06.0 IDE interface: Silicon Image, Inc. PCI0646 (rev 07) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: Silicon Image, Inc. PCI0646
        Flags: bus master, medium devsel, latency 64, IRQ 7
        I/O ports at 0400 [disabled] [size=8]
        I/O ports at 0418 [disabled] [size=8]
        I/O ports at 0410 [disabled] [size=8]
        I/O ports at 0408 [disabled] [size=8]
        I/O ports at 0420 [disabled] [size=16]
        [virtual] Memory at fffff80200000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Expansion ROM at fffff80200000000 [disabled] [size=1]
        Capabilities: [60] Power Management version 1

0001:00:01.0 PCI bridge: Digital Equipment Corporation DECchip 21154 (rev 05)
        Flags: bus master, 66MHz, medium devsel, latency 64
        [virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [size=1]
        [virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [size=1]
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
        I/O behind bridge: 00001000-00001fff
        Memory behind bridge: 00100000-001fffff
        [virtual] Expansion ROM at fffff80300000000 [disabled] [size=1]
        Capabilities: [dc] Power Management version 1

0001:01:04.0 SCSI storage controller: QLogic Corp. QLA2200 64-bit Fibre Channel Adapter (rev 05)
        Subsystem: QLogic Corp. Device 4083
        Flags: 66MHz, medium devsel, IRQ 10
        I/O ports at 1000 [disabled] [size=256]
        Memory at 00100000 (32-bit, non-prefetchable) [disabled] [size=8K]
        [virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [disabled] [size=1]
        Expansion ROM at 00120000 [disabled] [size=128K]
        Capabilities: [44] Power Management version 1

0001:01:05.0 SCSI storage controller: QLogic Corp. QLA2200 64-bit Fibre Channel Adapter (rev 05)
        Subsystem: QLogic Corp. Device 4083
        Flags: 66MHz, medium devsel, IRQ 11
        I/O ports at 1100 [disabled] [size=256]
        Memory at 00102000 (32-bit, non-prefetchable) [disabled] [size=8K]
        [virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Memory at fffff80300000000 (32-bit, non-prefetchable) [disabled] [size=1]
        Expansion ROM at 00140000 [disabled] [size=128K]
        Capabilities: [44] Power Management version 1

0002:00:01.0 Bridge: Sun Microsystems Computer Corp. RIO EBUS (rev 01)
        Flags: bus master, medium devsel, latency 64
        BIST result: 00
        Memory at fffff80400000000 (32-bit, non-prefetchable) [size=1]
        Memory at fffff80400000000 (32-bit, non-prefetchable) [size=1]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=1]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=1]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=1]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=1]
        Expansion ROM at fffff80400000000 [disabled] [size=1]

0002:00:01.3 USB Controller: Sun Microsystems Computer Corp. RIO USB (rev 01) (prog-if 10)
        Flags: medium devsel, IRQ 22
        BIST result: 00
        Memory at 01000000 (32-bit, non-prefetchable) [disabled] [size=16M]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [disabled] [size=1]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [disabled] [size=1]
        Expansion ROM at 00c00000 [disabled] [size=4M]

0002:00:02.0 Ethernet controller: Sun Microsystems Computer Corp. Cassini 10/100/1000 (rev 11)
        Flags: bus master, 66MHz, slow devsel, latency 64, IRQ 23
        Memory at 00200000 (32-bit, non-prefetchable) [size=2M]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=1]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=1]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=1]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=1]
        [virtual] Memory at fffff80400000000 (32-bit, non-prefetchable) [size=1]
        Expansion ROM at 02000000 [disabled] [size=1M]
        Kernel driver in use: cassini

--ZPt4rx8FFjLCG7dd--
