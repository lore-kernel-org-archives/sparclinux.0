From: David Miller <davem@davemloft.net>
Date: Mon, 14 May 2012 21:28:38 +0000
Subject: Re: [PATCH] sparc32: Move cache and TLB flushes over to method ops.
Message-Id: <20120514.172838.512742393144403575.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120513.235611.828382132525916634.davem@davemloft.net>
In-Reply-To: <20120513.235611.828382132525916634.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 14 May 2012 14:16:12 +0200

> There is a bunch of inlines in smp_32.h you miss
> to kill:
> 
> hard_smp4m_processor_id,
> hard_smp4d_processor_id,
> hard_smpleon_processor_id

Taken care of, as follows:

--------------------
[PATCH] sparc32: Kill unused hard_smp{4m,4d,leon}_processor_id() inlined.

Reported-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/smp_32.h |   29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_32.h
index b9cf697..b73da3c 100644
--- a/arch/sparc/include/asm/smp_32.h
+++ b/arch/sparc/include/asm/smp_32.h
@@ -103,35 +103,6 @@ static inline int cpu_logical_map(int cpu)
 	return cpu;
 }
 
-static inline int hard_smp4m_processor_id(void)
-{
-	int cpuid;
-
-	__asm__ __volatile__("rd %%tbr, %0\n\t"
-			     "srl %0, 12, %0\n\t"
-			     "and %0, 3, %0\n\t" :
-			     "=&r" (cpuid));
-	return cpuid;
-}
-
-static inline int hard_smp4d_processor_id(void)
-{
-	int cpuid;
-
-	__asm__ __volatile__("lda [%%g0] %1, %0\n\t" :
-			     "=&r" (cpuid) : "i" (ASI_M_VIKING_TMP1));
-	return cpuid;
-}
-
-extern inline int hard_smpleon_processor_id(void)
-{
-	int cpuid;
-	__asm__ __volatile__("rd     %%asr17,%0\n\t"
-			     "srl    %0,28,%0" :
-			     "=&r" (cpuid) : );
-	return cpuid;
-}
-
 extern int hard_smp_processor_id(void);
 
 #define raw_smp_processor_id()		(current_thread_info()->cpu)
-- 
1.7.10

