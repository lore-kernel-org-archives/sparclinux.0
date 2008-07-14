From: Mikulas Patocka <mpatocka@redhat.com>
Date: Mon, 14 Jul 2008 23:16:17 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <Pine.LNX.4.64.0807141903001.2825@devserv.devel.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0807140805380.10106@devserv.devel.redhat.com>
 <20080714.052859.88212003.davem@davemloft.net>
 <Pine.LNX.4.64.0807141000340.24718@devserv.devel.redhat.com>
 <20080714.143751.266098047.davem@davemloft.net>
In-Reply-To: <20080714.143751.266098047.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: andi@firstfloor.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com

>>>> As you mentioned ESP driver, it declares .sg_tablesize = SG_ALL, so
>>>> BIO_VMERGE_BOUNDARY has no effect on the operation of this driver. Any
>>>> other driver where BIO_VMERGE_BOUNDARY does matter?
>>>
>>> When BIO_VMERGE_BOUNDARY is turned on, requests that would not
>>> otherwise fit into the device's limits, can.
>>
>> Why would someone want to overshoot SG_ALL? ... and, shouldn't the
>> constant be increased then --- instead of making buggy BIO_VMERGE_BOUNDARY
>> expectations?
>
> I'm talking about other devices, not about the ESP, here.

And which ones are those important drivers that need merge accounting?

A100U2W is an old card, I got it for $8.5 in bazaar, it does 38MB/s. This 
virtual merge accounting helps to stuff on average 4 more segments into 
the 32-entry table.

So the question is: to reduce number of requests by 12% on an outdated 
SCSI card, it is sensible to maintain complicated merge accounting logic 
in the core block layer? To me, it doesn't seem sensible.

Mikulas
