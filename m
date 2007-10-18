From: David Miller <davem@davemloft.net>
Date: Thu, 18 Oct 2007 01:09:08 +0000
Subject: Re: GCC 4.2.1 produces broken 2.6.22.1 kernel.
Message-Id: <20071017.180908.41635763.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46B7600A.3060700@walrond.org>
In-Reply-To: <46B7600A.3060700@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Andrew Walrond <andrew@walrond.org>
Date: Wed, 17 Oct 2007 13:14:32 +0100

> David Miller wrote:
> > 
> > The dataflow pass doesn't mark global registers correctly, and
> > the new thing in gcc-4.2.x vs. gcc-4.1.x is that it uses the
> > dataflow pass for the loop optimizers.
> > 
> 
> I look forward to testing this when you think it's ready.

I just have done some SMP kernel testing on my Niagara-2 systems
and it looks really good with that gcc-4.2.x patch I posted.
