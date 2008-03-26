From: David Miller <davem@davemloft.net>
Date: Wed, 26 Mar 2008 11:25:16 +0000
Subject: Re: sparc64 BUG: using smp_processor_id() in preemptible
Message-Id: <20080326.042516.261621639.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LFD.1.00.0803251856450.2775@woody.linux-foundation.org>
	<200803261142.07422.m.kozlowski@tuxland.pl>
	<20080326.041626.224135350.davem@davemloft.net>
In-Reply-To: <20080326.041626.224135350.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: m.kozlowski@tuxland.pl
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Wed, 26 Mar 2008 04:16:26 -0700 (PDT)

> From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> Date: Wed, 26 Mar 2008 11:42:07 +0100
> 
> > I see lots of these messages on my ultra 60 box.
> 
> This is a sparc64 bug.

And this patch should fix it:

commit 69072f6e8e4bd4799d2a54e4ff8771d0657512c1
Author: David S. Miller <davem@davemloft.net>
Date:   Wed Mar 26 04:25:00 2008 -0700

    [SPARC64]: Fix __get_cpu_var in preemption-enabled area.
    
    Reported by Mariusz Kozlowski.
    
    Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc64/mm/tlb.c b/arch/sparc64/mm/tlb.c
index 3f10fc9..a0f000b 100644
--- a/arch/sparc64/mm/tlb.c
+++ b/arch/sparc64/mm/tlb.c
@@ -23,10 +23,11 @@ DEFINE_PER_CPU(struct mmu_gather, mmu_gathers) = { 0, };
 
 void flush_tlb_pending(void)
 {
-	struct mmu_gather *mp = &__get_cpu_var(mmu_gathers);
+	struct mmu_gather *mp;
 
 	preempt_disable();
 
+	mp = &__get_cpu_var(mmu_gathers);
 	if (mp->tlb_nr) {
 		flush_tsb_user(mp);
 
