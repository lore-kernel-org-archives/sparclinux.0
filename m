From: David Miller <davem@davemloft.net>
Date: Wed, 28 Sep 2016 15:30:18 +0000
Subject: Re: [PATCH v2] sparc64 mm: Fix more TSB sizing issues
Message-Id: <20160928.113018.46166819947237523.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1472676499-6325-1-git-send-email-mike.kravetz@oracle.com>
In-Reply-To: <1472676499-6325-1-git-send-email-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mike.kravetz@oracle.com
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, akpm@linux-foundation.org, kirill.shutemov@linux.intel.com, nitin.m.gupta@oracle.com

From: Mike Kravetz <mike.kravetz@oracle.com>
Date: Wed, 31 Aug 2016 13:48:19 -0700

> Commit af1b1a9b36b8 ("sparc64 mm: Fix base TSB sizing when hugetlb
> pages are used") addressed the difference between hugetlb and THP
> pages when computing TSB sizes.  The following additional issues
> were also discovered while working with the code.
> 
> In order to save memory, THP makes use of a huge zero page.  This huge
> zero page does not count against a task's RSS, but it does consume TSB
> entries.  This is similar to hugetlb pages.  Therefore, count huge
> zero page entries in hugetlb_pte_count.
> 
> Accounting of THP pages is done in the routine set_pmd_at().
> Unfortunately, this does not catch the case where a THP page is split.
> To handle this case, decrement the count in pmdp_invalidate().
> pmdp_invalidate is only called when splitting a THP.  However, 'sanity
> checks' are added in case it is ever called for other purposes.
> 
> A more general issue exists with HPAGE_SIZE accounting.
> hugetlb_pte_count tracks the number of HPAGE_SIZE (8M) pages.  This
> value is used to size the TSB for HPAGE_SIZE pages.  However,
> each HPAGE_SIZE page consists of two REAL_HPAGE_SIZE (4M) pages.
> The TSB contains an entry for each REAL_HPAGE_SIZE page.  Therefore,
> the number of REAL_HPAGE_SIZE pages should be used to size the huge
> page TSB.  A new compile time constant REAL_HPAGE_PER_HPAGE is used
> to multiply hugetlb_pte_count before sizing the TSB.
> 
> Changes from V1
> - Fixed build issue if hugetlb or THP not configured
> 
> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>

Applied.
