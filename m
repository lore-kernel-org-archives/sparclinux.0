From: David Miller <davem@davemloft.net>
Date: Wed, 10 Sep 2008 23:43:04 +0000
Subject: Re: [PATCH 2/2]: sparc32: Use OF device probing for sun4m irq
Message-Id: <20080910.164304.25278218.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080908.222028.203662832.davem@davemloft.net>
In-Reply-To: <20080908.222028.203662832.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Wed, 10 Sep 2008 19:41:09 -0400

> David Miller wrote:
> > Thanks for testing, can you revert the second one, ie. have only
> > the first one applied?
> >
> > Thanks.
> >
> >   
> No joy.  Rather than a level 15 interrupt, I now just get a hang after:
> Booting Linux...

Thanks a lot for testing, I'll try to figure out what is wrong and
post new patches.
