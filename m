From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Date: Thu, 05 Nov 2015 21:54:03 +0000
Subject: Re: [PATCH 1/1 v4] drivers/nvme: default to 4k device page size
Message-Id: <20151105215403.GA18259@linux.vnet.ibm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20151027.175443.140992924519172506.davem@davemloft.net>
 <20151028135922.GA27909@localhost.localdomain>
 <20151029115536.GA28090@infradead.org>
 <20151029155701.GJ7716@linux.vnet.ibm.com>
 <20151029172043.GA8343@localhost.localdomain>
 <20151030213511.GK7716@linux.vnet.ibm.com>
 <20151103131824.GA12232@infradead.org>
 <20151103134624.GG13904@localhost.localdomain>
 <20151105170145.GB16308@linux.vnet.ibm.com>
 <20151105195839.GB3194@infradead.org>
In-Reply-To: <20151105195839.GB3194@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 05.11.2015 [11:58:39 -0800], Christoph Hellwig wrote:
> Looks fine,
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> ... but I doubt we'll ever bother updating it.  Most architectures
> with arger page sizes also have iommus and would need different settings
> for different iommus vs direct mapping for very little gain.  There's a
> reason why we never bothered for RDMA either.

Fair enough :) Thanks for all your reviews and comments.

-Nish

