From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 26 Oct 2010 07:23:46 +0000
Subject: [PATCH] Fixed random SPARC/LEON SMP CPU Stuck problem.
Message-Id: <1288077826-9544-1-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/leon_smp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index e1656fc..7524689 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -56,8 +56,8 @@ void __init leon_configure_cache_smp(void);
 static inline unsigned long do_swap(volatile unsigned long *ptr,
 				    unsigned long val)
 {
-	__asm__ __volatile__("swapa [%1] %2, %0\n\t" : "=&r"(val)
-			     : "r"(ptr), "i"(ASI_LEON_DCACHE_MISS)
+	__asm__ __volatile__("swapa [%2] %3, %0\n\t" : "=&r"(val)
+			     : "0"(val), "r"(ptr), "i"(ASI_LEON_DCACHE_MISS)
 			     : "memory");
 	return val;
 }
-- 
1.5.4

