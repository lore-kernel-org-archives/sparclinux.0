From: David Miller <davem@davemloft.net>
Date: Wed, 17 Apr 2013 21:24:34 +0000
Subject: Re: [PATCH] sparc64: Don't pass a pointer to xcall_flush_tlb_pending
Message-Id: <20130417.172434.2006642220441293410.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <516F0B8A.5070407@oracle.com>
In-Reply-To: <516F0B8A.5070407@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dave Kleikamp <dave.kleikamp@oracle.com>
Date: Wed, 17 Apr 2013 15:52:26 -0500

> +	else if (nr < 17) {
> +		int i;
> +		unsigned long vaddr2;
> +		for(i = 0; i < nr; i+=2) {

Order the local variables from longest line to shortest.

Put an empty line between the last local variable and the
first statement.

"for" is C primitive, therefor you put a space between it
and the openning parenthesis.

> +			vaddr2 = i + 1 < nr ? vaddrs[i + 1] : 0;
> +			smp_cross_call_masked(&xcall_flush_tlb_pending,
> +					      ctx, vaddrs[i], vaddr2,
> +					      mm_cpumask(mm));
> +		}
> +	} else
> +		/*
> +		 * At some point it is probably cheaper to flush the whole
> +		 * context rather than make too many cross calls
> +		 */
> +		smp_cross_call_masked(&xcall_flush_tlb_mm, ctx, 0, 0,
>  				      mm_cpumask(mm));
>  
> +

Format comments:

	/* Like
	 * this.
	 */

Multi-line basic blocks need to be enclosed in braces, even if it is
more than one line because of comments.
