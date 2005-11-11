From: "David S. Miller" <davem@davemloft.net>
Date: Fri, 11 Nov 2005 22:47:21 +0000
Subject: Re: [PATCH]: IRQ stacks for sparc64
Message-Id: <20051111.144721.118697563.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20051110.210234.59468958.davem@davemloft.net>
In-Reply-To: <20051110.210234.59468958.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Ferris McCormick <fmccor@gentoo.org>
Date: Fri, 11 Nov 2005 21:35:48 +0000

> I'm running it on U2(2x400) currently with 2.6.14-U2-2x400-g393b0725.
> So far, it's doing fine, and this is on a system which has never been
> stable with a 2.6 kernel.  With this kernel + IRQ patch, though, it's
> stayed up through a lot of stress tests which I would have expected
> would have killed it.
> (But uptime is only 6 hours so far).

It would be interesting to know if that exact kernel,
but without the IRQ stacks patch, works just as well.

It's nice that it's stable, but we should find out exactly
why :-)
