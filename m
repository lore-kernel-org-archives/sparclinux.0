From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 04 Jan 2011 11:41:31 +0000
Subject: [PATCH 3/7] LEON: added raw AMBA vendor/device number to find TIMER,IRQCTRL
Message-Id: <1294141295-26584-3-git-send-email-daniel@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/leon_kernel.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/leon_kernel.c b/arch/sparc/kernel/leon_kernel.c
index 91a978f..88ade07 100644
--- a/arch/sparc/kernel/leon_kernel.c
+++ b/arch/sparc/kernel/leon_kernel.c
@@ -120,8 +120,11 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 	if (!rootnp)
 		goto bad;
 	np = of_find_node_by_name(rootnp, "GAISLER_IRQMP");
-	if (!np)
-		goto bad;
+	if (!np) {
+		np = of_find_node_by_name(rootnp, "01_00d");
+		if (!np)
+			goto bad;
+	}
 	pp = of_find_property(np, "reg", &len);
 	if (!pp)
 		goto bad;
@@ -129,8 +132,11 @@ void __init leon_init_timers(irq_handler_t counter_fn)
 
 	/* Find GPTIMER Timer Registers base address otherwise bail out. */
 	np = of_find_node_by_name(rootnp, "GAISLER_GPTIMER");
-	if (!np)
-		goto bad;
+	if (!np) {
+		np = of_find_node_by_name(np, "01_011");
+		if (!np)
+			goto bad;
+	}
 	pp = of_find_property(np, "reg", &len);
 	if (!pp)
 		goto bad;
-- 
1.5.4

