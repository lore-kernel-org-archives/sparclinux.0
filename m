From: David Miller <davem@davemloft.net>
Date: Mon, 14 Jul 2008 12:28:59 +0000
Subject: Re: [SUGGESTION]: drop virtual merge accounting in I/O requests
Message-Id: <20080714.052859.88212003.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.0807131947090.7803@devserv.devel.redhat.com>
	<20080713.174855.234796356.davem@davemloft.net>
	<Pine.LNX.4.64.0807140805380.10106@devserv.devel.redhat.com>
In-Reply-To: <Pine.LNX.4.64.0807140805380.10106@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mpatocka@redhat.com
Cc: andi@firstfloor.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, jens.axboe@oracle.com

From: Mikulas Patocka <mpatocka@redhat.com>
Date: Mon, 14 Jul 2008 08:16:13 -0400 (EDT)

> As you mentioned ESP driver, it declares .sg_tablesize = SG_ALL, so 
> BIO_VMERGE_BOUNDARY has no effect on the operation of this driver. Any 
> other driver where BIO_VMERGE_BOUNDARY does matter?

When BIO_VMERGE_BOUNDARY is turned on, requests that would not
otherwise fit into the device's limits, can.

It's the only way to know ahead of time that the IOMMU is going
to merge things for us.
