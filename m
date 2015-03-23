From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 23 Mar 2015 22:25:49 +0000
Subject: Re: Generic IOMMU pooled allocator
Message-Id: <1427149549.4770.240.camel@kernel.crashing.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1426734106.4770.118.camel@kernel.crashing.org>
 <550A5E5D.90907@ozlabs.ru> <20150322192726.GB19474@oracle.com>
 <20150323.122922.887448418154237329.davem@davemloft.net>
 <20150323165406.GG14061@oracle.com>
In-Reply-To: <20150323165406.GG14061@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Cc: aik@au1.ibm.com, aik@ozlabs.ru, anton@au1.ibm.com, paulus@samba.org, sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>

On Mon, 2015-03-23 at 12:54 -0400, Sowmini Varadhan wrote:

> If it was only an optimization (i.e., removing it would not break
> any functionality), and if this was done for older hardware,
> and *if* we believe that the direction of most architectures is to 
> follow the sun4v/HV model, then, given that the sun4u code only uses 1 
> arena pool anyway, one thought that I have for refactoring this
> is the following:
> 
> - Caller of iommu_tbl_range_alloc() can do the flush_all if they 
>   see start <= end for the one single pool 
> - lose the other ->flush_all invocation (i.e., the one that is
>   done when iommu_area_alloc() fails for pass = 0, and we reset
>   start to 0 to roll-back)
> 
> that would avoid the need for any iommu_tbl_ops in my patch-set.

You must hold the lock until you do the flush, otherwise somebody
else might allocate the not-yet-flushed areas and try to use them...
kaboom. However if that's the only callback left, pass it as an
argument.

> But it would imply that you would still take the perf hit for the roll-back
> if we failed the pass = 0 iteration through iommu_area_alloc().
> Perhaps this is an acceptable compromise in favor of cleaner code
> (again, assuming that current/future archs will all follow the HV
> based design).
> 
> --Sowmini
>  


