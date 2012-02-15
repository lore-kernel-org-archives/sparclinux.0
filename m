From: Rusty Russell <rusty@rustcorp.com.au>
Date: Wed, 15 Feb 2012 05:10:04 +0000
Subject: [PATCH 8/12] arch/sparc: remove references to cpu_*_map.
Message-Id: <1329281884.6232.rusty@rustcorp.com.au>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

From: Rusty Russell <rusty@rustcorp.com.au>

This has been obsolescent for a while; time for the final push.

Also get rid of obsolescent first_cpu().

Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/kernel/leon_kernel.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -104,11 +104,11 @@ static int irq_choose_cpu(const struct c
 {
 	cpumask_t mask;
 
-	cpus_and(mask, cpu_online_map, *affinity);
-	if (cpus_equal(mask, cpu_online_map) || cpus_empty(mask))
+	cpumask_and(&mask, cpu_online_mask, affinity);
+	if (cpumask_equal(&mask, cpu_online_mask) || cpus_empty(mask))
 		return boot_cpu_id;
 	else
-		return first_cpu(mask);
+		return cpumask_first(&mask);
 }
 #else
 #define irq_choose_cpu(affinity) boot_cpu_id

