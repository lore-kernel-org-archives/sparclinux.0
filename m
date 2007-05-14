From: David Miller <davem@davemloft.net>
Date: Mon, 14 May 2007 22:11:48 +0000
Subject: Re: slab hang on boot
Message-Id: <20070514.151148.45744375.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705142133190.17204@math>
In-Reply-To: <Pine.SOC.4.64.0705142133190.17204@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, clameter@sgi.com

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 14 May 2007 21:36:42 +0300 (EEST)

> Sorry, I could not test the parport patch yet - I did git upgrade as of 
> yesterday and the kernel hangs on boot. boot -p reveals the following 
> slab panic:

Please enable SLUB to work around this for now, SLAB wants
LARGE_ALLOCS enabled when it really shouldn't require that
for a 512K or 1MB SLAB when PAGE_SIZE=8192 :-(

> kmem_cache_create: Early error in slab tsb_512KB
> kernel BUG at mm/slab.c:2165!

Christoph, this is why I had to have LARGE_ALLOCS enabled on sparc64
all this time, for that MAX_OBJ_ORDER logic in mm/slab.c in order
to get 512K and 1MB slab caches usable.

This inconsistency is painful for platforms.  If I enable LARGE_ALLOCS
on sparc64 then SLAB works but it's a total waste for SLUB.

Right now if I enable LARGE_ALLOCS, SLUB will break again due to
that KMALLOC_SHIFT_HIGH bug we fixed the other week, Christophe
can you at least push that fix to Linus if you haven't already?

Thanks.
