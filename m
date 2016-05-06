From: David Miller <davem@davemloft.net>
Date: Fri, 06 May 2016 19:52:46 +0000
Subject: Re: [crypto / sparc64] cryptomgr_test OOPS
Message-Id: <20160506.155246.1005161410295236920.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20160504040731.GA25758@gondor.apana.org.au>
	<CADxRZqws2yAMSqeMDYb6w6OUXJMMbv9wMaY7Zc6YX+szk2vO3g@mail.gmail.com>
	<20160505084249.GA4971@gondor.apana.org.au>
In-Reply-To: <20160505084249.GA4971@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: herbert@gondor.apana.org.au
Cc: matorola@gmail.com, linux-crypto@vger.kernel.org, sparclinux@vger.kernel.org, nicstange@gmail.com

From: Herbert Xu <herbert@gondor.apana.org.au>
Date: Thu, 5 May 2016 16:42:49 +0800

> Subject: crypto: testmgr - Use kmalloc memory for RSA input
> 
> As akcipher uses an SG interface, you must not use vmalloc memory
> as input for it.  This patch fixes testmgr to copy the vmalloc
> test vectors to kmalloc memory before running the test.
> 
> This patch also removes a superfluous sg_virt call in do_test_rsa.
> 
> Cc: <stable@vger.kernel.org>
> Reported-by: Anatoly Pugachev <matorola@gmail.com>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

I'm really surprised this didn't trigger on non-sparc64 systems, but
what do I know :-)
