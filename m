From: Bob Picco <bpicco@meloft.net>
Date: Fri, 04 Oct 2013 15:45:55 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <20131004154555.GL29427@zareason>
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
We seem to have our first issue with THP.

I first encountered it with "ld". A THP enabled value of "never" resolved the
issue.

Verified no issue on four level page table. Also no issue on x86_64 with
3.7.x and 3.11 with unmodified test code.

I've reviewed most of TT 0x31 paths. I commenced moving up in mm layer. 

Of course the debug code could have a bug :) I did examine some strace
output to check posix_memalign but not the glibc source.

It is Debian Wheezy and compiled with -m64. This on the T4-2 local to me.

The issue appears to be corruption.

thanx,

bob

<<CLIP HERE>>
#define	_GNU_SOURCE
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <sys/mman.h>

#ifndef MADV_HUGEPAGE
#define MADV_HUGEPAGE	14
#endif

#define HPAGE_SHIFT	(22UL)
#define	HPAGE_SIZE	(1UL << HPAGE_SHIFT)
#define	PAGE_SHIFT	(13UL)
#define	NR_PAGES_HPAGE	(HPAGE_SIZE >> PAGE_SHIFT)
#define __round_mask(x, y) ((__typeof__(x))((y)-1))
#define round_up(x, y) ((((x)-1) | __round_mask(x, y))+1)

/* Note failure assumes an exit(1).
 */
void *allocate_thps(size_t sz)
{
	int rc;
	void *addr;
	size_t align = HPAGE_SIZE;

	rc = posix_memalign(&addr, align, sz);

	if (rc)
		perror("posix_memalign"), exit(1);

	rc = madvise(addr, sz, MADV_HUGEPAGE);

	if (rc)
		perror("madvise"), exit(1);

	return addr;
}

/* Verify the array.
 */
static void verify_thp(void *addr, void *end, int pagesize, int cnt)
{
	unsigned long pc;
	void *p;

	for (pc = 0, p = addr; p < end; p += pagesize, pc++) {
		if (*(unsigned long *) p != 0xbeefUL + (pc << 32UL)) {
			fprintf(stderr, "\n\tcnt = %d pc=0x%lx thp = 0x%lx "
				" addr=0x%lx *addr=0x%lx\n",
				cnt, pc, pc >> 9UL, p, *(unsigned long *) p);
			pc = (pc + NR_PAGES_HPAGE) & ~(NR_PAGES_HPAGE - 1);
			pc--;
			p = addr + (pc << PAGE_SHIFT);
		}
	}

}

int main(int argc, char **argv)
{
	void *addr, *end, *p;
	size_t sz;
	int pagesize = getpagesize();
	int loop, cnt, nthp, rc;
	int recycle = 1;
	unsigned long pc;
	int optind = 0;

	if (argc = 4 && argv[1][1] = 'a')
		optind = 1;
	else if (argc != 3)
		fprintf(stderr, "%s: -a iterations 4Mb-pages\n",
			argv[0]), exit(1);

	rc = sscanf(argv[optind + 1], "%d", &loop);

	if (rc != 1)
		fprintf(stderr, "%s: sscanf (%s) failed\n",
			argv[0], argv[optind + 1]), exit(1);

	rc = sscanf(argv[optind + 2], "%d", &nthp);

	if (rc != 1)
		fprintf(stderr, "%s: sscanf (%s) failed\n",
			argv[0], argv[optind + 2]), exit(1);

	if (optind)
		recycle = 0;

	sz = HPAGE_SIZE * nthp;

	for (cnt = 0; cnt < loop; cnt++) {
		addr = allocate_thps(sz);
		end = addr + sz;

		fprintf(stderr, "[0x%lx-0x%lx) ",
			(unsigned long) addr, (unsigned long) end);

		for (pc = 0, p = addr; p < end; p += pagesize, pc++)
			*(unsigned long *) p = 0xbeefUL + (pc << 32UL);

		verify_thp(addr, end, pagesize, cnt);

		sleep(cnt % 5);

		verify_thp(addr, end, pagesize, cnt);

		if (recycle)
			free(addr);

		fprintf(stdout, ".\n");
		fflush(stdout);
	}

	fprintf(stderr, "%s: Done! cnt = %d\n", argv[0], cnt);

	return 0;
}
