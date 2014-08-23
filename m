From: David Miller <davem@davemloft.net>
Date: Sat, 23 Aug 2014 18:51:14 +0000
Subject: Re: [PATCH v1 1/3] sparc64: correctly recognise M7 cpu type
Message-Id: <20140823.115114.1827484796641624344.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1408686773-3044-1-git-send-email-allen.pais@oracle.com>
In-Reply-To: <1408686773-3044-1-git-send-email-allen.pais@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Allen Pais <allen.pais@oracle.com>
Date: Fri, 22 Aug 2014 11:22:51 +0530

>  The following patch adds support for correctly
> recognising M7 cpu type.
> 
> Signed-off-by: Allen Pais <allen.pais@oracle.com>

I don't think this is correct.

> @@ -414,6 +414,8 @@ sun4v_chip_type:
>  	cmp	%g2, 'T'
>  	be,pt	%xcc, 70f
>  	 cmp	%g2, 'M'
> +	be,pt	%xcc, 71f
> +	 nop
>  	bne,pn	%xcc, 49f
>  	 nop

This code block is supposed to fallthrough when %g2 is 'M' so that
we accept all of "{T,M}345..." but your change is breaking that
such that we will now only accept "M" as a prefix for "7".

That's a regression.

All you have to do is add the new comparison against '7' in the
"70:" label code block, and you're done.
