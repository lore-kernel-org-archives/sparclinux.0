From: Andi Kleen <andi@firstfloor.org>
Date: Sun, 13 Jul 2008 20:13:17 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <487A61DD.6090304@firstfloor.org>
List-Id: <sparclinux.vger.kernel.org>
References: <87iqvb2skz.fsf@basil.nowhere.org>	<Pine.LNX.4.64.0807130933120.24489@devserv.devel.redhat.com>	<487A083F.9010301@firstfloor.org> <20080713.124610.193703496.davem@davemloft.net>
In-Reply-To: <20080713.124610.193703496.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: mpatocka@redhat.com, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com

David Miller wrote:
> From: Andi Kleen <andi@firstfloor.org>
> Date: Sun, 13 Jul 2008 15:50:55 +0200
> 
>> Still I would expect that modern IO controllers are typically fast
>> enough at processing SG lists that it shouldn't matter much.
> 
> I know it matters a lot on sparc64 ESP scsi controllers.
> 
> You can only have one address/len pair DMA'ing at a time and you have
> to service an interrupt to load in the the next DMA sg elements into
> the chips registers.
> 
> Merging is essentially a must for performance on those cards.

Well right now your setup breaks all controllers with "weird requirements"
like 64k DMA or similar. You'll need to find some way to turn off BIO
merge for those at least.

Perhaps this needs to be really a block queue attribute instead of a global?

-Andi


