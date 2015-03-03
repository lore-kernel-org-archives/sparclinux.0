From: David Miller <davem@davemloft.net>
Date: Tue, 03 Mar 2015 22:15:17 +0000
Subject: Re: [PATCH v2 0/2] sparc: IOMMU pools for better scalability
Message-Id: <20150303.171517.103807644109089738.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20150303142202.GA7696@oracle.com>
In-Reply-To: <20150303142202.GA7696@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 3 Mar 2015 09:22:02 -0500

> 
> V2 version ofthis patch-set incorporates the feedback from
>   http://marc.info/?l=linux-sparc&m2527471211108&w=2
> The sparc specific fields have been moved  off into iommu_64.h, 
> into struct iommu_sparc, leaving a minimalist struct iommu_table
> in the common functions..

Still have some sparc specific stuff in the generic header file.

For example, IOMMU_NUM_CTXS.

I don't see anything using cookie_to_index.

Furthermore, who so many TABS in the dma_4v_iommu_ops initializer?

Next, canonically "linux/" headers are included before "asm/" ones.

Please don't put "ifdef notyet" kind of stuff into your changes,
that is not appropriate.  In any event, I want you to translate all
of the PCI DMA implementations, because it is the only way you can
show me that your abstractions are sufficient.
