From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Thu, 30 Mar 2017 20:47:11 +0000
Subject: Re: tlb_batch_add_one()
Message-Id: <064d7fb5-2a61-bfa6-3870-1dc57d0cd65a@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20170328.175226.210187301635964014.davem@davemloft.net>
In-Reply-To: <20170328.175226.210187301635964014.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 3/30/17 1:22 PM, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Tue, 28 Mar 2017 17:52:26 -0700 (PDT)
> 
>>
>> There seems to be some disagreement about how the hugepage state is
>> passed into tlb_batch_add().  It's declared as an integer shift, but
>> there are call sites that pass it in the old way, as a boolean.
>>
>> For example, all of the call sites in tlb_batch_pmd_scan(), which
>> likely should be passing PAGE_SHIFT.  Passing true or false in these
>> spots can't be right.
> 
> And this appears to be causing regressions, gcc bootstraps fail with
> all kinds of memory corruption, including in the libc malloc arena.
> 
> I did a full git bisect and it showed the multipage size support
> commit as the culprit.


The wrong calls to tlb_batch_add_one(), which are passing boolean to
hugepage_shift argument, are all under CONFIG_TRANSPARENT_HUGEPAGE.
So are you getting these corruptions only when THP is enabled?
I will be sending a fix for these call-sites today.

There's another issue I found with 64K page size support during
hugetlb_free_pgd_range(). The fix is current undergoing more testing.
This bug affects 64K page size only.

I'm still trying to understand how __tlb_remove_page_size() can be used
instead of special page size change handling in tlb_batch_add_one().


Thanks,
Nitin


