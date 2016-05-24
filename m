From: David Miller <davem@davemloft.net>
Date: Tue, 24 May 2016 21:16:41 +0000
Subject: Re: newest 4.6.0-08907-g7639dad on sparc64 - possible irq lock inversion dependency detected
Message-Id: <20160524.141641.74660764921421886.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1605231407020.15124@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1605231407020.15124@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Tue, 24 May 2016 22:34:05 +0300 (EEST)

>> Thanks for the report.  This code path only runs on cheetah+ cpus,
>> which is why your V240 is one machine where you see this.
>> 
>> Please test the following patch, thanks again!
>> 
>> ==========
>> sparc64: Take ctx_alloc_lock properly in hugetlb_setup().
> 
> This seems to work fine - ran "git clone-" for hours and the warning did 
> not reappear.
> 
> However, I have seen this during the hours in dmesg, sooin after start:
> 
> [  698.710915] ------------[ cut here ]------------
> [  698.771673] WARNING: CPU: 1 PID: 1565 at kernel/smp.c:416 smp_call_function_many+0xc0/0x400
> [  698.881558] Modules linked in: loop sg tg3 i2c_ali15x3 hwmon i2c_ali1535 ptp pps_core skge i2c_core
> [  699.000592] CPU: 1 PID: 1565 Comm: git Not tainted 4.6.0-08907-g7639dad-dirty #8
> [  699.097834] Call Trace:
> [  699.129850]  [00000000004602a4] __warn+0xa4/0xe0
> [  699.190471]  [0000000000460378] warn_slowpath_null+0x18/0x40
> [  699.264816]  [00000000004e7ae0] smp_call_function_many+0xc0/0x400
> [  699.344882]  [00000000004e7e44] smp_call_function+0x24/0x40
> [  699.418081]  [00000000004e7e7c] on_each_cpu+0x1c/0xa0
> [  699.484422]  [0000000000451a80] hugetlb_setup+0x120/0x160

Oh, we can't do the context reload with interrupts disabled.

Here is a new version of the patch which should fix this problem as well.

Thanks!

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index 652683c..14bb0d5 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2824,9 +2824,10 @@ void hugetlb_setup(struct pt_regs *regs)
 	 * the Data-TLB for huge pages.
 	 */
 	if (tlb_type = cheetah_plus) {
+		bool need_context_reload = false;
 		unsigned long ctx;
 
-		spin_lock(&ctx_alloc_lock);
+		spin_lock_irq(&ctx_alloc_lock);
 		ctx = mm->context.sparc64_ctx_val;
 		ctx &= ~CTX_PGSZ_MASK;
 		ctx |= CTX_PGSZ_BASE << CTX_PGSZ0_SHIFT;
@@ -2845,9 +2846,12 @@ void hugetlb_setup(struct pt_regs *regs)
 			 * also executing in this address space.
 			 */
 			mm->context.sparc64_ctx_val = ctx;
-			on_each_cpu(context_reload, mm, 0);
+			need_context_reload = true;
 		}
-		spin_unlock(&ctx_alloc_lock);
+		spin_unlock_irq(&ctx_alloc_lock);
+
+		if (need_context_reload)
+			on_each_cpu(context_reload, mm, 0);
 	}
 }
 #endif
