From: David Miller <davem@davemloft.net>
Date: Fri, 19 Dec 2014 17:26:43 +0000
Subject: Re: [PATCH RFC sparc] Break up iommu from monolithic lock for the map to multiple pools/locks
Message-Id: <20141219.122643.623374509776464765.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141219151616.GB25248@oracle.com>
In-Reply-To: <20141219151616.GB25248@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Fri, 19 Dec 2014 10:16:16 -0500

> In iperf experiments running linux as the Tx side (TCP client) with
> 10 threads results in a severe performance drop when TSO is disabled,
> indicating a weakness in the software that turns out to be avoidable
> after this patch.
> 
> Baseline numbers before this patch:
>    with default settings (TSO enabled) :    9-9.5 Gbps
>    Disable TSO using ethtool- drops badly:  2-3 Gbps.  (!)
> 
> What this patch does:
> Output from lockstat flags the iommu->lock as the hottest
> lock, showing something of the order of  21M contentions out of
> 27M acquisitions, and an average wait time of 26 us for the lock.
> This is not efficient. A better design is to follow the ppc model,
> where the iommu_table has multiple pools, each stretching over a
> segment of the map, and with a separate lock for each pool. This
> model allows for better parallelization of the iommu map search.
> 
> After this patch, iperf client with 10 threads, can give a
> throughput of at least 8.5 Gbps, even when TSO is disabled.
> 
> 
> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

If this is such a better and more scalable algorithm for IOMMU
arena DMA region allocation, then instead of one platform after
another putting a private implementation under arch/, the generic
IOMMU code should be adjusted instead.

Right?

