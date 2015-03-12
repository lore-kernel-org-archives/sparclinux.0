From: David Miller <davem@davemloft.net>
Date: Thu, 12 Mar 2015 03:20:44 +0000
Subject: Re: [PATCH v3 RFC 1/3] sparc: Break up monolithic iommu table/lock into finer graularity pools and l
Message-Id: <20150311.232044.2025233523385167376.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <6c800d78b3c8a3511f39235d4ffe25e4686be2b2.1426021520.git.sowmini.varadhan@oracle.com>
In-Reply-To: <6c800d78b3c8a3511f39235d4ffe25e4686be2b2.1426021520.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Tue, 10 Mar 2015 18:27:03 -0400

> +#define	IOMMU_ERROR_CODE	(~(dma_addr_t)0x0)

The value 'DMA_ERROR_CODE' is the only portable way to signal
an error through a routine the returns DMA addresses.  Please
use that instead of inventing your own thing here.

> +	u32			page_table_map_base;
> +	u32			page_table_shift;

These should be "unsigned long", which will increase powerpc's
ability to share this code as their it_offset et al. are of
this type.
