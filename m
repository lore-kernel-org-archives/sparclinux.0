From: Bob Picco <bpicco@meloft.net>
Date: Fri, 04 Oct 2013 16:24:03 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <20131004162403.GM29427@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20130930.123130.354302574443157859.davem@davemloft.net>
In-Reply-To: <20130930.123130.354302574443157859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
David Miller wrote:	[Mon Sep 30 2013, 12:31:30PM EDT]
> 
> This is a respin of the original page_offset and 64-bit page
> table changes with some minor changes and a bug fix:
> 
> 1) Bob's ACKs for the first 6 patches added.
> 
> 2) Don't use "UL" postfix for shift counts, there is code that
>    wants those to be "int", particularly printfs in mm/mm_init.c
>    that use the "%d" format specifier for SECTIONS_SHIFT.
> 
> 3) Adjust VA_HOLE defines to match what the new 3-level page
>    tables can actually provide.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

This issue I was deflected from by a wind direction change and never returned
to it. I believe you have been here with winfix_trampoline and collapsed
THP thrills. A large userspace stack will encounter a
[ 7603.877098] thp_stack[4583]: segfault at 100758 ip 0000000000100764 (rpc 0000000000100750) sp 000007fefdfff6d1 error 30001 in thp_stack[100000+2000]
.

For THP enabled set to "never", there is no issue. This could be a core
mm issue but not certain.

I'll attempt and find the time to return to this.

thanx,

bob

<<CLIP HERE>>
#define	_GNU_SOURCE
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>

static unsigned long getfp()
{
	unsigned long fp;

	return  (unsigned long) &fp;
}

static void stack_grow(unsigned long start, unsigned long size, int bwait)
{
	unsigned long fp = getfp();
	unsigned long m = start - fp;
	unsigned long d;

	if (m > size) {
		fprintf(stderr, "at limit %lx\n", fp);
		if (bwait)
			for (d = 0; getfp() && d < (1UL <<30UL); d++);
		else
			sleep(5);
		return;
	} else 
		stack_grow(start, size, bwait);
}

void main(int argc, char **argv)
{
	unsigned long start = getfp();
	int loop, cnt, rc, bwait;
	unsigned long stk_sz;

	if (argc != 4)
		fprintf(stderr, "%s: stack-mb loop-count bwait\n", argv[0]),
			exit(1);

	rc = sscanf(argv[1], "%ld", &stk_sz);

	if (rc != 1)
		fprintf(stderr, "%s: stack-mb bad\n", argv[0]), exit(1);

	stk_sz <<= 20UL;

	rc = sscanf(argv[2], "%d", &loop);

	if (rc != 1)
		fprintf(stderr, "%s: loop count bad \n", argv[0]), exit(1);

	rc = sscanf(argv[3], "%d", &bwait);

	if (rc != 1)
		fprintf(stderr, "%s: bwait bad\n", argv[0]), exit(1);

	for (cnt = 0; cnt < loop; cnt++)
		stack_grow(start, stk_sz, bwait);
}
