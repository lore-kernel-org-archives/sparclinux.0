From: David Miller <davem@davemloft.net>
Date: Mon, 04 Aug 2014 23:26:23 +0000
Subject: Re: [PATCH] Prevent flushing of locked PROM ITLB entry (RED State Exception or hang on reboot)
Message-Id: <20140804.162623.2129018855080427434.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <201407271539.40156.cat.schulze@alice-dsl.net>
In-Reply-To: <201407271539.40156.cat.schulze@alice-dsl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 3 Aug 2014 14:58:36 +0200

> __purge_vmap_area_lazy() is in mm/vmalloc.c, as is __vunmap(). The line
> discipline part is mostly irrelevant, but may be interesting, as I remember
> having read on this mailing list that others tracked the reboot problem to
> memory allocation changes in the ldisc layer. These changes may have
> initially triggered the problematic __vunmap() call that kills the locked
> PROM mapping.

The problem was introduced by:

commit db64fe02258f1507e13fe5212a989922323685ce
Author: Nick Piggin <npiggin@suse.de>
Date:   Sat Oct 18 20:27:03 2008 -0700

    mm: rewrite vmap layer

which added the lazy VMAP tlb flushing.

The issue is that since and module and VMALLOC areas (both managed
by VMAP handling) are not contiguous, you can end up flushing across
the openfirmware region if f.e. a module is unloaded and some vfree()'s
occur.

I've sent an email to Nick Piggin who added this code, you were CC:'d.

If Nick doesn't agree to fix this in the VMAP lazy flushing layer, and
we implement a fix using your approach, I think we have to stop making
flush_tlb_kernel_range() a macro and instead implement it inside of
arch/sparc/kernel/init_64.c or similar as a real function.

Thanks.
