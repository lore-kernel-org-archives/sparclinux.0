From: "David S. Miller" <davem@redhat.com>
Date: Wed, 28 Jan 2004 21:46:47 +0000
Subject: Re: the late arch/sparc64/mm/init.c:__flush_cache_all
Message-Id: <20040128134647.16e09369.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <87ektjdcu9.fsf@uga.edu>
In-Reply-To: <87ektjdcu9.fsf@uga.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 28 Jan 2004 15:42:38 -0500
Ed L Cashin <ecashin@uga.edu> wrote:

> My first question is why the function was removed.  With Seth Arnold's
> help, I found the patch at bkbits.net that removes __flush_cache_all,
> but the only clue is the subject header, "[SPARC64]: vmap/vunmap cache
> flushing need not do anything."  I don't really understand why the
> function was removed.

Because we no longer need to flush the whole thing in the kernel
any more, only specific addresses.

> Can use flushw_all and flush g6 to clear the dcache, icache, and
> ecache?

No, flushw_all() flushes the cpu register windows and "flush g6" flushes
one cacheline in the instruction cache.

Please download the UltraSPARC programmers manual from, for example:

	http://www.sun.com/processors/manuals/805-0087.pdf

to learn how to program the chip.


> Also, and less important---in __flush_cache_all's inline asm, I
> expected the percent sign to be escaped, as in the other init.c
> functions.  Why is there only one percent sign?
> 
> -- 
> --Ed L Cashin            |   PGP public key:
>   ecashin@uga.edu        |   http://noserose.net/e/pgp/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe sparclinux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
