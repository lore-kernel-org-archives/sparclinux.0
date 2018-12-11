From: Corentin Labbe <clabbe@baylibre.com>
Date: Tue, 11 Dec 2018 12:11:09 +0000
Subject: [PATCH] sparc: Set "ARCH: sunxx" information on the same line
Message-Id: <1544530269-15008-1-git-send-email-clabbe@baylibre.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>

While checking boot log from SPARC qemu, I saw that the "ARCH: sunxx"
information was split on two different line.
This patchs merge both line together.
In the meantime, thoses information need to be printed via pr_info
since printk print them by default via the warning loglevel.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/sparc/kernel/setup_32.c | 13 ++++++-------
 arch/sparc/kernel/setup_64.c |  4 ++--
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index 7df3d704284c..afe1592a6d08 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -311,25 +311,24 @@ void __init setup_arch(char **cmdline_p)
 
 	register_console(&prom_early_console);
 
-	printk("ARCH: ");
 	switch(sparc_cpu_model) {
 	case sun4m:
-		printk("SUN4M\n");
+		pr_info("ARCH: SUN4M\n");
 		break;
 	case sun4d:
-		printk("SUN4D\n");
+		pr_info("ARCH: SUN4D\n");
 		break;
 	case sun4e:
-		printk("SUN4E\n");
+		pr_info("ARCH: SUN4E\n");
 		break;
 	case sun4u:
-		printk("SUN4U\n");
+		pr_info("ARCH: SUN4U\n");
 		break;
 	case sparc_leon:
-		printk("LEON\n");
+		pr_info("ARCH: LEON\n");
 		break;
 	default:
-		printk("UNKNOWN!\n");
+		pr_info("ARCH: UNKNOWN!\n");
 		break;
 	}
 
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 014390950333..51c4d12c0853 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -643,9 +643,9 @@ void __init setup_arch(char **cmdline_p)
 		register_console(&prom_early_console);
 
 	if (tlb_type = hypervisor)
-		printk("ARCH: SUN4V\n");
+		pr_info("ARCH: SUN4V\n");
 	else
-		printk("ARCH: SUN4U\n");
+		pr_info("ARCH: SUN4U\n");
 
 #ifdef CONFIG_DUMMY_CONSOLE
 	conswitchp = &dummy_con;
-- 
2.19.2
