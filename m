From: Arpit Goel <B44344@freescale.com>
Date: Tue, 30 Jul 2013 12:50:20 +0000
Subject: [PATCH 2/2] Convert PowerPC macro spin_event_timeout() to architecture independent macro
Message-Id: <1375187900-17582-3-git-send-email-B44344@freescale.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1375187900-17582-1-git-send-email-B44344@freescale.com>
In-Reply-To: <1375187900-17582-1-git-send-email-B44344@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch ports PowerPC implementation of spin_event_timeout() for generic
use. Architecture specific implementation can be added to asm/delay.h, which
will override the generic linux implementation.

Signed-off-by: Arpit Goel <B44344@freescale.com>
---
 include/linux/delay.h | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/include/linux/delay.h b/include/linux/delay.h
index a6ecb34..e975994 100644
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -52,4 +52,44 @@ static inline void ssleep(unsigned int seconds)
 	msleep(seconds * 1000);
 }
 
+#ifndef spin_event_timeout
+/**
+ * spin_event_timeout - spin until a condition gets true or a timeout elapses
+ * @condition: a C expression to evalate
+ * @timeout: timeout, in microseconds
+ * @delay: the number of microseconds to delay between each evaluation of
+ *         @condition
+ *
+ * The process spins until the condition evaluates to true (non-zero) or the
+ * timeout elapses.  The return value of this macro is the value of
+ * @condition when the loop terminates. This allows you to determine the cause
+ * of the loop terminates.  If the return value is zero, then you know a
+ * timeout has occurred.
+ *
+ * This primary purpose of this macro is to poll on a hardware register
+ * until a status bit changes.  The timeout ensures that the loop still
+ * terminates even if the bit never changes.  The delay is for devices that
+ * need a delay in between successive reads.
+ *
+ * gcc will optimize out the if-statement if @delay is a constant.
+ *
+ * This is copied from PowerPC based spin_event_timeout() implementation
+ * and modified for generic usecase.
+ */
+#define spin_event_timeout(condition, timeout, delay)		\
+({								\
+	typeof(condition) __ret;				\
+	unsigned long __loops = timeout/USECS_PER_JIFFY;	\
+	unsigned long __start = jiffies;			\
+	while (!(__ret = (condition)) &&			\
+		time_before(jiffies, __start + __loops + 1))	\
+		if (delay)					\
+			udelay(delay);				\
+		else						\
+			schedule();				\
+	if (!__ret)						\
+		__ret = (condition);				\
+	__ret;							\
+})
+#endif
 #endif /* defined(_LINUX_DELAY_H) */
-- 
1.8.1.4


