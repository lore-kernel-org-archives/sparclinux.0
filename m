From: David Miller <davem@davemloft.net>
Date: Wed, 26 Nov 2008 08:40:59 +0000
Subject: [PATCH 5/6]: sparc64: Add write_pic() helper.
Message-Id: <20081126.004059.41831525.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc64: Add write_pic() helper.

It writes the %pic register, keeping mind of processor bugs.

Implement reset_pic() in terms of it.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/system_64.h |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/system_64.h b/arch/sparc/include/asm/system_64.h
index 779cf62..6c07781 100644
--- a/arch/sparc/include/asm/system_64.h
+++ b/arch/sparc/include/asm/system_64.h
@@ -96,11 +96,12 @@ do {	__asm__ __volatile__("ba,pt	%%xcc, 1f\n\t" \
  * arch/sparc64/kernel/smp.c:smp_percpu_timer_interrupt()
  * for more information.
  */
-#define reset_pic()    						\
-	__asm__ __volatile__("ba,pt	%xcc, 99f\n\t"		\
+#define write_pic(__p)  					\
+	__asm__ __volatile__("ba,pt	%%xcc, 99f\n\t"		\
 			     ".align	64\n"			\
-			  "99:wr	%g0, 0x0, %pic\n\t"	\
-			     "rd	%pic, %g0")
+			  "99:wr	%0, 0x0, %%pic\n\t"	\
+			     "rd	%%pic, %%g0" : : "r" (__p))
+#define reset_pic()	write_pic(0)
 
 #ifndef __ASSEMBLY__
 
-- 
1.5.6.5

