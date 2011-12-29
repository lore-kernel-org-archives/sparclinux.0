From: David Miller <davem@davemloft.net>
Date: Thu, 29 Dec 2011 23:15:38 +0000
Subject: Re: [PATCH] sparc32: support atomic64_t
Message-Id: <20111229.181538.1892953322418085863.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20111227212850.GA8174@merkur.ravnborg.org>
In-Reply-To: <20111227212850.GA8174@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 29 Dec 2011 12:09:13 +0100

> Without atomic64_t support .data had address xxx47000.
> This address is nicely aligned to a page boundary.
> But SPARC32 require that the thread data are aligned to a 2*PAGE_SIZE boundary,
> so therefore this is rounded up to xxx48000 - thus wasting 1000@96 bytes.
> 
> When I applied the patch to enable atomic64_t then .data got address xx48000
> which is aligned to a 2*PAGE_SIZE - and no extra page wasted for alignment.
> 
> .data had a higher address because .rodata had a higher address in the atomic64_t case.
> This expalins why we used less data despite using more data!

Thanks for figuring this out.

We probably have some strange alignment gaps that could be less
consistently wasteful, both for sparc32 and sparc64, with some careful
work.

But this is pretty low priority stuff. :)

