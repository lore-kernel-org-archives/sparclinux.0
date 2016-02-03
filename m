From: Nitin Gupta <nitin.m.gupta@oracle.com>
Date: Wed, 03 Feb 2016 23:10:18 +0000
Subject: Re: [PATCH] sparc64: Reduce TLB flushes during hugepage unmap
Message-Id: <56B288DA.2000207@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1454383281-156550-1-git-send-email-nitin.m.gupta@oracle.com>
In-Reply-To: <1454383281-156550-1-git-send-email-nitin.m.gupta@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org



On 02/02/2016 01:25 PM, David Miller wrote:
> From: Nitin Gupta <nitin.m.gupta@oracle.com>
> Date: Mon,  1 Feb 2016 19:21:21 -0800
> 
>> During hugepage unmap, TLB flush is currently issued
>> at every PAGE_SIZE'd boundary which is unnecessary. We
>> now issue the flush at REAL_HPAGE_SIZE boundaries only.
>>
>> Without this patch workloads which unmap a large hugepage
>> backed VMA region get CPU lockups due to excessive TLB
>> flush calls.
>>
>> Signed-off-by: Nitin Gupta <nitin.m.gupta@oracle.com>
> 
> Thanks for finding this but we'll need a few adjustments to your
> patch.
> 
> First of all, you can't do the final TLB flush of each REAL_HPAGE_SIZE
> entry until all of the PTE's that cover that region have been cleared.
> Otherwise a TLB miss on any cpu can reload the entry after you've
> flushed it.
> 
> Second, the stores should be done in a way such that they are done
> in-order and consequetively in order to optimize store buffer
> compression.
> 
> I would recommend clearing all of the PTE's and then executing the
> two TLB and TSB flushes right afterwards as an independant operation
> and not via pte_clear().
> 

Thanks for the review. I've sent v2 patch with above changes.

Apart from this lockup during unmap, I'm also getting lockups during
map of large hugepage backed VMA region. I see the backtrace as:
hugetlb_fault -> huge_pte_alloc -> __pte_alloc -> __raw_spin_trylock.

I think last level page table allocation can be completely avoided
for huge pages and only allocate till PMD level. This would atleast
avoid looping over 1024 PTEs during map/unmap and save some memory.
Do you think this change would be worth doing?

Thanks,
Nitin

