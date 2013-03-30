From: Kefeng Wang <wangkefeng.wang@huawei.com>
Date: Sat, 30 Mar 2013 10:28:26 +0000
Subject: [PATCH] sparc:cleanup unused code in smp_32.h
Message-Id: <5156BE4A.2030400@huawei.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sam@ravnborg.org, davem@davemloft.net
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, "Guohanjun (Hanjun Guo)" <guohanjun@huawei.com>, wangyijing@huawei.com

After genirq and generic clockevent support at sparc32,
smp4m_irq_rotate(), prof_multiplier() and prof_counter()
are no longer used and should be removed.

Find more info from commit 6baa9b20 & 62f08283.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/sparc/include/asm/smp_32.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_32.h
index 68503d3..3c8917f 100644
--- a/arch/sparc/include/asm/smp_32.h
+++ b/arch/sparc/include/asm/smp_32.h
@@ -36,7 +36,6 @@ typedef void (*smpfunc_t)(unsigned long, unsigned long, unsigned long,
 		       unsigned long, unsigned long);

 void cpu_panic(void);
-extern void smp4m_irq_rotate(int cpu);

 /*
  *	General functions that each host system must provide.
@@ -106,9 +105,6 @@ extern int hard_smp_processor_id(void);

 #define raw_smp_processor_id()		(current_thread_info()->cpu)

-#define prof_multiplier(__cpu)		cpu_data(__cpu).multiplier
-#define prof_counter(__cpu)		cpu_data(__cpu).counter
-
 void smp_setup_cpu_possible_map(void);

 #endif /* !(__ASSEMBLY__) */
-- 
1.6.0.2

