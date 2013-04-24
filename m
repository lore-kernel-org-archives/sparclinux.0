From: David Miller <davem@davemloft.net>
Date: Wed, 24 Apr 2013 23:53:50 +0000
Subject: Re: sparc64, mm BUG in 3.9-rc8
Message-Id: <20130424.195350.1927101733139114761.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.SOC.1.00.1304230019030.12820@math.ut.ee>
	<20130423.161751.2116707386990845036.davem@davemloft.net>
	<20130424.143615.334401973542739420.davem@davemloft.net>
In-Reply-To: <20130424.143615.334401973542739420.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mroos@linux.ee
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 24 Apr 2013 14:36:15 -0400 (EDT)

> From: David Miller <davem@davemloft.net>
> Date: Tue, 23 Apr 2013 16:17:51 -0400 (EDT)
> 
>> From: Meelis Roos <mroos@linux.ee>
>> Date: Tue, 23 Apr 2013 00:19:49 +0300 (EEST)
>> 
>>>> > Hello, I got a non-booting Sun E420R (sparc64) with 3.9-rc8: BUG-s in 
>>>> > mm/slub.c:925 and mm/memory.c:1267 (the latter keeps scrolling until 
>>>> > other things break and panic comes from trying to kill init). This is 
>>>> > reproducible. Same machine runs 3.9.0-rc7-00004-gbb33db7 successfully.
>>>> > Configuration is below.
>>>> 
>>>> It's certainly a bug in the TLB shootdown fix, please verify that
>>>> reverting the following fixes things:
>>>> 
>>>> >From f36391d2790d04993f48da6a45810033a2cdf847 Mon Sep 17 00:00:00 2001
>>>> From: "David S. Miller" <davem@davemloft.net>
>>>> Date: Fri, 19 Apr 2013 17:26:26 -0400
>>>> Subject: [PATCH] sparc64: Fix race in TLB batch processing.
>>> 
>>> Yes, reverting that makes it work again.
>> 
>> Just an update, using your config I was able to make one that boots on my
>> machine and reproduces the problem.
> 
> Ok, I've narrowed it down to CONFIG_DEBUG_ATOMIC_SLEEP, as the exact config
> option which starts the crashes happening when it is enabled.
> 
> I should have this fixed by the end of today.

This fixes it, I'll push this to Linus immediately.

Thanks for your report!

--------------------
sparc64: Fix missing put_cpu_var() in tlb_batch_add_one() when not batching.

Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/mm/tlb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index 272aa4f..83d89bc 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -87,7 +87,7 @@ static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
 	if (!tb->active) {
 		global_flush_tlb_page(mm, vaddr);
 		flush_tsb_user_page(mm, vaddr);
-		return;
+		goto out;
 	}
 
 	if (nr = 0)
@@ -98,6 +98,7 @@ static void tlb_batch_add_one(struct mm_struct *mm, unsigned long vaddr,
 	if (nr >= TLB_BATCH_NR)
 		flush_tlb_pending();
 
+out:
 	put_cpu_var(tlb_batch);
 }
 
-- 
1.8.1.2


