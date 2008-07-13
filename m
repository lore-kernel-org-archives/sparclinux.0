From: Mikulas Patocka <mpatocka@redhat.com>
Date: Sun, 13 Jul 2008 23:53:01 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <Pine.LNX.4.64.0807131947090.7803@devserv.devel.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <87iqvb2skz.fsf@basil.nowhere.org>
 <Pine.LNX.4.64.0807130933120.24489@devserv.devel.redhat.com>
 <487A083F.9010301@firstfloor.org> <20080713.124610.193703496.davem@davemloft.net>
 <487A61DD.6090304@firstfloor.org>
In-Reply-To: <487A61DD.6090304@firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andi Kleen <andi@firstfloor.org>
Cc: David Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com

On Sun, 13 Jul 2008, Andi Kleen wrote:

> David Miller wrote:
>> From: Andi Kleen <andi@firstfloor.org>
>> Date: Sun, 13 Jul 2008 15:50:55 +0200
>>
>>> Still I would expect that modern IO controllers are typically fast
>>> enough at processing SG lists that it shouldn't matter much.
>>
>> I know it matters a lot on sparc64 ESP scsi controllers.
>>
>> You can only have one address/len pair DMA'ing at a time and you have
>> to service an interrupt to load in the the next DMA sg elements into
>> the chips registers.
>>
>> Merging is essentially a must for performance on those cards.
>
> Well right now your setup breaks all controllers with "weird requirements"
> like 64k DMA or similar. You'll need to find some way to turn off BIO
> merge for those at least.
>
> Perhaps this needs to be really a block queue attribute instead of a global?
>
> -Andi

There is no need to turn BIO merge off --- the problem is caused by 
accounting of BIO merging in block layer, not by BIO merging itself.

Just do #define BIO_VMERGE_BOUNDARY 0, and that disables the accounting, 
but leaves merging as it is.

Mikulas
