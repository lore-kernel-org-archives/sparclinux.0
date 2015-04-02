From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 02 Apr 2015 12:51:52 +0000
Subject: Re: [PATCH v8 RFC 0/3] Generic IOMMU pooled allocator
Message-Id: <20150402125152.GA17528@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150331180642.GA13314@oracle.com>
 <1427850091.20500.150.camel@kernel.crashing.org>
 <551B4502.1020603@oracle.com>
 <20150331.231224.402909066860518278.davem@davemloft.net>
In-Reply-To: <20150331.231224.402909066860518278.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On (03/31/15 23:12), David Miller wrote:
> 
> It's much more amortized with smart buffering strategies, which are
> common on current generation networking cards.
> 
> There you only eat one map/unmap per "PAGE_SIZE / rx_pkt_size".
> 
> Maybe the infiniband stuff is doing things very suboptimally, and
> actually with that subsystem and drivers absolutely nothing would
> surprise me.

yeh, we are trying to get more info from them about what their
bottle-necks are. Until then, lets just stick with the spin_lock.

do I need to resubmit this without the RFC tag? Perhaps I should
have dropped that some time ago.

--Sowmini
