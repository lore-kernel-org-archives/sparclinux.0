From: Hans Wennborg <hans@hanshq.net>
Date: Wed, 06 Aug 2014 04:41:36 +0000
Subject: [PATCH 01/15] sparc: fix decimal printf format specifiers prefixed with 0x
Message-Id: <1407300096-32151-1-git-send-email-hans@hanshq.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hans Wennborg <hans@hanshq.net>

The prefix suggests the number should be printed in hex, so use
the %x specifier to do that.

Found by using regex suggested by Joe Perches.

Signed-off-by: Hans Wennborg <hans@hanshq.net>
---
 arch/sparc/kernel/smp_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 7958242..b3a5d81 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -68,7 +68,7 @@ void smp_store_cpu_info(int id)
 	mid = cpu_get_hwmid(cpu_node);
 
 	if (mid < 0) {
-		printk(KERN_NOTICE "No MID found for CPU%d at node 0x%08d", id, cpu_node);
+		printk(KERN_NOTICE "No MID found for CPU%d at node 0x%08x", id, cpu_node);
 		mid = 0;
 	}
 	cpu_data(id).mid = mid;
-- 
2.0.0.526.g5318336

