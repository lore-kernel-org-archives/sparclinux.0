From: Bob Picco <bpicco@meloft.net>
Date: Thu, 02 Oct 2014 14:24:35 +0000
Subject: Re: [PATCH v2 0/8] sparc64: MM/IRQ patch queue.
Message-Id: <20141002142435.GE22365@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20140927.142812.2031647355756795530.davem@davemloft.net>
In-Reply-To: <20140927.142812.2031647355756795530.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,
Bob Picco wrote:	[Wed Oct 01 2014, 05:51:09PM EDT]
> Hi,
> David Miller wrote:	[Wed Oct 01 2014, 04:44:55PM EDT]
> > From: David Miller <davem@davemloft.net>
> > Date: Wed, 01 Oct 2014 16:42:01 -0400 (EDT)
> > 
> > > From: Bob Picco <bpicco@meloft.net>
> > > Date: Wed, 1 Oct 2014 10:29:00 -0400
> > > 
> > >> [root@ca-qasparc24 ~]# Unable to handle kernel NULL pointer dereference
> > >> BUG: Bad page map in process cc1  pte:9800003fdd860690 pmd:183f3f4b6000
> > >> page:000600007fbb0c00 count:107055216 mapcount:-524287 mapping:          (null) index:0xfff8000107659c00
> > >> page flags: 0x6c4b6e00004f56(error|referenced|dirty|active|owner_priv_1|arch_1|reserved|private|head)
> > >> page dumped because: bad pte
> > > 
Okay I have two meetings today.

This is where we seem to go bad on T4-2. We go equally bad very quickly on
T5-8 with all patches applied and !THP.

T4-2 is configured for THP "madvise". At this commit:
59a35b1 sparc64: Use kernel page tables for vmemmap.
we seem to fall apart on T4-2 with the program below.

./thp4-loop -a 1024 8192

This all needs to be reverified.

thanx!

<<toy program>>

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

	if (rc) {
		static int warn_once;

		if (warn_once)
			goto out;
		fprintf(stderr, "Couldn't madvise for MADV_HUGEPAGE.\n");
		warn_once = 1;
	}
out:
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
