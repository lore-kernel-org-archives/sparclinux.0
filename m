From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Tue, 15 Jul 2008 12:19:44 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <20080715212007I.fujita.tomonori@lab.ntt.co.jp>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0807141720350.30981@devserv.devel.redhat.com>
	<20080715114058A.fujita.tomonori@lab.ntt.co.jp>
	<Pine.LNX.4.64.0807150759430.12202@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0807150759430.12202@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: fujita.tomonori@lab.ntt.co.jp, davem@davemloft.net, andi@firstfloor.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com

On Tue, 15 Jul 2008 08:09:53 -0400 (EDT)
Mikulas Patocka <mpatocka@redhat.com> wrote:

> >> BTW. what should the block device driver do when it receives a mapping
> >> error? (if it aborts the request and it was write request, there will be
> >> data corruption).
> >
> > I'm not sure how a aborted request can corrupt data on disk.
> 
> Writes are done by an async daemon and no one checks for their completion 
> status. If there are three writes to directory, inode table and inode 
> bitmap and one of these writes fail, there's no code to undo the other 
> two. So the filesystem will be corrupted on write failure.

Are you talking about file system metadata corruption?

If your logic is correct, we hit the corruption every time a FC cable
(switch, or whatever) has a problem. Fortunately, we don't. modern
file systems can handle that.


> >> Is it even legal to return IOMMU error in case where no
> >> real hardware error or overflow happened?
> >
> > Of course, it's legal. It's a common event like kinda OOM. It's very
> > possible with old IOMMUs that have the small I/O space. A SCSI driver
> > retries a failed request later. But note that some drivers are still
> > not able to handle that.
> >
> > http://marc.info/?l=linux-kernel&m1300637114672&w=2
> 
> So should it return SCSI_MLQUEUE_HOST_BUSY? Or something other?
> 
> Unfortunatelly, many of the drivers contain BUG_ON or no check at all.

Yeah, many of the old scsi drivers contatinas BUG_ON. They are not
likely to be used with IOMMUs. We don't care about them much. The
recent scsi drivers can handle this.
