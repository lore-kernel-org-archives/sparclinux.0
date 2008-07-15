From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Tue, 15 Jul 2008 02:40:46 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <20080715114058A.fujita.tomonori@lab.ntt.co.jp>
List-Id: <sparclinux.vger.kernel.org>
References: <20080713.202035.172246136.davem@davemloft.net>
	<20080715024424R.fujita.tomonori@lab.ntt.co.jp>
	<Pine.LNX.4.64.0807141720350.30981@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0807141720350.30981@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: fujita.tomonori@lab.ntt.co.jp, davem@davemloft.net, andi@firstfloor.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com

On Mon, 14 Jul 2008 17:26:38 -0400 (EDT)
Mikulas Patocka <mpatocka@redhat.com> wrote:

> On Tue, 15 Jul 2008, FUJITA Tomonori wrote:
> 
> > On Sun, 13 Jul 2008 20:20:35 -0700 (PDT)
> > David Miller <davem@davemloft.net> wrote:
> >
> >> From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> >> Date: Mon, 14 Jul 2008 11:19:02 +0900
> >>
> >>> Now IOMMUs don't ignore the max_segment_size. We hit this problem.
> >>
> >> It seems simply that max_segment_size needs to propagate
> >> down into the block layer VMERGE code so that it can
> >> act accordingly.
> >
> > Yeah, I think so. I'll take care of that.
> >
> > But I think that even with the fix, SPARC64 IOMMU still hits the
> > problem.
> >
> > With the VMERGE accounting enabled,
> >
> > - an IOMMU must merge segments that the block layer expects the IOMMU
> > to merge.
> >
> > - an IOMMU must return an error if it can't merge such segments.
> >
> > But the current SPARC64 IOMMU code doesn't return an error if it can't
> > merge such segments (as POWER's IOMMU does, as you know).
> 
> BTW. what should the block device driver do when it receives a mapping 
> error? (if it aborts the request and it was write request, there will be 
> data corruption).

I'm not sure how a aborted request can corrupt data on disk.


> Is it even legal to return IOMMU error in case where no 
> real hardware error or overflow happened?

Of course, it's legal. It's a common event like kinda OOM. It's very
possible with old IOMMUs that have the small I/O space. A SCSI driver
retries a failed request later. But note that some drivers are still
not able to handle that.

http://marc.info/?l=linux-kernel&m1300637114672&w=2
