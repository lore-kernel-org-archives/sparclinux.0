From: Khalid Aziz <khalid.aziz@oracle.com>
Date: Wed, 02 Dec 2015 23:06:40 +0000
Subject: [PATCH] sparc64: Add ADI capability to cpu capabilities
Message-Id: <1449097600-23288-1-git-send-email-khalid.aziz@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: Khalid Aziz <khalid.aziz@oracle.com>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

Add ADI (Application Data Integrity) capability to cpu capabilities list.
ADI capability allows virtual addresses to be encoded with a tag in
bits 63-60. This tag serves as an access control key for the regions
of virtual address with ADI enabled and a key set on them. Hypervisor
encodes this capability as "adp" in "hwcap-list" property in machine
description.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
---
 arch/sparc/include/asm/elf_64.h |  1 +
 arch/sparc/kernel/setup_64.c    | 23 +++++++++++++++--------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/include/asm/elf_64.h b/arch/sparc/include/asm/elf_64.h
index 370ca1e..9331083 100644
--- a/arch/sparc/include/asm/elf_64.h
+++ b/arch/sparc/include/asm/elf_64.h
@@ -95,6 +95,7 @@
  * really available.  So we simply advertise only "crypto" support.
  */
 #define HWCAP_SPARC_CRYPTO	0x04000000 /* CRYPTO insns available */
+#define HWCAP_SPARC_ADI		0x08000000 /* ADI available */
 
 #define CORE_DUMP_USE_REGSET
 
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index f7b2617..22c3566 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -380,7 +380,8 @@ static const char *hwcaps[] = {
 	 */
 	"mul32", "div32", "fsmuld", "v8plus", "popc", "vis", "vis2",
 	"ASIBlkInit", "fmaf", "vis3", "hpc", "random", "trans", "fjfmau",
-	"ima", "cspare", "pause", "cbcond",
+	"ima", "cspare", "pause", "cbcond", NULL /*reserved for crypto */,
+	"adp",
 };
 
 static const char *crypto_hwcaps[] = {
@@ -396,9 +397,13 @@ void cpucap_info(struct seq_file *m)
 	seq_puts(m, "cpucaps\t\t: ");
 	for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
 		unsigned long bit = 1UL << i;
-		if (caps & bit) {
-			seq_printf(m, "%s%s",
-				   printed ? "," : "", hwcaps[i]);
+		if (hwcaps[i] && (caps & bit)) {
+			if (strcmp(hwcaps[i], "adp") = 0)
+				seq_printf(m, "%sadi",
+					   printed ? "," : "");
+			else
+				seq_printf(m, "%s%s",
+					   printed ? "," : "", hwcaps[i]);
 			printed++;
 		}
 	}
@@ -422,8 +427,10 @@ static void __init report_one_hwcap(int *printed, const char *name)
 {
 	if ((*printed) = 0)
 		printk(KERN_INFO "CPU CAPS: [");
-	printk(KERN_CONT "%s%s",
-	       (*printed) ? "," : "", name);
+	if (strcmp(name, "adp") = 0)
+		pr_cont("%sadi", (*printed) ? "," : "");
+	else
+		pr_cont("%s%s", (*printed) ? "," : "", name);
 	if (++(*printed) = 8) {
 		printk(KERN_CONT "]\n");
 		*printed = 0;
@@ -450,7 +457,7 @@ static void __init report_hwcaps(unsigned long caps)
 
 	for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
 		unsigned long bit = 1UL << i;
-		if (caps & bit)
+		if (hwcaps[i] && (caps & bit))
 			report_one_hwcap(&printed, hwcaps[i]);
 	}
 	if (caps & HWCAP_SPARC_CRYPTO)
@@ -485,7 +492,7 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
 		for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
 			unsigned long bit = 1UL << i;
 
-			if (!strcmp(prop, hwcaps[i])) {
+			if (hwcaps[i] && !strcmp(prop, hwcaps[i])) {
 				caps |= bit;
 				break;
 			}
-- 
2.1.4

