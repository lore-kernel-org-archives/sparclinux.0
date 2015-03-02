From: David Miller <davem@davemloft.net>
Date: Mon, 02 Mar 2015 05:38:29 +0000
Subject: Re: [PATCH 1/2] Break up monolithic iommu table/lock into finer graularity pools and lock
Message-Id: <20150302.003829.714021119118916245.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20141222224321.GI29674@oracle.com>
In-Reply-To: <20141222224321.GI29674@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Mon, 22 Dec 2014 17:43:21 -0500

> 
> Investigation of multithreaded iperf experiments on an ethernet
> interface show the iommu->lock as the hottest lock identified by
> lockstat, with something of the order of  21M contentions out of
> 27M acquisitions, and an average wait time of 26 us for the lock.
> This is not efficient. A more scalable design is to follow the ppc
> model, where the iommu_table has multiple pools, each stretching
> over a segment of the map, and with a separate lock for each pool.
> This model allows for better parallelization of the iommu map search.
> 
> This patch adds the iommu range alloc/free function infrastructure.
> 
> Signed-off-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>

You're putting tons of sparc specific junk into the "generic"
abstraction.

There's nothing generic about a flush_all callback, or an opaque
write_complete_reg address.  I could go on and on.

Please rewrite this so that only the truly generic stuff, which is
%100 agnostic to IOMMU design or architecutre, goes into the new
"generic" code.
