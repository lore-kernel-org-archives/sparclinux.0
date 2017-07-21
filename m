From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Fri, 21 Jul 2017 01:50:58 +0000
Subject: [PATCH v1 1/4] sparc64: interface to get random tick
Message-Id: <1500601861-203232-2-git-send-email-pasha.tatashin@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Sometimes it is useful to use tick in hash calculations or backoff
randomization. get_rand_tick()  can be used for these purposes.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Bob Picco <bob.picco@oracle.com>
---
 arch/sparc/include/asm/timer_64.h |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/timer_64.h b/arch/sparc/include/asm/timer_64.h
index 51bc3bc..aa28bb4 100644
--- a/arch/sparc/include/asm/timer_64.h
+++ b/arch/sparc/include/asm/timer_64.h
@@ -94,4 +94,19 @@ static inline unsigned long get_tick(void)
 	return tick;
 }
 
+/* Quick way to get a tick value that can be used in hash calculations,
+ * random backoffs etc.
+ */
+static inline unsigned long get_rand_tick(void)
+{
+	unsigned long tick;
+
+	__asm__ __volatile__(
+	"	rd	%%tick, %0\n"
+	: "=r" (tick)
+	: /* No input */);
+
+	return tick;
+}
+
 #endif /* _SPARC64_TIMER_H */
-- 
1.7.1

