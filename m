From: Ed L Cashin <ecashin@uga.edu>
Date: Wed, 28 Jan 2004 20:42:38 +0000
Subject: the late arch/sparc64/mm/init.c:__flush_cache_all
Message-Id: <87ektjdcu9.fsf@uga.edu>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi.  I'm trying to find out which function to use to flush or disable
the ultrasparc's dcache, icache, and ecache.  On my way, I discovered
the __flush_cache_all function in arch/sparc64/mm/init.c.  It is
absent from the current kernel, but it was present a few months ago.

void __flush_cache_all(void)
{
	/* Cheetah should be fine here too. */
	if (tlb_type = spitfire) {
		unsigned long va;

		flushw_all();
		for (va =  0; va < (PAGE_SIZE << 1); va += 32)
			spitfire_put_icache_tag(va, 0x0);
		__asm__ __volatile__("flush %g6");
	}
}

My first question is why the function was removed.  With Seth Arnold's
help, I found the patch at bkbits.net that removes __flush_cache_all,
but the only clue is the subject header, "[SPARC64]: vmap/vunmap cache
flushing need not do anything."  I don't really understand why the
function was removed.

Can use flushw_all and flush g6 to clear the dcache, icache, and
ecache?

Also, and less important---in __flush_cache_all's inline asm, I
expected the percent sign to be escaped, as in the other init.c
functions.  Why is there only one percent sign?

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

