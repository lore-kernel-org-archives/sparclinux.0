From: "Art Haas" <ahaas@airmail.net>
Date: Wed, 21 Apr 2004 20:31:17 +0000
Subject: Re: No luck booting latest 2.6.6-rc kernels
Message-Id: <20040421203117.GA7013@artsapartment.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20040421185159.GB7445@artsapartment.org>
In-Reply-To: <20040421185159.GB7445@artsapartment.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, Apr 21, 2004 at 02:28:41PM -0500, Art Haas wrote:
> On Wed, Apr 21, 2004 at 11:59:16AM -0700, William Lee Irwin III wrote:
> > Is this booting with -p? Must be early if so.
> 
> No, I'm not using '-p' as a boot argument. I've found a bit of text
> about using a '-p' boot option in arch/sparc/prom/printf.c, but haven't
> used it before. The 'Booting Linux...' message seems to come from
> device_scan() in arch/sparc/kernel/devices.c.
> 

So, now that I've found out about '-p', here's what booting with it
produces ...

Uncompressing image...
Loaded kernel version 2.6.6
PROMLIB: obio_ranges 5
PROMLIB: Sun Boot Prom Version 3 Revision 2
Linux version 2.6.6-rc2 ([ ... blah blah blah ... ])
ARCH: SUN4M
TYPE: Sun4m SparcStation10/20
Ethernet addres: 8:0:20:78:eb:9e
Boot time fixup v1.6, 4/Mar/98 ([... blah blah blah ...])
Patching kernel for srmmu[TI Viking/MXCC]/iommu
319MB HIGHMEM available
On node 0 total pages: 130406
  DMA zone: 48663 pages, LIFO batch:11
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 81743 pages, LIFO batch:16
{ ... stuff ... }
Booting Linux...
Power off control detected
Built 1 zonelists
Kernel command line: root=/dev/sda1 ro -p
PID hash table entries: 2048 (order 11: 16384 bytes)
Console: colour dummy device 80x25
Memory: 510688k available (1360k kernel code; 316k data, 128k init,
326927K high mem) [f0000000,1ff4f000]
Calibrating delay loop... 59.80 BogoMIPS
Dentry cache hash table entries: 131072 (order 7, 524288 bytes)

After this point things got stuck ... for several minutes while I typed
the lines above. Then, an oops showed up:

Unable to handle kernel NULL pointer dereference
tsk->{mm,active_mm}->context = ffffffff
tsk->{mm,active_mm}->pgd = fc000000
[ ... oops-face ... ]
swapper(0): Oops [#1]
PSR: 40401fc6 PC: f00403e8 NPC: f00403ec Y: 00000000  Not tainted
PC: <__queue_work+0x14/0x58>
%G: f017b000 00000008 00000000 f0181898 f0039ca4 00000001 f000e000 00000000
%0: 404010e7 0000003b f017b000 404010e6 f017b340 f01cd00f f00ffb90 f00403d8
RPC: <__queue_work+0x4/0x58>
%L: 40801fc7 f0039d00 f0039d04 00000080 00000000 f017b000 f000e000 00000e00
%I: 00000000 f0181894 ffffffff 00000000 f00b6284 f01cd02c f000fbf8 f0040468
Caller[f0040468]: queue_work+0x3c/0x4c
Caller[f0039f2c]: run_timer_softirq+0xd8/0x194
Caller[f0035b28]: __do_softirq+0x98/0xbc
Caller[f0035b8c]: do_softirq+0x40/0x54
Caller[f0011f08]: patch_handler_irq+0x0/0x24
Caller[f01b6bec]: dcache_init+0x118/0x168
Caller[f01b6cdc]: vfs_caches_init+0xa0/0xe4
Caller[f01a9db8]: start_kernel+0x15c/0x1c0
Caller[f01a9790]: sun4c_continue_boot+0x314/0x324
Caller[00000000]: 0x0
Instruction DUMP: 01000000 f0266014 82062008 <c6006004> 84066004
c2266004 c4206004 c420c000 c620a004
Kernel panic: Aiee, killing interrupt handler

Hand-typed oops report is above, so inadvertant typos are possible ...

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
