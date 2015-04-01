From: David Miller <davem@davemloft.net>
Date: Wed, 01 Apr 2015 03:12:24 +0000
Subject: Re: [PATCH v8 RFC 0/3] Generic IOMMU pooled allocator
Message-Id: <20150331.231224.402909066860518278.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150331180642.GA13314@oracle.com>
 <1427850091.20500.150.camel@kernel.crashing.org>
 <551B4502.1020603@oracle.com>
In-Reply-To: <551B4502.1020603@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sowmini.varadhan@oracle.com
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 31 Mar 2015 21:08:18 -0400

> I'm starting to wonder if  some approximation of dma premapped
> buffers may be needed. Doing a map/unmap on each packet is expensive.

It's much more amortized with smart buffering strategies, which are
common on current generation networking cards.

There you only eat one map/unmap per "PAGE_SIZE / rx_pkt_size".

Maybe the infiniband stuff is doing things very suboptimally, and
actually with that subsystem and drivers absolutely nothing would
surprise me.
