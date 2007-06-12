From: David Miller <davem@davemloft.net>
Date: Tue, 12 Jun 2007 23:23:15 +0000
Subject: Re: [PATCH] Fix build errors with strict MM checking
Message-Id: <20070612.162315.38082297.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070612231600.GA8953@palantir8>
In-Reply-To: <20070612231600.GA8953@palantir8>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Wed, 13 Jun 2007 00:16:00 +0100

> @@ -2137,11 +2137,11 @@ static unsigned long srmmu_pte_to_pgoff(
>  
>  static pgprot_t srmmu_pgprot_noncached(pgprot_t prot)
>  {
> -	prot &= ~__pgprot(SRMMU_CACHE);
> +	pgprot_val(prot) &= ~SRMMU_CACHE;
>  
>  	return prot;
>  }

This patch doesn't apply cleanly, and it's because of this hunk.

The patch hunk says that there should be "11" lines in both
the before and after, but there are only 7.

Please try to apply the patches your submit unless you
can ensure that all of your patches are perfect without
checking :-)

Also, I wouldn't run a kernel with strict MM checking on, it's
at best a compile time check and it causes the code output a lot,
PTE's and PGD's etc. get passed on the stack when given as
parameters to functions instead of in registers, and many
optimizations get disabled in the compiler because these
things are now structures instead of simple integers.

That's why it's off by default.
