From: Ed L Cashin <ecashin@uga.edu>
Date: Sat, 21 Feb 2004 03:23:47 +0000
Subject: using perfctr to determine cache miss rate
Message-Id: <87u11l6rp8.fsf@uga.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.  I'm starting to use the sparc64-specific perfctr system call,
after reading the UltraSPARC IIi User's Manual Appendix B on
Performance Instrumentation.

What I really want to do is to find out how often loads and stores are
having to go out to RAM instead of hitting in "the cache" (any cache).
Specifically, I'm interested in whether the loads and stores in a
running userspace program are low-latency or high-latency.

I wrote the test program below, which observes the number of dcache
read misses between calls.  In conjunction with the tick register, I
could efficiently estimate the miss rate on dcache reads.  

Is there a way to measure the number of memory accesses (both reads
and writes) that are not hitting in any cache?  It appears not to be
possible, since only two events can be observed at once, and the
events are quite specific (e.g. observing dcache write hits makes
dcache read hits unobservable).


/* main.c - try out sparc64 the kernel's performance counter exporting
 */
#include <stdio.h>
#include <stdlib.h>
#include <linux/unistd.h>
#include <asm-sparc64/perfctr.h>
#include <errno.h>

_syscall4(int, perfctr, int, opcode, 
	  unsigned long, arg0, unsigned long, arg1, unsigned long, arg2);

unsigned long long d0;	/* dc reads */
unsigned long long d1;	/* dc read hits */

void usemem(void)
{
    static unsigned int data[10];
    int i;

    for (i = 0; i < 1000; ++i) {
      unsigned int n = data[random() % 10];

      data[random() % 10] = n;
    }
}

void test(void)
{
    usemem();
    printf("after usemem dc read misses:0x%016llx\n", d0 - d1);
    if (perfctr(PERFCTR_READ, 0,0,0)) {
      perror("read");
      exit(EXIT_FAILURE);
    }
}    

int main(void)
{
    unsigned long pcr = USR|DC_RD|DC_RD_HIT;
    int i;

    if (perfctr(PERFCTR_ON, 
		(unsigned long) &d0,
		(unsigned long) &d1,
		pcr)) {
      perror("turn on");
      exit(EXIT_FAILURE);
    }

    for (i = 0; i < 100; ++i)
      test();

    if (perfctr(PERFCTR_OFF, 0,0,0)) {
      perror("turn off");
      exit(EXIT_FAILURE);
    }

    return 0;
}


-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

