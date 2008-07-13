From: David Miller <davem@davemloft.net>
Date: Sun, 13 Jul 2008 19:46:10 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <20080713.124610.193703496.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <87iqvb2skz.fsf@basil.nowhere.org>
	<Pine.LNX.4.64.0807130933120.24489@devserv.devel.redhat.com>
	<487A083F.9010301@firstfloor.org>
In-Reply-To: <487A083F.9010301@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: andi@firstfloor.org
Cc: mpatocka@redhat.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com

From: Andi Kleen <andi@firstfloor.org>
Date: Sun, 13 Jul 2008 15:50:55 +0200

> Still I would expect that modern IO controllers are typically fast
> enough at processing SG lists that it shouldn't matter much.

I know it matters a lot on sparc64 ESP scsi controllers.

You can only have one address/len pair DMA'ing at a time and you have
to service an interrupt to load in the the next DMA sg elements into
the chips registers.

Merging is essentially a must for performance on those cards.
