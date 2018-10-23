From: David Miller <davem@davemloft.net>
Date: Tue, 23 Oct 2018 02:19:33 +0000
Subject: [PATCH 3/8] sparc: Don't bother masking out TICK_PRIV_BIT in VDSO code.
Message-Id: <20181022.191933.1451006043147538752.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


If the TICK_PRIV_BIT was set, we would not be able to read the tick
register in user space, which is where this code runs.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/vdso/vclock_gettime.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index 75c49fcb57aa..4e853d1582c7 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -26,13 +26,6 @@
 #include <asm/clocksource.h>
 #include <asm/vvar.h>
 
-#undef	TICK_PRIV_BIT
-#ifdef	CONFIG_SPARC64
-#define	TICK_PRIV_BIT	(1UL << 63)
-#else
-#define	TICK_PRIV_BIT	(1ULL << 63)
-#endif
-
 #ifdef	CONFIG_SPARC64
 #define SYSCALL_STRING							\
 	"ta	0x6d;"							\
@@ -112,7 +105,7 @@ notrace static __always_inline u64 vread_tick(void)
 			     "rd		%%asr24, %0\n\t"
 			     ".popsection\n"
 			     : "=r" (ret));
-	return ret & ~TICK_PRIV_BIT;
+	return ret;
 }
 #else
 notrace static __always_inline u64 vread_tick(void)
-- 
2.19.1.328.g5a0cc8aca
