From: Ed L Cashin <ecashin@uga.edu>
Date: Mon, 02 Feb 2004 18:51:38 +0000
Subject: Re: the late arch/sparc64/mm/init.c:__flush_cache_all
Message-Id: <87d68xco1x.fsf@uga.edu>
List-Id: <sparclinux.vger.kernel.org>
References: <87ektjdcu9.fsf@uga.edu>
In-Reply-To: <87ektjdcu9.fsf@uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

...
> Please download the UltraSPARC programmers manual from, for example:
>
> 	http://www.sun.com/processors/manuals/805-0087.pdf
>
> to learn how to program the chip.

I re-read all the manual sections describing the cache features.  My
intention was to find something that would allow me to do benchmarks
on a process for which I could disable caching.

The i386 has wbinvd which makes the cache write dirty pages to memory
and invalidate all entries, but the ultrasparc doesn't seem to have
anything like that.  You can loop over addresses doing displacement
flushing, but you have to make sure that the addresses you use are
already in the TLB, and I'm not sure how that's being done in the
kernel. 

    8.2.3
    
    ... Care must be taken to ensure that the range of read-only
    addresses is mapped in the MMU before starting a displacement
    flush, otherwise the TLB miss handler may put new data into the
    caches.

The manual also says that there are different kinds of addresses,
cachable and non-cachable, but I don't see any way to say, "Make all
of the VA's in this process non-cachable."

-- 
--Ed L Cashin            |   PGP public key:
  ecashin@uga.edu        |   http://noserose.net/e/pgp/

