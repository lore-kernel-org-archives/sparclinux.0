From: Bob Picco <bob.picco@oracle.com>
Date: Tue, 25 Jul 2017 13:45:15 +0000
Subject: Re: [PATCH v1 0/4] Context domains
Message-Id: <20170725134515.GI26577@zareason>
List-Id: <sparclinux.vger.kernel.org>
References: <1500601861-203232-1-git-send-email-pasha.tatashin@oracle.com>
In-Reply-To: <1500601861-203232-1-git-send-email-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

David Miller wrote:	[Thu Jul 20 2017, 11:06:55PM EDT]
> From: David Miller <davem@davemloft.net>
> Date: Fri, 21 Jul 2017 03:50:05 +0100 (WEST)
> 
> > Having to allocate a full trap frame just to TLB flush one page or an
> > MM is a serious regression.
> > 
> > Next, allocating a whole new data structure and clearing it out on
> > every new address creation is going to be a significant new cost as
> > well.
None of this work has seen performance analysis. We rushed our sharing
because of forthcoming job reassignments.
> 
> So, just thinking out loud:
> 
> 1) You can retain the cross call TLB flush assembler by passing in the
>    appropriate context value for each individual cpu from the cross
>    call dispatcher.
Agreed and reinstated.
> 
> 2) If you have some constant bounds on the upper number of context
>    domains, you can simply inline them into the existing mmu_context
>    structure.  This avoids the memory allocation per mm creation.
Yes the direction I was moving towards on Friday (7/14). I have
similar on top of what Pasha posted. It has to be debugged and tested.
Pasha made some nice identifier name changes and clean ups before
posting.
> 
> You can also make the context domain salting extremely cheap.
> Perhaps something like "(cpuid>>x) & y".
> 
> No, you won't map cores to context domains so precisely like the
> code does now, but you will make up for it in code simplicity and
> overall new costs added by these changes for the more common
> cases.
> 
> I suggest "(cpuid>>x) & y" and a very small number of context domains
> (which determines 'y') because we don't need something perfect, we
> need something which divides the problem by some order of magnitude.
> 
> The hash of locks caught my eye as well.  I think you don't need that
> and we really steer clear of hashed spinlock tables in the Linux
> kernel because they never scale properly.
Agreed and witnessed during experimentation  (7/7 - 7/11) with CTX_NR_BITS
reduction.
> 
> Instead, I think you can use something like RCU to provide the
> necessary synchronization.  So you could first make sure X isn't
> referenced on the local cpu any more, and then do call_rcu() to do the
> actual clearing of the bitmap which allows X to be allocated again.
Making the context id array compile time within mm_context_t eliminates
requirement for hashed spin lock. The elimination of hash spin lock and
code simplicity is why I changed direction on 7/14. Not sure we will
require any RCU like thing. This also will likely make mm_cd_destroy()
more scalable with fewer context domains to inspect and possibly context
id releases. The context id release aspect will decrease wrap events.

It is difficult to satisfy all topologies. To me it seems likely
impossible.

This is a snippet of the patch series. I just booted it on my t5-2:
diff --git a/arch/sparc/include/asm/mmu_64.h b/arch/sparc/include/asm/mmu_64.h
index 83b36a5..11f2c07 100644
--- a/arch/sparc/include/asm/mmu_64.h
+++ b/arch/sparc/include/asm/mmu_64.h
@@ -53,10 +53,6 @@
 #define CTX_HW_MASK		(CTX_NR_MASK | CTX_PGSZ_MASK)
 
 #define CTX_FIRST_VERSION	BIT(CTX_VERSION_SHIFT)
-#define CTX_VALID(__ctx)	\
-	 (!(((__ctx.sparc64_ctx_val) ^ tlb_context_cache) & CTX_VERSION_MASK))
-#define CTX_HWBITS(__ctx)	((__ctx.sparc64_ctx_val) & CTX_HW_MASK)
-#define CTX_NRBITS(__ctx)	((__ctx.sparc64_ctx_val) & CTX_NR_MASK)
 
 #ifndef __ASSEMBLY__
 
@@ -89,9 +85,21 @@ struct tsb_config {
 #define MM_NUM_TSBS	1
 #endif
 
+int alloc_context_domain(int cpu);
+void cd_cpu_online(int cpu);
+void cd_cpu_offline(int cpu);
+void mm_cd_destroy(struct mm_struct *mm);
+
+#define CPU_TO_CD_SHIFT		(8)
+#define CD_MAX			(0x10u)
+#define CD_MASK			(0x0fu)
+#define CPU_TO_CD(CPUID)	(((CPUID) >> CPU_TO_CD_SHIFT) & CD_MASK)
+
+#define NR_CD	(CPU_TO_CD((CONFIG_NR_CPUS - 1)) + 1)
+
 typedef struct {
 	spinlock_t		lock;
-	unsigned long		sparc64_ctx_val;
+	unsigned long		cds[NR_CD];
 	unsigned long		hugetlb_pte_count;
 	unsigned long		thp_pte_count;
 	struct tsb_config	tsb_block[MM_NUM_TSBS];
. We may want to reduce CPU_TO_CD_SHIFT to let's say 7. I will have
to do this just for testing on my t5-2. The current value of 8 will
likely make Debian a single context domain. Please allow a couple
more days for testing.

To summarize, reinstate cross calls, mm_cd_destroy() will now release
valid context-id-s (mitigate wrap) and compile time mm.context.cds.
> 
> Just some ideas...
thanx,

bob
