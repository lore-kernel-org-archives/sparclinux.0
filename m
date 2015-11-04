From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 04 Nov 2015 19:59:53 +0000
Subject: Re: [PATCH] iommu-common: Fix error code used in iommu_tbl_range_{alloc,free}().
Message-Id: <20151104195953.GF14575@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20151104.143417.1514217749334656481.davem@davemloft.net>
In-Reply-To: <20151104.143417.1514217749334656481.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On (11/04/15 14:34), David Miller wrote:
> 
> The value returned from iommu_tbl_range_alloc() (and the one passed
> in as a fourth argument to iommu_tbl_range_free) is not a DMA address,
> it is rather an index into the IOMMU page table.
> 
> Therefore using DMA_ERROR_CODE is not appropriate.
> 
> Use a more type matching error code define, IOMMU_ERROR_CODE, and
> update all users of this interface.

Acked-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

