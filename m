From: David Miller <davem@davemloft.net>
Date: Mon, 14 Jul 2008 00:41:19 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <20080713.174119.71992292.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <487A083F.9010301@firstfloor.org>
	<20080713.124610.193703496.davem@davemloft.net>
	<487A61DD.6090304@firstfloor.org>
In-Reply-To: <487A61DD.6090304@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andi@firstfloor.org
Cc: mpatocka@redhat.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com

From: Andi Kleen <andi@firstfloor.org>
Date: Sun, 13 Jul 2008 22:13:17 +0200

> David Miller wrote:
> > From: Andi Kleen <andi@firstfloor.org>
> > Date: Sun, 13 Jul 2008 15:50:55 +0200
> > 
> >> Still I would expect that modern IO controllers are typically fast
> >> enough at processing SG lists that it shouldn't matter much.
> > 
> > I know it matters a lot on sparc64 ESP scsi controllers.
> > 
> > You can only have one address/len pair DMA'ing at a time and you have
> > to service an interrupt to load in the the next DMA sg elements into
> > the chips registers.
> > 
> > Merging is essentially a must for performance on those cards.
> 
> Well right now your setup breaks all controllers with "weird requirements"
> like 64k DMA or similar. You'll need to find some way to turn off BIO
> merge for those at least.
> 
> Perhaps this needs to be really a block queue attribute instead of a global?

Like I said, that code was written at a time when none of the block
segment check stuff existed, and therefore worked perfectly fine in
the environment in which it was created.

Someone added the segmenting code, but didn't bother to add proper
checking to the merging bits.

Usually we revert code that breaks things like that, right?

So I find it unusual for people to talk about turning off the
code that was working perfectly fine previously in situations
like this.

