From: Matthias Rosenfelder <rosenfelder.lkml@googlemail.com>
Date: Tue, 10 May 2011 02:11:23 +0000
Subject: [RFC/PATCH] sparc32/LEON: Cache flush during context switch
Message-Id: <4DC89ECB.6030309@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello,

I looked at the Leon code base and noticed several issues:

1.) As far as I can see, the leon_flush_needed() in mm/leon_mm.c is only
called from init_leon() in mm/srmmu.c. init_leon() is marked as __init,
but the leon_flush_needed() is not. So there is no point in having still
leon_flush_needed() lying around after boot and we should also add
__init to it.
But looking further at leon_flush_needed() reveals other things...


2.) What is the code in leon_flush_needed() actually doing? It tries to
conclude from the Leon cache config if a cache flush is needed during a
context switch. But as far as I know, this is never necessary. Why?
Because the Leon data and instruction caches hit only if the following
two conditions are true:

a) the virtual tag matches the upper bits of the virtual address in a
    given set and(!)
b) the current context number (from the SRMMU) matches the context
    number belonging to each cache line.

    The two conditions above ensure that if we change the address space,
there will _never_ be a cache hit that returns data from the old address
space. In fact, the moment we write a new (i.e. different) value into
the context number register of the SRMMU, the whole data cache will
become invalid. Every following access is guaranteed to produce a cache
miss because the context number does not match any more (even though the
valid bits may still be set). The currently residing cache lines will
then be evicted eventually during the following memory accesses
(assuming we don't change back to the old address space soon).

     The hit detection mechanism is mentioned in the GRIP manual [1] from
Aeroflex Gaisler (page 639, Section 62.6.1) and can be additionally
verified by looking into the Leon3 VHDL code (available at [2]) in
mmu_dcache.vhd, lines 512 -- 516. The same hit detection mechanism is
used for the instruction cache, too. For Leon4 I didn't find exact
information on cache hit generation in the manual. However, reading the
cache description in the manual makes me assume this has not changed
(it's almost the same text word for word). So, I'm not sure about Leon4
but at least for Leon3 flushing is not necessary.

    The Leon3 and 4 can also have physical tags but they are used _only_
for snooping / cache coherency. They are not used for hit/miss detec-
tion. Only the virtual tags and the context number belonging to every
cache line are used for hit/miss detection. It is therefore safe to
_always_ omit cache flushing during context switching. Remember that
the Leon caches are write-through, so main memory is always up-to-date.

    Thus, we can simply replace the whole leon_flush_needed() function
body with "return 0;". However, this also destroys the cache information
printed at boot time. Therefore, I suggest to add an explicit
print_leon3_cache_config() function. This also has the advantage that we
can correct the wrong cache terminology by Gaisler. During the Leon 2
and 3 development, they mixed up the cache "set" and cache "way" terms.
The VHDL code as well as the manuals for these processors are full of
these errors, but apparently for Leon4 they got it right. Thumbs up.

     In the last year, I have been using the Snapgear Linux distribution
from Gaisler based on kernel 2.6.21.1 on Leon2- and Leon3-based systems
without flushing the caches during a context switch. I experienced no
problems. However, I have not yet tested this on the current kernel
version but I'm pretty sure it will work there, too.


3.) The GRIP manual also says that a "flush" instruction flushes both
the data and the instruction cache (Section 62.5.1 on page 636). But for
flushing all caches in leon_flush_cache_all() not only a "flush"
instruction is issued but afterwards follows an explicit data cache
flush with a write to ASI_LEON_DFLUSH. Either the manual is wrong (which
would not amaze me much) or the second write is rather unnecessary.
However, I assume this does not hurt performance much as the cache is
already flushed by the "flush" right before.


What are your opinion on these three issues?
Thanks,

     Matthias

[1] http://www.gaisler.com/products/grlib/grip.pdf
[2] http://www.gaisler.com/products/grlib/grlib-gpl-1.1.0-b4104.zip
