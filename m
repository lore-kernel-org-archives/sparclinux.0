From: David Miller <davem@davemloft.net>
Date: Tue, 07 Apr 2009 22:16:38 +0000
Subject: Re: kernel bug with CONFIG_KEYBOARD_ATKBD=y
Message-Id: <20090407.151638.93201206.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <200904071001.19368.dennis@ausil.us>
In-Reply-To: <200904071001.19368.dennis@ausil.us>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Dennis Gilmore <dennis@ausil.us>
Date: Tue, 7 Apr 2009 17:10:08 -0500

> On Tuesday 07 April 2009 04:57:55 pm David Miller wrote:
>> From: Dennis Gilmore <dennis@ausil.us>
>> Date: Tue, 7 Apr 2009 10:01:17 -0500
>>
>> > Initalizing network drop monitor service
>> > kernel BUG at
>> > /builddir/build/BUILD/kernel-2.6.29/linux-2.6.29.sparc64/arch/sparc/inclu
>> >de/asm/tlb_64.h:48!
>>
>> What kernel is this tree based upon?  2.6.29.1?
> yeah 2.6.29.1

A sparc64 fix I put into 2.6.29.1 is likely the cause.  It's possible
I put in a version without a particular issue cured.

I'm going to work on figuring out what the problem is, but for now you
can just revert the patch below.  Your problem had absolutely nothing
to do with turning KEYBOARD_ATKBD on, any kernel configuration would
hit this when running the X server.

commit b6816b706138c3870f03115071872cad824f90b4
Author: David S. Miller <davem@davemloft.net>
Date:   Thu Mar 26 01:28:53 2009 -0700

    sparc64: Flush TLB before releasing pages.
    
    [ Upstream commit a552a42cfa91ab653128dff89a70c8dde7fed042 ]
    
    tlb_flush_mmu() needs to flush pending TLB entries before
    processing the mmu_gather ->pages list.
    
    Noticed by Benjamin Herrenschmidt.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>
    Signed-off-by: Chris Wright <chrisw@sous-sol.org>

diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
index ec81cde..0aaa086 100644
--- a/arch/sparc/include/asm/tlb_64.h
+++ b/arch/sparc/include/asm/tlb_64.h
@@ -58,6 +58,8 @@ static inline struct mmu_gather *tlb_gather_mmu(struct mm_struct *mm, unsigned i
 static inline void tlb_flush_mmu(struct mmu_gather *mp)
 {
 	if (mp->need_flush) {
+		if (!mp->fullmm)
+			flush_tlb_pending();
 		free_pages_and_swap_cache(mp->pages, mp->pages_nr);
 		mp->pages_nr = 0;
 		mp->need_flush = 0;
@@ -78,8 +80,6 @@ static inline void tlb_finish_mmu(struct mmu_gather *mp, unsigned long start, un
 
 	if (mp->fullmm)
 		mp->fullmm = 0;
-	else
-		flush_tlb_pending();
 
 	/* keep the page table cache within bounds */
 	check_pgt_cache();
