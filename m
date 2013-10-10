From: Bob Picco <bpicco@meloft.net>
Date: Thu, 10 Oct 2013 14:19:06 +0000
Subject: Re: [PATCH v2 0/9] sparc64: Support 47-bit physical addresses.
Message-Id: <20131010141906.GP29427@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <20130930.123130.354302574443157859.davem@davemloft.net>
In-Reply-To: <20130930.123130.354302574443157859.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Wed Oct 09 2013, 04:03:09PM EDT]
> From: Bob Picco <bpicco@meloft.net>
> Date: Fri, 4 Oct 2013 11:45:55 -0400
> 
> > The issue appears to be corruption.
> 
> I think I know what the problem is.
> 
> In set_pmd_at() we need to flush two 4MB pages.
> 
> I'll play around with your test case and a potential fix, thanks.
I believe you need this too. Otherwise the wrong tsb is computed.

 arch/sparc/mm/init_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 4d0c99b..807e108 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2722,7 +2722,7 @@ void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
 	spin_lock_irqsave(&mm->context.lock, flags);
 
 	if (mm->context.tsb_block[MM_TSB_HUGE].tsb != NULL)
-		__update_mmu_tsb_insert(mm, MM_TSB_HUGE, HPAGE_SHIFT,
+		__update_mmu_tsb_insert(mm, MM_TSB_HUGE, REAL_HPAGE_SHIFT,
 					addr, pte);
 
 	spin_unlock_irqrestore(&mm->context.lock, flags);
