From: David Miller <davem@davemloft.net>
Date: Fri, 29 Jul 2016 04:42:17 +0000
Subject: Re: [PATCH] sparc64 mm: Fix base TSB sizing when hugetlb pages are used
Message-Id: <20160728.214217.257756679660455048.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1468613322-8491-1-git-send-email-mike.kravetz@oracle.com>
In-Reply-To: <1468613322-8491-1-git-send-email-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mike.kravetz@oracle.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, nitin.m.gupta@oracle.com

From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Fri, 15 Jul 2016 13:08:42 -0700

> do_sparc64_fault() calculates both the base and huge page RSS sizes and
> uses this information in calls to tsb_grow().  The calculation for base
> page TSB size is not correct if the task uses hugetlb pages.  hugetlb
> pages are not accounted for in RSS, therefore the call to get_mm_rss(mm)
> does not include hugetlb pages.  However, the number of pages based on
> huge_pte_count (which does include hugetlb pages) is subtracted from
> this value.  This will result in an artificially small and often negative
> RSS calculation.  The base TSB size is then often set to max_tsb_size
> as the passed RSS is unsigned, so a negative value looks really big.
> 
> THP pages are also accounted for in huge_pte_count, and THP pages are
> accounted for in RSS so the calculation in do_sparc64_fault() is correct
> if a task only uses THP pages.
> 
> A single huge_pte_count is not sufficient for TSB sizing if both hugetlb
> and THP pages can be used.  Instead of a single counter, use two:  one
> for hugetlb and one for THP.
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Great catch, applied and queued up for -stable.

Thanks.
