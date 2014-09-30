From: Bob Picco <bpicco@meloft.net>
Date: Tue, 30 Sep 2014 13:17:48 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20140930131748.GB24640@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Mon Sep 29 2014, 10:16:37PM EDT]
> From: David Miller <davem@davemloft.net>
> Date: Mon, 29 Sep 2014 21:57:35 -0400 (EDT)
> 
> > From: Bob Picco <bpicco@meloft.net>
> > Date: Mon, 29 Sep 2014 18:35:22 -0400
> > 
> >> This is M7-4:
> >> MM: PAGE_OFFSET is 0xfffe000000000000 (max_phys_bits = 49)^M
> >> MM: VMALLOC [0x0000000100000000 --> 0x0001000000000000]^M
> >> MM: VMEMMAP [0x0001000000000000 --> 0x0002000000000000]^M
> >> Kernel: Using 3 locked TLB entries for main kernel image.^M
> >> Remapping the kernel... done.^M
> >> ..
> >> Early memory node ranges^M
> >>   node   0: [mem 0x50400000-0x3fbf6bdfff]^M
> >>   node   0: [mem 0x3fbf6c4000-0x3fbf6c5fff]^M
> >>   node   1: [mem 0x400000000000-0x403bffffffff]^M
> >>   node   2: [mem 0x800000000000-0x803fffffffff]^M
> >>   node   3: [mem 0xc00000000000-0xc03fffd5dfff]^M
> >>   node   3: [mem 0xc03fffd90000-0xc03fffdaffff]^M
> >>   node   3: [mem 0xc03fffdc0000-0xc03fffdc3fff]^M
> >> Booting Linux...^M
> >> CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]^M
> >> CPU CAPS: [popc,vis,vis2,ASIBlkInit,fmaf,vis3,hpc,ima]^M
> >> CPU CAPS: [pause,cbcond,aes,des,camellia,md5,sha1,sha256]^M
> >> CPU CAPS: [sha512,mpmul,montmul,montsqr,crc32c]^M
> >> PERCPU: max_distance=0xc000c2410000 too large for vmalloc space 0xffff00000000^M
> >> PERCPU: auto allocator failed (-22), falling back to page size^M
> >> PERCPU: 6 8K pages/cpu @0000000100000000 s23552 r8192 d17408^M
> > 
> > Ok, it looks like we need to expand the vmalloc area a bit or two
> > more, which is easy to do.  I'll cook up a patch for that.
> 
> Ok, this should do it, it's on top of my patch series:
Yes, I agree.

This is my cryptic confirmation the values will satisfy T5-8 and M7-4.

(gdb) p 0x0006000000000000UL-0x0000000100000000UL
$1 = 0x5ffff00000000
VMALLOC_TOTAL
(gdb) p 0x5ffff00000000UL * 3 / 4
$2 = 0x47fff40000000
(gdb) p 0xc000c2410000UL > 0x47fff40000000UL
M7-4
(gdb) p 0x380001c10000UL > 0x47fff40000000UL
$4 = 0x0
T5-8
.

Note the M7-4 max_distance was borrowed from last attempt before this
email's patch.

Unfortunately for M7-4 boot confirmation will have to wait. I lost a node
(socket). Of course three nodes booted beyond percpu space but then chaos
ensued :) I strongly doubt this is related to what we are focusing on here!

M7-4(?)
Allocated 40960 bytes for kernel page tables.
Zone ranges:
  DMA      [mem 0x50400000-0xffffffffffffffff]
  Normal   [mem 0x00000000-0x803fffdc5fff]
Movable zone start for each node
Early memory node ranges
  node   0: [mem 0x50400000-0x3fbf8d3fff]
  node   0: [mem 0x3fbf8da000-0x3fbf8dbfff]
  node   1: [mem 0x400000000000-0x403bffffffff]
  node   2: [mem 0x800000000000-0x803fffd6ffff]
  node   2: [mem 0x803fffda2000-0x803fffdc5fff]
Booting Linux...
CPU CAPS: [flush,stbar,swap,muldiv,v9,mul32,div32,v8plus]
CPU CAPS: [popc,vis,vis2,ASIBlkInit,fmaf,vis3,hpc,ima]
CPU CAPS: [pause,cbcond,aes,des,camellia,md5,sha1,sha256]
CPU CAPS: [sha512,mpmul,montmul,montsqr,crc32c]
PERCPU: Embedded 7 pages/cpu @fff8003f3c000000 s23552 r8192 d25600 u65536
SUN4V: Mondo queue sizes [cpu(131072) dev(16384) r(8192) nr(256)]

I'll share my T5-2 should you like but there is no issue.

Let me find time for spec-jbb and DEBUG_PAGEALLOC.

thanx!
