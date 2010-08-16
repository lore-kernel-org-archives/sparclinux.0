From: David Miller <davem@davemloft.net>
Date: Mon, 16 Aug 2010 02:23:00 +0000
Subject: Re: bootcup crash in prom tree building with specific PCI card
Message-Id: <20100815.192300.98878371.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1006071233090.4132@math.ut.ee>
In-Reply-To: <alpine.SOC.1.00.1006071233090.4132@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 7 Jun 2010 17:57:50 +0300 (EEST)

> swapper(0): Dax [#1]
> TSTATE: 0000000080e01604 TPC: 0000000000878328 TNPC: 0000000000878234 Y: 00000000    Not tainted
> TPC: <__lmb_alloc_base+0x14c/0x164>
> g0: 0000000000000000 g1: 00000000008e0c00 g2: 00000000008e0d58 g3: fffffffffffffff8
> g4: 0000000000829ef0 g5: 0000000000000000 g6: 0000000000820000 g7: 0000000000000000
> o0: 00000000008e0d58 o1: 00000000008e1598 o2: 0000000000000080 o3: 0000000000000000
> o4: 000000001fede000 o5: 4501dc2230dcde41 sp: 0000000000822ea1 ret_pc: 2a4ee00e10a8e7c8
> RPC: <0x2a4ee00e10a8e7c8>
> l0: 32a4ee00e101ada5 l1: 0000000000000000 l2: 00000000f00673e8 l3: 0000000000820000
> l4: 0000000000000004 l5: 0000000000000004 l6: 0000000000000000 l7: fffffffffffffff0
> i0: 0000000000000050 i1: ffffffffffffffc0 i2: 0000000000000000 i3: 0000000000000000
> i4: fffff8001fed6340 i5: 0000000000000000 i6: 0000000000822f51 i7: 0000000000878380
> I7: <lmb_alloc_base+0xc/0x34>

So, something overwrites the 'lmb' datastructures in the kernel as we
pull in the device tree.

The symbol 'lmb' sits shortly after p1275buf, which is where we store
arguments and return values for all prom calls.

What you could do is annotate arch/sparc/kernel/prom_common.c, function
build_one_prop() with printouts of the value of lmb.memory.cnt

A good spot would be around the prom_firstprop() and prom_nextprop()
invocations.

Once you see garbage values like "0x2a4ee00e10a8e7c8" in lmb.memory.cnt
then you know we passed the point that corrupted memory.

I suspect there is some issue with the unusually long property names
"driver,aapl,macosx,powerpc" and "driver,aapl,macos,powerpc"

I tried to find obvious problems with such things, but all the code
can handle (as best as I can tell) any propery name less than 32 bytes
and these are far within that range.

Let me know what the debugging shows you.  Please debug against the
same kernel you reproduced this with, because current kernels have
renamed all of the "lmb*" routines to "memblock*" and also this whole
slew or routines and datastructed have been moved out of lib/ and into
mm/ which will place everything in a different spot in the kernel
image, and therefore change what gets corrupted.  With how things are
in your particular kernel (lmb sitting right after p1275buf et al.)
it'll be much easier to debug.

Thanks.

