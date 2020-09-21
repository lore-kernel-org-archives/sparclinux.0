From: Christoph Hellwig <hch@infradead.org>
Date: Mon, 21 Sep 2020 06:28:19 +0000
Subject: Re: [patch RFC 02/15] highmem: Provide generic variant of kmap_atomic*
Message-Id: <20200921062819.GB32081@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20200919091751.011116649@linutronix.de>
 <20200919092615.990731525@linutronix.de>
In-Reply-To: <20200919092615.990731525@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Juri Lelli <juri.lelli@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dri-devel <dri-devel@lists.freedesktop.org>, linux-mips@vger.kernel.org, Ben Segall <bsegall@google.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>, linux-arch@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, David Airlie <airlied@linux.ie>, Mel Gorman <mgorman@suse.de>, linux-snps-arc@lists.infradead.org, linux-xtensa@linux-xtensa.org, Paul McKenney <paulmck@kernel.org>, intel-gfx <intel-gfx@lists.freedesktop.org>, linuxppc-dev@lists.ozlabs.org, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linuxfoundation.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, Linux-MM <linux-mm@kvack.org>, Vineet Gupta <vgupta@synopsys.com>, LKML <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@linux-foundation.org>, Daniel Bristot de Oliveira <bristot@redhat.com>, "David S. Miller" <davem@davemloft.net>, Greentime Hu <green.hu@gmail.com>

> +# ifndef ARCH_NEEDS_KMAP_HIGH_GET
> +static inline void *arch_kmap_temporary_high_get(struct page *page)
> +{
> +	return NULL;
> +}
> +# endif

Turn this into a macro and use #ifndef on the symbol name?

> +static inline void __kunmap_atomic(void *addr)
> +{
> +	kumap_atomic_indexed(addr);
> +}
> +
> +
> +#endif /* CONFIG_KMAP_ATOMIC_GENERIC */

Stange double empty line above the endif.

> -#define kunmap_atomic(addr)                                     \
> -do {                                                            \
> -	BUILD_BUG_ON(__same_type((addr), struct page *));       \
> -	kunmap_atomic_high(addr);                                  \
> -	pagefault_enable();                                     \
> -	preempt_enable();                                       \
> -} while (0)
> -
> +#define kunmap_atomic(addr)						\
> +	do {								\
> +		BUILD_BUG_ON(__same_type((addr), struct page *));	\
> +		__kunmap_atomic(addr);					\
> +		preempt_enable();					\
> +	} while (0)

Why the strange re-indent to a form that is much less common and less
readable?

> +void *kmap_atomic_pfn_prot(unsigned long pfn, pgprot_t prot)
> +{
> +	pagefault_disable();
> +	return __kmap_atomic_pfn_prot(pfn, prot);
> +}
> +EXPORT_SYMBOL(kmap_atomic_pfn_prot);

The existing kmap_atomic_pfn & co implementation is EXPORT_SYMBOL_GPL,
and this stuff should preferably stay that way.
