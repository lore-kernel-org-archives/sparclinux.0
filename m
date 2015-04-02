From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 02 Apr 2015 20:52:44 +0000
Subject: Re: [PATCH v8 RFC 0/3] Generic IOMMU pooled allocator
Message-Id: <1428007964.20500.270.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <551B4502.1020603@oracle.com>
 <20150331.231224.402909066860518278.davem@davemloft.net>
 <20150402125152.GA17528@oracle.com>
 <20150402.122133.402067811944670903.davem@davemloft.net>
 <1428006142.20500.246.camel@kernel.crashing.org>
In-Reply-To: <1428006142.20500.246.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: aik@au1.ibm.com, sowmini.varadhan@oracle.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On Fri, 2015-04-03 at 07:22 +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2015-04-02 at 12:21 -0400, David Miller wrote:
> > From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> > Date: Thu, 2 Apr 2015 08:51:52 -0400
> > 
> > > do I need to resubmit this without the RFC tag? Perhaps I should
> > > have dropped that some time ago.
> > 
> > I want to hear from the powerpc folks whether they can positively
> > adopt the new generic code or not.
> 
> Oh yes, I'm fine with it, it's basically our code slightly refactored,
> but I still have a few minor review comments on Swomini's patch I
> started to put together yesterday but didn't finish. I'll send them
> today.

Actually I found some more serious issues that for some reason I didn't
spot the other day. Will send comments in a jiffy.

Ben.


