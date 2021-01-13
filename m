From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date: Wed, 13 Jan 2021 10:59:24 +0000
Subject: Re: [patch 3/4] mips/mm/highmem: Use set_pte() for kmap_local()
Message-Id: <20210113105924.GA10822@alpha.franken.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20210112170136.078559026@linutronix.de>
 <20210112170411.187513575@linutronix.de>
In-Reply-To: <20210112170411.187513575@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, Paul Cercueil <paul@crapouillou.net>, Andreas Larsson <andreas@gaisler.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org

On Tue, Jan 12, 2021 at 06:01:39PM +0100, Thomas Gleixner wrote:
> set_pte_at() on MIPS invokes update_cache() which might recurse into
> kmap_local(). Use set_pte() like the original MIPS highmem implementation
> did.
> 
> Fixes: a4c33e83bca1 ("mips/mm/highmem: Switch to generic kmap atomic")
> Reported-by: Paul Cercueil <paul@crapouillou.net>
> Reported-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  arch/mips/include/asm/highmem.h |    1 +
>  1 file changed, 1 insertion(+)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
