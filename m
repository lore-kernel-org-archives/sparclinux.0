From: David Miller <davem@davemloft.net>
Date: Mon, 23 Mar 2015 16:29:22 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <20150323.122922.887448418154237329.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1426734106.4770.118.camel@kernel.crashing.org>
 <550A5E5D.90907@ozlabs.ru> <20150322192726.GB19474@oracle.com>
In-Reply-To: <20150322192726.GB19474@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sowmini.varadhan@oracle.com
Cc: aik@au1.ibm.com, aik@ozlabs.ru, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Sun, 22 Mar 2015 15:27:26 -0400

> That leaves only the odd iommu_flushall() hook, I'm trying
> to find the history behind that (needed for sun4u platforms,
> afaik, and not sure if there are other ways to achieve this).

In order to elide the IOMMU flush as much as possible, I implemnented
a scheme for sun4u wherein we always allocated from low IOMMU
addresses to high IOMMU addresses.

In this regime, we only need to flush the IOMMU when we rolled over
back to low IOMMU addresses during an allocation.

It made a noticable difference in performance.

Unfortunately, with sun4v and the hypervisor, I'm not allowed to
control when the IOMMU flush happens, it has to occur on every
single IOMMU mapping change.  So this optimization was no longer
possible there.

Anyways, that's the history behind it.
