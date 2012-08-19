From: David Miller <davem@davemloft.net>
Date: Sun, 19 Aug 2012 06:27:23 +0000
Subject: [PATCH 01/17] sparc64: Add detection for features new in SPARC-T4.
Message-Id: <20120818.232723.516412117229390594.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Compare and branch, pause, and the various new cryptographic opcodes.

We advertise the crypto opcodes to userspace using one hwcap bit,
HWCAP_SPARC_CRYPTO.

This essentially indicates that the %cfr register can be interrograted
and used to determine exactly which crypto opcodes are available on
the current cpu.

We use the %cfr register to report all of the crypto opcodes available
in the bootup CPU caps log message, and via /proc/cpuinfo.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/elf_64.h |    9 ++++++
 arch/sparc/include/asm/pstate.h |   14 ++++++++
 arch/sparc/kernel/setup_64.c    |   67 ++++++++++++++++++++++++++++++++-------
 3 files changed, 78 insertions(+), 12 deletions(-)

diff --git a/arch/sparc/include/asm/elf_64.h b/arch/sparc/include/asm/elf_64.h
index 7df8b7f..370ca1e 100644
--- a/arch/sparc/include/asm/elf_64.h
+++ b/arch/sparc/include/asm/elf_64.h
@@ -86,6 +86,15 @@
 #define AV_SPARC_IMA		0x00400000 /* integer multiply-add */
 #define AV_SPARC_ASI_CACHE_SPARING \
 				0x00800000 /* cache sparing ASIs available */
+#define AV_SPARC_PAUSE		0x01000000 /* PAUSE available */
+#define AV_SPARC_CBCOND		0x02000000 /* CBCOND insns available */
+
+/* Solaris decided to enumerate every single crypto instruction type
+ * in the AT_HWCAP bits.  This is wasteful, since if crypto is present,
+ * you still need to look in the CFR register to see if the opcode is
+ * really available.  So we simply advertise only "crypto" support.
+ */
+#define HWCAP_SPARC_CRYPTO	0x04000000 /* CRYPTO insns available */
 
 #define CORE_DUMP_USE_REGSET
 
diff --git a/arch/sparc/include/asm/pstate.h b/arch/sparc/include/asm/pstate.h
index a26a537..6dfa8f8 100644
--- a/arch/sparc/include/asm/pstate.h
+++ b/arch/sparc/include/asm/pstate.h
@@ -88,4 +88,18 @@
 #define VERS_MAXTL	_AC(0x000000000000ff00,UL) /* Max Trap Level.	*/
 #define VERS_MAXWIN	_AC(0x000000000000001f,UL) /* Max RegWindow Idx.*/
 
+/* Compatability Feature Register (%asr26), SPARC-T4 and later  */
+#define CFR_AES		_AC(0x0000000000000001,UL) /* Supports AES opcodes     */
+#define CFR_DES		_AC(0x0000000000000002,UL) /* Supports DES opcodes     */
+#define CFR_KASUMI	_AC(0x0000000000000004,UL) /* Supports KASUMI opcodes  */
+#define CFR_CAMELIA	_AC(0x0000000000000008,UL) /* Supports CAMELIA opcodes */
+#define CFR_MD5		_AC(0x0000000000000010,UL) /* Supports MD5 opcodes     */
+#define CFR_SHA1	_AC(0x0000000000000020,UL) /* Supports SHA1 opcodes    */
+#define CFR_SHA256	_AC(0x0000000000000040,UL) /* Supports SHA256 opcodes  */
+#define CFR_SHA512	_AC(0x0000000000000080,UL) /* Supports SHA512 opcodes  */
+#define CFR_MPMUL	_AC(0x0000000000000100,UL) /* Supports MPMUL opcodes   */
+#define CFR_MONTMUL	_AC(0x0000000000000200,UL) /* Supports MONTMUL opcodes */
+#define CFR_MONTSQR	_AC(0x0000000000000400,UL) /* Supports MONTSQR opcodes */
+#define CFR_CRC32C	_AC(0x0000000000000800,UL) /* Supports CRC32C opcodes  */
+
 #endif /* !(_SPARC64_PSTATE_H) */
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 1414d16..0800e71 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -340,7 +340,12 @@ static const char *hwcaps[] = {
 	 */
 	"mul32", "div32", "fsmuld", "v8plus", "popc", "vis", "vis2",
 	"ASIBlkInit", "fmaf", "vis3", "hpc", "random", "trans", "fjfmau",
-	"ima", "cspare",
+	"ima", "cspare", "pause", "cbcond",
+};
+
+static const char *crypto_hwcaps[] = {
+	"aes", "des", "kasumi", "camellia", "md5", "sha1", "sha256",
+	"sha512", "mpmul", "montmul", "montsqr", "crc32c",
 };
 
 void cpucap_info(struct seq_file *m)
@@ -357,27 +362,61 @@ void cpucap_info(struct seq_file *m)
 			printed++;
 		}
 	}
+	if (caps & HWCAP_SPARC_CRYPTO) {
+		unsigned long cfr;
+
+		__asm__ __volatile__("rd %%asr26, %0" : "=r" (cfr));
+		for (i = 0; i < ARRAY_SIZE(crypto_hwcaps); i++) {
+			unsigned long bit = 1UL << i;
+			if (cfr & bit) {
+				seq_printf(m, "%s%s",
+					   printed ? "," : "", crypto_hwcaps[i]);
+				printed++;
+			}
+		}
+	}
 	seq_putc(m, '\n');
 }
 
+static void __init report_one_hwcap(int *printed, const char *name)
+{
+	if ((*printed) = 0)
+		printk(KERN_INFO "CPU CAPS: [");
+	printk(KERN_CONT "%s%s",
+	       (*printed) ? "," : "", name);
+	if (++(*printed) = 8) {
+		printk(KERN_CONT "]\n");
+		*printed = 0;
+	}
+}
+
+static void __init report_crypto_hwcaps(int *printed)
+{
+	unsigned long cfr;
+	int i;
+
+	__asm__ __volatile__("rd %%asr26, %0" : "=r" (cfr));
+
+	for (i = 0; i < ARRAY_SIZE(crypto_hwcaps); i++) {
+		unsigned long bit = 1UL << i;
+		if (cfr & bit)
+			report_one_hwcap(printed, crypto_hwcaps[i]);
+	}
+}
+
 static void __init report_hwcaps(unsigned long caps)
 {
 	int i, printed = 0;
 
-	printk(KERN_INFO "CPU CAPS: [");
 	for (i = 0; i < ARRAY_SIZE(hwcaps); i++) {
 		unsigned long bit = 1UL << i;
-		if (caps & bit) {
-			printk(KERN_CONT "%s%s",
-			       printed ? "," : "", hwcaps[i]);
-			if (++printed = 8) {
-				printk(KERN_CONT "]\n");
-				printk(KERN_INFO "CPU CAPS: [");
-				printed = 0;
-			}
-		}
+		if (caps & bit)
+			report_one_hwcap(&printed, hwcaps[i]);
 	}
-	printk(KERN_CONT "]\n");
+	if (caps & HWCAP_SPARC_CRYPTO)
+		report_crypto_hwcaps(&printed);
+	if (printed != 0)
+		printk(KERN_CONT "]\n");
 }
 
 static unsigned long __init mdesc_cpu_hwcap_list(void)
@@ -411,6 +450,10 @@ static unsigned long __init mdesc_cpu_hwcap_list(void)
 				break;
 			}
 		}
+		for (i = 0; i < ARRAY_SIZE(crypto_hwcaps); i++) {
+			if (!strcmp(prop, crypto_hwcaps[i]))
+				caps |= HWCAP_SPARC_CRYPTO;
+		}
 
 		plen = strlen(prop) + 1;
 		prop += plen;
-- 
1.7.10.4

