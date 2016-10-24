From: David Miller <davem@davemloft.net>
Date: Mon, 24 Oct 2016 17:47:50 +0000
Subject: Re: [PATCH 3/6] sparc64: Initialize iommu_map_table and iommu_pool
Message-Id: <20161024.134750.374485400910042905.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1476123127-24314-1-git-send-email-tushar.n.dave@oracle.com>
        <1476123127-24314-4-git-send-email-tushar.n.dave@oracle.com>
In-Reply-To: <1476123127-24314-4-git-send-email-tushar.n.dave@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tushar.n.dave@oracle.com
Cc: chris.hyser@oracle.com, sowmini.varadhan@oracle.com, vgupta@synopsys.com, robin.murphy@arm.com, jroedel@suse.de, egtvedt@samfundet.no, krzk@kernel.org, rkuo@codeaurora.org, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Mon, 10 Oct 2016 11:12:04 -0700

> Like legacy IOMMU, use common iommu_map_table and iommu_pool for ATU.
> This change initializes iommu_map_table and iommu_pool for ATU.
> 
> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
> Reviewed-by: chris hyser <chris.hyser@oracle.com>
> Reviewed-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

I suspect you are adding a bisection problem here.

It looks to me like patch #2 starts setting up to use the ATU
but these changes in #3 and later are necessary for it to even
work properly.

You can't leave the tree in an intermediate non-working state
between changes like that.
