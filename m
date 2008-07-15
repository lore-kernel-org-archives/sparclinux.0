From: David Miller <davem@davemloft.net>
Date: Tue, 15 Jul 2008 22:37:51 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <20080715.153751.71531968.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0807141903001.2825@devserv.devel.redhat.com>
	<20080714.183116.121978835.davem@davemloft.net>
	<Pine.LNX.4.64.0807151830290.22181@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0807151830290.22181@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: andi@firstfloor.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Tue, 15 Jul 2008 18:32:37 -0400 (EDT)

> On Mon, 14 Jul 2008, David Miller wrote:
> 
> > From: Mikulas Patocka <mpatocka@redhat.com>
> > Date: Mon, 14 Jul 2008 19:16:17 -0400 (EDT)
> > 
> > > So the question is: to reduce number of requests by 12% on an outdated 
> > > SCSI card, it is sensible to maintain complicated merge accounting logic 
> > > in the core block layer? To me, it doesn't seem sensible.
> > 
> > Rip out the code if you like, then.  I really don't have time to
> > work on this myself.  So if you do, by all means do whatever
> > you think is appropriate.
> 
> So add signed-off line and forward it to Linus.
> 
> Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

I said remove code, not turn if off.  I guess you didn't like
that option even though you seem heavily convinced that it buys
us essentially nothing, and I'm even starting to agree with you.

If the VMERGE code is going to stay, and it's a bug or a limitation in
the sparc64 IOMMU code, I'd rather that get fixed.

I have FUJITA's excellent analysis of the sparc64 specific IOMMU issue
in my inbox and I intend to have a look at it when I get a chance.
