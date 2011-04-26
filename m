From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 26 Apr 2011 07:43:48 +0000
Subject: [PATCH] sparc32,leon: added some SMP comments
Message-Id: <1303803828-429-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/include/asm/smp_32.h   |    5 +++++
 arch/sparc/include/asm/winmacro.h |    9 +++++++++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/smp_32.h b/arch/sparc/include/asm/smp_32.h
index 8390ef6..dd5b9bb 100644
--- a/arch/sparc/include/asm/smp_32.h
+++ b/arch/sparc/include/asm/smp_32.h
@@ -124,6 +124,11 @@ static inline int hard_smp_processor_id(void)
 		__asm__ __volatile__("lda [%g0] ASI_M_VIKING_TMP1, %0\n\t"
 				     "nop; nop" :
 				     "=&r" (cpuid));
+		     - leon
+		__asm__ __volatile__(	"rd %asr17, %0\n\t"
+					"srl %0, 0x1c, %0\n\t"
+					"nop\n\t" :
+					"=&r" (cpuid));
 	   See btfixup.h and btfixupprep.c to understand how a blackbox works.
 	 */
 	__asm__ __volatile__("sethi %%hi(___b_hard_smp_processor_id), %0\n\t"
diff --git a/arch/sparc/include/asm/winmacro.h b/arch/sparc/include/asm/winmacro.h
index 5b0a06d..a9be04b 100644
--- a/arch/sparc/include/asm/winmacro.h
+++ b/arch/sparc/include/asm/winmacro.h
@@ -103,6 +103,7 @@
         st       %scratch, [%cur_reg + TI_W_SAVED];
 
 #ifdef CONFIG_SMP
+/* Results of LOAD_CURRENT() after BTFIXUP for SUN4M, SUN4D & LEON (comments) */
 #define LOAD_CURRENT4M(dest_reg, idreg) \
         rd       %tbr, %idreg; \
 	sethi    %hi(current_set), %dest_reg; \
@@ -118,6 +119,14 @@
 	or	%dest_reg, %lo(C_LABEL(current_set)), %dest_reg; \
 	ld	[%idreg + %dest_reg], %dest_reg;
 
+#define LOAD_CURRENT_LEON(dest_reg, idreg)			\
+	rd	%asr17, %idreg;					\
+	sethi	%hi(current_set), %dest_reg;			\
+	srl	%idreg, 0x1c, %idreg;				\
+	or	%dest_reg, %lo(current_set), %dest_reg;		\
+	sll	%idreg, 0x2, %idreg;				\
+	ld	[%idreg + %dest_reg], %dest_reg;
+
 /* Blackbox - take care with this... - check smp4m and smp4d before changing this. */
 #define LOAD_CURRENT(dest_reg, idreg) 					\
 	sethi	 %hi(___b_load_current), %idreg;			\
-- 
1.5.4

