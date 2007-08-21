From: David Miller <davem@davemloft.net>
Date: Tue, 21 Aug 2007 19:09:14 +0000
Subject: Re: oops in sunsab_interrupt
Message-Id: <20070821.120914.36663917.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0708211359080.24028@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0708211359080.24028@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Tue, 21 Aug 2007 18:47:16 +0300 (EEST)

> I switched fro Ultra 1 to Ultra 5 with my intermittent boot hang 
> debugging because of faster compilation. However, the "booting" kernel 
> hangs later in boot process with this oops after switching away from 
> serial console (? - I do use serial console actually, why is it telling 
> about switching console to colour frame buffer device??).

If you have CONFIG_VT enabled, it first switches to that as the
console even if no framebuffer is attached to the backend.  Later
it switches back to the serial console.

Yes, it's stupid, and I don't like how that works either.

> Unable to handle kernel NULL pointer dereference
> tsk->{mm,active_mm}->context = 0000000000000000
> tsk->{mm,active_mm}->pgd = fffff800007999b0
>               \|/ ____ \|/
>               "@'/ .. \`@"
>               /_| \__/ |_\
>                  \__U_/
> swapper(1): Oops [#1]
> TSTATE: 0000008880f01606 TPC: 00000000005aa2b8 TNPC: 00000000005aa2bc Y: 00000000    Not tainted
> TPC: <receive_chars+0x320/0x440>
> g0: 00000000004209d0 g1: 0000000000000000 g2: 0000000000000000 g3: 0000000000000000
> g4: fffff800015d8000 g5: 0000000000000000 g6: fffff800015dc000 g7: fffff8001febb980
> o0: fffff8001febbb40 o1: 0000000000000000 o2: 0000000000000000 o3: fffff8001febbb40
> o4: 0000000000000000 o5: 0000000000000000 sp: fffff800015dedd1 ret_pc: 00000000004abfb4
> RPC: <kmem_cache_alloc+0x9c/0xc0>
> l0: 0000000000763380 l1: fffff800015dfd80 l2: 0000000000000000 l3: 00000000000001f4
> l4: 0000000000000000 l5: 00000000006fc800 l6: 0000000000000000 l7: 000000000079d800
> i0: fffff8001feb38e0 i1: fffff800015df77e i2: ffffffffffffffff i3: 000000000048529c
> i4: fffff80000b53c58 i5: 000001fff1400000 i6: fffff800015deec1 i7: 00000000005aab84
> I7: <sunsab_interrupt+0x1ec/0x240>
> Caller[00000000005aab84]: sunsab_interrupt+0x1ec/0x240

Can you add some debugging to drivers/serial/sunsab.c:receive_chars()
to see what might have a bad pointer?  I suspect the tty has become
NULL or corrupted, or some datastructure hung off of it.

Thanks.

