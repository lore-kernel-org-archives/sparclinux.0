From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sat, 18 Apr 2015 12:05:10 +0000
Subject: Re: sparc64: Build failure due to commit f1600e549b94 (sparc: Make sparc64 use scalable lib/iommu-co
Message-Id: <20150418120510.GB1587@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150418054705.GA10746@roeck-us.net>
In-Reply-To: <20150418054705.GA10746@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

On (04/17/15 22:47), Guenter Roeck wrote:
> The problem is caused by commit f1600e549b94 ("sparc: Make sparc64
> use scalable lib/iommu-common.c functions"), which introduces 
> 
> static DEFINE_PER_CPU(unsigned int, iommu_pool_hash);

I have to confess that I'm a little confused about what happened here..

The specific patch (2/3) above should have come from this submission
  http://www.spinics.net/lists/sparclinux/msg13786.html
aka 
  http://patchwork.ozlabs.org/patch/459803/

This does not add any additional defines for iommu_pool_hash.

It also does not have any references to fields like page_table_map_base:
instead, these were switched over to things like:
-	*dma_addrp = (iommu->page_table_map_base +
+	*dma_addrp = (iommu->tbl.table_map_base +
 		      ((iopte - iommu->page_table) << IO_PAGE_SHIFT));


But when I clone 
  git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc.git
and do a git show of the commit-id above, I see deltas that
dont make sense (they seem to be from a patchset from somewhere
in the middle of the review chain from the thread). 

What am I missing? 

--Sowmini

