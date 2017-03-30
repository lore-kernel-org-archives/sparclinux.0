From: David Miller <davem@davemloft.net>
Date: Thu, 30 Mar 2017 21:54:10 +0000
Subject: Re: tlb_batch_add_one()
Message-Id: <20170330.145410.98569109524977127.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20170328.175226.210187301635964014.davem@davemloft.net>
In-Reply-To: <20170328.175226.210187301635964014.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Thu, 30 Mar 2017 14:25:53 -0700 (PDT)

> From: Nitin Gupta <nitin.m.gupta@oracle.com>
> Date: Thu, 30 Mar 2017 13:47:11 -0700
> 
>> I will be sending a fix for these call-sites today.
> 
> I already have a fix I'm testing now which I'll check in after my
> regression test passes.

So even with the shifts fixed, as per the patch below, I'm still getting
corruptions during gcc bootstraps.

If I cannot figure out what the problem is by the end of the day I'm
reverting the change.  I've already spend a week trying to figure out
what introduced these regressions...

diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index afda3bb..ee8066c 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -154,7 +154,7 @@ static void tlb_batch_pmd_scan(struct mm_struct *mm, unsigned long vaddr,
 		if (pte_val(*pte) & _PAGE_VALID) {
 			bool exec = pte_exec(*pte);
 
-			tlb_batch_add_one(mm, vaddr, exec, false);
+			tlb_batch_add_one(mm, vaddr, exec, PAGE_SHIFT);
 		}
 		pte++;
 		vaddr += PAGE_SIZE;
@@ -209,9 +209,9 @@ void set_pmd_at(struct mm_struct *mm, unsigned long addr,
 			pte_t orig_pte = __pte(pmd_val(orig));
 			bool exec = pte_exec(orig_pte);
 
-			tlb_batch_add_one(mm, addr, exec, true);
+			tlb_batch_add_one(mm, addr, exec, REAL_HPAGE_SHIFT);
 			tlb_batch_add_one(mm, addr + REAL_HPAGE_SIZE, exec,
-					true);
+					  REAL_HPAGE_SHIFT);
 		} else {
 			tlb_batch_pmd_scan(mm, addr, orig);
 		}
