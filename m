From: =?utf-8?q?S=2E=C3=87a=C4=9Flar=20Onur?= <caglar@pardus.org.tr>
Date: Thu, 14 Feb 2008 15:36:43 +0000
Subject: [PATCH 05/14] arch/sparc64/kernel/unaligned.c: Use time_* macros
Message-Id: <1203003412-11594-6-git-send-email-caglar@pardus.org.tr>
List-Id: <sparclinux.vger.kernel.org>
References: y
In-Reply-To: y
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, =?utf-8?q?S=2E=C3=87a=C4=9Flar=20Onur?= <caglar@pardus.org.tr>

The functions time_before, time_before_eq, time_after, and time_after_eq are more robust for comparing jiffies against other values.

So following patch implements usage of the time_after() macro, defined at linux/jiffies.h, which deals with wrapping correctly

Cc: sparclinux@vger.kernel.org
Signed-off-by: S.Çağlar Onur <caglar@pardus.org.tr>
---
 arch/sparc64/kernel/unaligned.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/sparc64/kernel/unaligned.c b/arch/sparc64/kernel/unaligned.c
index dc7bf1b..1a511e9 100644
--- a/arch/sparc64/kernel/unaligned.c
+++ b/arch/sparc64/kernel/unaligned.c
@@ -7,6 +7,7 @@
  */
 
 
+#include <linux/jiffies.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
@@ -283,7 +284,7 @@ static void log_unaligned(struct pt_regs *regs)
 {
 	static unsigned long count, last_time;
 
-	if (jiffies - last_time > 5 * HZ)
+	if (time_after(jiffies, last_time + 5 * HZ))
 		count = 0;
 	if (count < 5) {
 		last_time = jiffies;
-- 
1.5.3.7

