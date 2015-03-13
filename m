From: David Miller <davem@davemloft.net>
Date: Fri, 13 Mar 2015 03:41:35 +0000
Subject: Re: [PATCH v4 RFC 0/3] sparc: IOMMU pools for better scalability
Message-Id: <20150312.234135.818305415323499375.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1426194368.git.sowmini.varadhan@oracle.com>
In-Reply-To: <cover.1426194368.git.sowmini.varadhan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Thu, 12 Mar 2015 20:02:34 -0400

> Follows up on feedback to v3  patch-set from 
>   http://www.spinics.net/lists/sparclinux/msg13462.html
> 
> specifically,
> - pci_impl.h has no changes, now that all sparc iommu usage is converted
>   to the common library.
> - Remove IOMMU_ERROR_CODE. use DMA_ERROR_CODE
> - page_table_map_base and page_table_shift are unsigned long.

Looks good, I'll start doing some testing of my own.
