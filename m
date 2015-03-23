From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Mon, 23 Mar 2015 16:54:06 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <20150323165406.GG14061@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1426734106.4770.118.camel@kernel.crashing.org>
 <550A5E5D.90907@ozlabs.ru> <20150322192726.GB19474@oracle.com>
 <20150323.122922.887448418154237329.davem@davemloft.net>
In-Reply-To: <20150323.122922.887448418154237329.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: aik@au1.ibm.com, aik@ozlabs.ru, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On (03/23/15 12:29), David Miller wrote:
> 
> In order to elide the IOMMU flush as much as possible, I implemnented
> a scheme for sun4u wherein we always allocated from low IOMMU
> addresses to high IOMMU addresses.
> 
> In this regime, we only need to flush the IOMMU when we rolled over
> back to low IOMMU addresses during an allocation.
> 
> It made a noticable difference in performance.
> 
> Unfortunately, with sun4v and the hypervisor, I'm not allowed to
> control when the IOMMU flush happens, it has to occur on every
> single IOMMU mapping change.  So this optimization was no longer
> possible there.
> 
> Anyways, that's the history behind it.
> --

I see.

If it was only an optimization (i.e., removing it would not break
any functionality), and if this was done for older hardware,
and *if* we believe that the direction of most architectures is to 
follow the sun4v/HV model, then, given that the sun4u code only uses 1 
arena pool anyway, one thought that I have for refactoring this
is the following:

- Caller of iommu_tbl_range_alloc() can do the flush_all if they 
  see start <= end for the one single pool 
- lose the other ->flush_all invocation (i.e., the one that is
  done when iommu_area_alloc() fails for pass = 0, and we reset
  start to 0 to roll-back)

that would avoid the need for any iommu_tbl_ops in my patch-set.

But it would imply that you would still take the perf hit for the roll-back
if we failed the pass = 0 iteration through iommu_area_alloc().
Perhaps this is an acceptable compromise in favor of cleaner code
(again, assuming that current/future archs will all follow the HV
based design).

--Sowmini
 
