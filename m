From: David Miller <davem@davemloft.net>
Date: Tue, 10 May 2011 20:28:53 +0000
Subject: Re: [PATCH]SPARC32: Fixed unaligned memory copying in function
Message-Id: <20110510.132853.179921515.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1304845558.9492.14.camel@big>
In-Reply-To: <1304845558.9492.14.camel@big>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Tkhai Kirill <tkhai@yandex.ru>
Date: Tue, 10 May 2011 16:31:41 +0400

>  	/* Also, handle the alignment code out of band. */
>  cc_dword_align:
> -	cmp	%g1, 6
> -	bl,a	ccte
> +	cmp	%g1, 16
> +	bge	1f
> +	 srl	%g1, 1, %o3
> +2:	cmp	%o3, 0
> +	be,a	ccte
>  	 andcc	%g1, 0xf, %o3
> -	andcc	%o0, 0x1, %g0
> +	andcc	%o3, %o0, %g0	! Check %o0 only (%o1 has the same last 2 bits)
> +	be,a	2b
> +	 srl	%o3, 1, %o3
> +1:	andcc	%o0, 0x1, %g0

I don't understand why you're testing "andcc %o3, %o0, %g0", as %o3 has
the value computed in "srl %g1, 1, %o3" here.

What is so interesting about "ptr & (length >> 1)"?
