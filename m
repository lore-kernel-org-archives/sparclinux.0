From: David Miller <davem@davemloft.net>
Date: Sat, 01 Aug 2009 05:46:17 +0000
Subject: Re: cmd64x: irq 14: nobody cared - system is dreadfully slow
Message-Id: <20090731.224617.228354615.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200906221604.17915.elendil@planet.nl>
	<20090623.034316.149816033.davem@davemloft.net>
	<200907311609.01387.elendil@planet.nl>
In-Reply-To: <200907311609.01387.elendil@planet.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: elendil@planet.nl
Cc: stable@kernel.org, bzolnier@gmail.com, sparclinux@vger.kernel.org, linux-ide@vger.kernel.org

From: Frans Pop <elendil@planet.nl>
Date: Fri, 31 Jul 2009 16:08:59 +0200

> On Tuesday 23 June 2009, David Miller wrote:
>> From: Frans Pop <elendil@planet.nl> Date: Mon, 22 Jun 2009:
>> > On Monday 22 June 2009, you wrote:
>> >> From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
>> >> Subject: [PATCH] ide: fix handling of unexpected IRQs vs
>> >> request_irq()
>> >>
>> > Thanks Bart. This does solve the "nobody cared" problem.
>> > Tested-by: Frans Pop <elendil@planet.nl>
>>
>> I've applied this patch to my tree, thanks everyone!
> 
> Please consider the following two patches for the next stable update:
> 
> commit ffc36c7610731115c77700dcc53901920361c235
> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ide: fix handling of unexpected IRQs vs request_irq()
> 
> commit 346c17a6cf60375323adfaa4b8a9d841049f890e
> Author: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> ide: relax DMA info validity checking
> 
> The current 2.6.30 Debian kernel (based on .30.3) is still failing on my
> Sparc Ultra 10 because those patches are missing.

Agreed, these should be applied.
