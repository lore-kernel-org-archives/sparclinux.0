From: Matthias Rosenfelder <rosenfelder.lkml@googlemail.com>
Date: Tue, 10 May 2011 10:36:12 +0000
Subject: Re: [RFC/PATCH] sparc32/LEON: Cache flush during context switch
Message-Id: <4DC9151C.60506@googlemail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4DC89ECB.6030309@googlemail.com>
In-Reply-To: <4DC89ECB.6030309@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Am 10.05.2011 09:19, schrieb Daniel Hellstrom:
 >
 > Have you taken cache aliasing into account? The problem may be that
 > the same physical address may be mapped onto different virtual
 > addresses. This is no problem when there is only one location in
 > the cache multiple virtual addresses with the same page offset can
 > be located at, one virtual address mapped to the same physical
 > address will replace the other. That is why the check is for 4KByte
 > cache of less (less then one page) and only one set.

In this case cache aliasing is not an issue. It is only a problem if two
aliases (i.e. two virtual addresses that are mapped to the same
physical address) can be present in the cache _and_ the cache can
generate a hit when reading from one of these two after having written
the other one before. Then the cache hit will return the old data rather
than then new ones.

But in the case of context switching the cache does not generate a hit.
The context number stored alongside every cache line prevents this. You
never get a cache hit from data that was pulled into the cache in a
different address space than the current. That's why after _changing_
the address space the cache will produce a series of misses. It is like
flushing the cache atomically within one cycle when you write a
different context number into the SRMMU register.


 >
 > I have seen problems appearing when using shared memory or NFS.
 > Debugging this kind of problem is not easy, I can say honstly that
 > apart from another hardware related problem this was the hardest to
 > pinpoint so far in my career.

Even if the new and the old address spaces have shared memory it doesn't
matter. Due to the write-through nature of the data cache main
memory is always up-to-date and any cache miss will read correct data.
And any cache access after the address space change _is guaranteed_
to produce a miss and never return any data stored there previously.

I'm aware of the fact that those problems are very hard to debug. That's
why I would like to hear from other people on this list if they also
think this is okay and there is no error in my argumentation or
thinking.



 >
 > Note that there is a non-standard SRMMU modification to the LEON that
 > can be enabled, by changing the page size to 8k or 16k this problem
 > can be avoided a bit more. That patch required modifications to both
 > kernel and toolchain, it exists only for 2.6.21.1.

Yes, I have seen this. I suppose it is just there to be able to enlarge
the cache while still preventing the cache aliasing. But this only works
with a direct-mapped cache. With any associativity larger than one there
exists the possibility that two virtual aliases reside in the same cache
set but in different ways.

So what about multi-way cache configurations? Virtual aliases between
different address spaces are no problem due to the context number but
what about virtual aliases within the same address space? I know that
for accessing I/O often MMU bypass ASI is used that bypasses the Leon
data cache and therefore prevents cache aliasing problems. But are there
any other areas in which several virtual pages in one address space are
mapped to the same physical page frame within the Linux kernel?



 >
 > Please send document errors and question about LEON CPU implementation
 > to support_at_gaisler.com instead.
 >

Okay, I will do this.


 >>
 >> This also has the advantage that we
 >> can correct the wrong cache terminology by Gaisler. During the Leon 2
 >> and 3 development, they mixed up the cache "set" and cache "way" terms.
 >> The VHDL code as well as the manuals for these processors are full of
 >> these errors, but apparently for Leon4 they got it right. Thumbs up.
 >
 > Please do not change this.
 >
 > We are well aware of this problem, I think some day Jiri will present a
 > solution.

Hmm, this is non-standard terminology. How can others understand the
source code if it doesn't use the generally accepted terms found in
textbooks about computer architecture?

I think this might confuse a lot of people (as it did confuse me
in the past until I found out and understood the error) and should
therefore not be tolerated to remain in the Linux kernel in the long
run. The promise of a solution "some day" is way too vague for my taste.
This should be changed in the near future.


 >
 >>
 >> In the last year, I have been using the Snapgear Linux distribution
 >> from Gaisler based on kernel 2.6.21.1 on Leon2- and Leon3-based systems
 >> without flushing the caches during a context switch. I experienced no
 >> problems. However, I have not yet tested this on the current kernel
 >> version but I'm pretty sure it will work there, too.
 >
 > The old kernel also included leon_flush_needed(), however the code also
 > took LEON2 into account. So what is your cache configuration? Do you
 > feel lucky? :)
 >

I have been testing various cache configurations, mostly with Leon2 but
recently also with Leon3. Our latest configuration for Leon2 uses a
24 kiB data cache (3 way set associative; way size 8 kiB). The
instruction cache is 8 kiB in size (4 way set associative; way size
2 kiB). This works with the old Snapgear kernel and no cache flushing on
a context switch without experiencing problems. :-)

The Leon3 cache configuration is the standard one. If I remember
correctly there are a 4 kiB direct-mapped and a 8 kiB 2-way associative
cache but I don't remember which one was for data and instructions.


Thanks,

      Matthias



P.S.: I have not seen my first mail to appear on the list yet. But it is 
shown by marc.info as being received:

http://marc.info/?l=linux-sparc&m0501201909654&w=2

Is this my fault? I've not been using mailing lists before...
