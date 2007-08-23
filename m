From: David Miller <davem@davemloft.net>
Date: Thu, 23 Aug 2007 03:00:50 +0000
Subject: Re: Problems of PREFETCH instruction on UltraSparc T1
Message-Id: <20070822.200050.56199395.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <a8e8903d0708211701j47e6246eu57147ab1ab55e397@mail.gmail.com>
In-Reply-To: <a8e8903d0708211701j47e6246eu57147ab1ab55e397@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "jiaqi zhang" <zation.busy@gmail.com>
Date: Thu, 23 Aug 2007 13:11:13 +1200

> However, the problem is the performance gain is so tiny even after
> great efforts of tunning:

On stores, UltraSPARC-T1 isn't going to gain much from
use of prefetches, it is better to use prefetches for
data being read.

For stores, use the STORE-INIT alternate space store instructions.
Which preclear the cache line and force it into owned state without
any bus transactions.

When using store-init instructions, you must be writing to the
whole 64 bytes of the 64-byte aligned cache line.  The first
store to the cache line should be the one at offset zero,
and for best performance you should do consequetive increasing
stores so that they all compress in the store buffer.

For loads you should use the same alternate space ID, but with load
instructions and prefetch.  These require evenly numbered register
pairs, must be used with "ldxa" and loads two 8-byte registers at a
time.

You really should read the UltraSPARC-T1 supplement to the
UltraSPARC-2005 architecture manual found at the opensparc.org
web site, it explains all of this precisely.

Another example of good usage for high performance memory operations
is the arch/sparc64/lib/NGmemcpy.S memcpy() implementation in the
kernel sources.

Anyways, here is a test program I put together quickly so you
can see how to use the store-init instructions.  With USE_STORE_INIT
it should run about 4 times faster.

Can you figure out the rest yourself now?  :-/ I've a lot of time
teaching you the very basics how the chip works, when it's clearly
documented in the UltraSPARC-T1 programmers manual.

#include <stdio.h>
#include <stdlib.h>
#include <stddef.h>

#define BUF_SIZE (400 * 1024 * 1024)

#define ASI_BLK_INIT_QUAD_LDD_P	0xe2 /* (NG) init-store, twin load,
				      * primary, implicit
				      */

#define USE_STORE_INIT

static unsigned long tick_read_cost(void)
{
	unsigned long tbest = ~0UL;
	int i;

	for (i = 0; i < 8; i++) {
		unsigned long t2, t1;
		__asm__ __volatile__("rd %%tick, %0"
				     : "=r" (t1));
		__asm__ __volatile__("rd %%tick, %0"
				     : "=r" (t2));
		t2 -= t1;
		if (t2 < tbest)
			tbest = t2;
	}
	return tbest;
}

int main(void)
{
	unsigned long overhead = tick_read_cost();
	unsigned long tbest = ~0UL;
	void *p = valloc(BUF_SIZE);
	int iters;

	__asm__ __volatile__("wr %%g0, %0, %%asi\n\t"
			     : : "i" (ASI_BLK_INIT_QUAD_LDD_P));

	for (iters = 0; iters < 8; iters++) {
		unsigned long off, t2, t1;
		void *buf = p;

		__asm__ __volatile__("rd %%tick, %0"
				     : "=r" (t1));
		for (off = 0; off < BUF_SIZE; off += 64) {
			unsigned int *x = (unsigned int *) (buf + off);
			unsigned long data = 0x12341234;

#ifdef USE_STORE_INIT
			__asm__ __volatile__(
				"stxa %0, [%1 + 0x00] %%asi\n\t"
				"stxa %0, [%1 + 0x08] %%asi\n\t"
				"stxa %0, [%1 + 0x10] %%asi\n\t"
				"stxa %0, [%1 + 0x18] %%asi\n\t"
				"stxa %0, [%1 + 0x20] %%asi\n\t"
				"stxa %0, [%1 + 0x28] %%asi\n\t"
				"stxa %0, [%1 + 0x30] %%asi\n\t"
				"stxa %0, [%1 + 0x38] %%asi\n\t"
				: /* no outputs */
				: "r" (data), "r" (x));
#else
			__asm__ __volatile__(
				"stx %0, [%1 + 0x00]\n\t"
				"stx %0, [%1 + 0x08]\n\t"
				"stx %0, [%1 + 0x10]\n\t"
				"stx %0, [%1 + 0x18]\n\t"
				"stx %0, [%1 + 0x20]\n\t"
				"stx %0, [%1 + 0x28]\n\t"
				"stx %0, [%1 + 0x30]\n\t"
				"stx %0, [%1 + 0x38]\n\t"
				: /* no outputs */
				: "r" (data), "r" (x));
#endif
		}
		__asm__ __volatile__("rd %%tick, %0"
				     : "=r" (t2));
		t2 -= t1;
		if (t2 < tbest)
			tbest = t2;
	}
	printf("Best is %lu cycles\n", tbest - overhead);

	return 0;
}
