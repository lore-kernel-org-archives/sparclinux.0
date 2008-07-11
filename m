From: David Miller <davem@davemloft.net>
Date: Fri, 11 Jul 2008 19:41:52 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <20080711.124152.247767508.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080711152054C.fujita.tomonori@lab.ntt.co.jp>
	<Pine.LNX.4.64.0807110649510.16550@engineering.redhat.com>
	<20080711201558J.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20080711201558J.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fujita.tomonori@lab.ntt.co.jp
Cc: mpatocka@redhat.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com

From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Fri, 11 Jul 2008 20:15:52 +0900

> On Fri, 11 Jul 2008 06:52:09 -0400 (EDT)
> Mikulas Patocka <mpatocka@redhat.com> wrote:
> 
> > On Fri, 11 Jul 2008, FUJITA Tomonori wrote:
> > 
> > > Yeah, IOMMUs can't guarantee that. The majority of architectures set
> > > BIO_VMERGE_BOUNDARY to 0 so they don't hit this, I think.
> > 
> > Yes, the architectures without IOMMU don't hit this problem.
> 
> I meant that even if some architectures support IOMMUs, they set
> BIO_VMERGE_BOUNDARY to 0.

Keep in mind that these settings were added long before
we supported segment boundary restrictions.

Someone added code to handle segment boundaries, but didn't
fix any of the block I/O layer infrastructure :-)

Several platforms that have IOMMU but set these values to zero
actually did so for another reason.  They considered being
required to always merge page-adjacent mappings virtually too
strong a requirement to meet %100 of the time.
