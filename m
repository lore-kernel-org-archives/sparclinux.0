From: Mikulas Patocka <mpatocka@redhat.com>
Date: Mon, 14 Jul 2008 14:03:29 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <Pine.LNX.4.64.0807141000340.24718@devserv.devel.redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0807131947090.7803@devserv.devel.redhat.com>
 <20080713.174855.234796356.davem@davemloft.net>
 <Pine.LNX.4.64.0807140805380.10106@devserv.devel.redhat.com>
 <20080714.052859.88212003.davem@davemloft.net>
In-Reply-To: <20080714.052859.88212003.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: andi@firstfloor.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com

On Mon, 14 Jul 2008, David Miller wrote:

> From: Mikulas Patocka <mpatocka@redhat.com>
> Date: Mon, 14 Jul 2008 08:16:13 -0400 (EDT)
>
>> As you mentioned ESP driver, it declares .sg_tablesize = SG_ALL, so
>> BIO_VMERGE_BOUNDARY has no effect on the operation of this driver. Any
>> other driver where BIO_VMERGE_BOUNDARY does matter?
>
> When BIO_VMERGE_BOUNDARY is turned on, requests that would not
> otherwise fit into the device's limits, can.

Why would someone want to overshoot SG_ALL? ... and, shouldn't the 
constant be increased then --- instead of making buggy BIO_VMERGE_BOUNDARY 
expectations?

Mikulas

> It's the only way to know ahead of time that the IOMMU is going
> to merge things for us.

