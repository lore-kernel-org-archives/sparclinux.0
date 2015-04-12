From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 12 Apr 2015 02:58:25 +0000
Subject: [PATCH] sparc: Fix execution domain removal
Message-Id: <1428807505-7658-1-git-send-email-linux@roeck-us.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Richard Weinberger <richard@nod.at>
Cc: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

ksp must be 8-byte aligned.

Cc: Richard Weinberger <richard@nod.at>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Applies on top of Richard's execution domain removal code.
Tested with qemu.

 arch/sparc/include/asm/thread_info_32.h | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/include/asm/thread_info_32.h b/arch/sparc/include/asm/thread_info_32.h
index a7a18142099e..229475f0d7ce 100644
--- a/arch/sparc/include/asm/thread_info_32.h
+++ b/arch/sparc/include/asm/thread_info_32.h
@@ -34,6 +34,8 @@ struct thread_info {
 	int			softirq_count;
 	int			hardirq_count;
 
+	u32 __unused;
+
 	/* Context switch saved kernel state. */
 	unsigned long ksp;	/* ... ksp __attribute__ ((aligned (8))); */
 	unsigned long kpc;
@@ -88,13 +90,13 @@ register struct thread_info *current_thread_info_reg asm("g6");
 #define TI_PREEMPT	0x10	/* preempt_count */
 #define TI_SOFTIRQ	0x14	/* softirq_count */
 #define TI_HARDIRQ	0x18	/* hardirq_count */
-#define TI_KSP		0x1c	/* ksp */
-#define TI_KPC		0x20	/* kpc (ldd'ed with kpc) */
-#define TI_KPSR		0x24	/* kpsr */
-#define TI_KWIM		0x28	/* kwim (ldd'ed with kpsr) */
-#define TI_REG_WINDOW	0x2c
-#define TI_RWIN_SPTRS	0x22c
-#define TI_W_SAVED	0x24c
+#define TI_KSP		0x20	/* ksp */
+#define TI_KPC		0x24	/* kpc (ldd'ed with kpc) */
+#define TI_KPSR		0x28	/* kpsr */
+#define TI_KWIM		0x2c	/* kwim (ldd'ed with kpsr) */
+#define TI_REG_WINDOW	0x30
+#define TI_RWIN_SPTRS	0x230
+#define TI_W_SAVED	0x250
 
 /*
  * thread information flag bit numbers
-- 
2.1.0

