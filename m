From: David Miller <davem@davemloft.net>
Date: Mon, 23 May 2016 22:23:18 +0000
Subject: Re: newest 4.6.0-08907-g7639dad on sparc64 - possible irq lock inversion dependency detected
Message-Id: <20160523.152318.711850037896762432.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1605231407020.15124@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1605231407020.15124@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 23 May 2016 22:07:12 +0300 (EEST)

> I tested todays 4.6.0-08907-g7639dad on most of my sparc64 computers, 
> from Ultra 1 to T5120, doing local git clone + rm -rf to the cloned 
> tree. All computers were fine except my V240 whete I have turned on some 
> additional debugging options to catch a spontaneous reboot. On the V240, 
> I get a "possible irq lock inversion dependency detected" warning 
> (below, in the full dmesg).
> 
> This may or may not be related to the current changes - I rememeber 
> having seen and reported another lockdep issue in the past but can't 
> find the sent mail right now.

Thanks for the report.  This code path only runs on cheetah+ cpus,
which is why your V240 is one machine where you see this.

Please test the following patch, thanks again!

==========
sparc64: Take ctx_alloc_lock properly in hugetlb_setup().

On cheetahplus chips we take the ctx_alloc_lock in order to
modify the TLB lookup parameters for the indexed TLBs, which
are stored in the context register.

This is called with interrupts disabled, however ctx_alloc_lock
is an IRQ safe lock, therefore we must take acquire/release it
properly with spin_{lock,unlock}_irq().

Reported-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 652683c..52f9aec 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2826,7 +2826,7 @@ void hugetlb_setup(struct pt_regs *regs)
 	if (tlb_type = cheetah_plus) {
 		unsigned long ctx;
 
-		spin_lock(&ctx_alloc_lock);
+		spin_lock_irq(&ctx_alloc_lock);
 		ctx = mm->context.sparc64_ctx_val;
 		ctx &= ~CTX_PGSZ_MASK;
 		ctx |= CTX_PGSZ_BASE << CTX_PGSZ0_SHIFT;
@@ -2847,7 +2847,7 @@ void hugetlb_setup(struct pt_regs *regs)
 			mm->context.sparc64_ctx_val = ctx;
 			on_each_cpu(context_reload, mm, 0);
 		}
-		spin_unlock(&ctx_alloc_lock);
+		spin_unlock_irq(&ctx_alloc_lock);
 	}
 }
 #endif
