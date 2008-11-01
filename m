From: David Miller <davem@davemloft.net>
Date: Sat, 01 Nov 2008 21:15:10 +0000
Subject: Re: [PATCH] Fix PCI resource mmaping on sparc64
Message-Id: <20081101.141510.99298220.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20081031.120238.156698095.davem@davemloft.net>
In-Reply-To: <20081031.120238.156698095.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: "Max Dmitrichenko" <dmitrmax@gmail.com>
Date: Sat, 1 Nov 2008 15:31:53 +0300

> 2008/10/31, David Miller <davem@davemloft.net>:
> > Please post sparc patches to the sparclinux mailing list,
> 
> Oops, sorry. I had such an idea and I've posted it to the linux-sparc
> and received a notification that such address doesn't exists. Just
> forgot that it is not linux-sparc but sparclinux.
> 
> >> The patch is against 2.6.26. Greg, please consider to include it into
> >> the stable trees.
> >
> > No, the sparc maintainer (that's me) will submit this patch to -stable
> > if it is correct and appropriate.
> 
> Ok. I just thought that Greg maintains -stable trees.

Greg does co-maintain -stable, but the usual course of events is that
the subsystem maintainer reviews and integrates the change, then
pushes it to Linus's tree first.

The change can only go into -stable once it has already been added
to Linus's tree, and at which point the subsystem maintainer submits
the patch formally to -stable.

