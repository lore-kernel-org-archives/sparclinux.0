From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Mon, 16 Nov 2009 09:51:06 +0000
Subject: [PATCH 1/2] Added sparc_leon3_snooping_enabled() and converted extern inline to static inline
Message-Id: <1258365067-8983-1-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1257172092-25026-1-git-send-email-kristoffer@gaisler.com>
In-Reply-To: <1257172092-25026-1-git-send-email-kristoffer@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

---
 arch/sparc/include/asm/leon.h |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 559448c..3ea5964 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -148,7 +148,7 @@ static inline unsigned long leon_load_reg(unsigned long paddr)
 	return retval;
 }
 
-extern inline void leon_srmmu_disabletlb(void)
+static inline void leon_srmmu_disabletlb(void)
 {
 	unsigned int retval;
 	__asm__ __volatile__("lda [%%g0] %2, %0\n\t" : "=r"(retval) : "r"(0),
@@ -158,7 +158,7 @@ extern inline void leon_srmmu_disabletlb(void)
 			     "i"(ASI_LEON_MMUREGS) : "memory");
 }
 
-extern inline void leon_srmmu_enabletlb(void)
+static inline void leon_srmmu_enabletlb(void)
 {
 	unsigned int retval;
 	__asm__ __volatile__("lda [%%g0] %2, %0\n\t" : "=r"(retval) : "r"(0),
@@ -190,7 +190,7 @@ extern void leon_init_IRQ(void);
 
 extern unsigned long last_valid_pfn;
 
-extern inline unsigned long sparc_leon3_get_dcachecfg(void)
+static inline unsigned long sparc_leon3_get_dcachecfg(void)
 {
 	unsigned int retval;
 	__asm__ __volatile__("lda [%1] %2, %0\n\t" :
@@ -201,7 +201,7 @@ extern inline unsigned long sparc_leon3_get_dcachecfg(void)
 }
 
 /* enable snooping */
-extern inline void sparc_leon3_enable_snooping(void)
+static inline void sparc_leon3_enable_snooping(void)
 {
 	__asm__ __volatile__ ("lda [%%g0] 2, %%l1\n\t"
 			  "set 0x800000, %%l2\n\t"
@@ -209,7 +209,14 @@ extern inline void sparc_leon3_enable_snooping(void)
 			  "sta %%l2, [%%g0] 2\n\t" : : : "l1", "l2");
 };
 
-extern inline void sparc_leon3_disable_cache(void)
+static inline int sparc_leon3_snooping_enabled(void)
+{
+	u32 cctrl;
+	__asm__ __volatile__("lda [%%g0] 2, %0\n\t" : "=r"(cctrl));
+        return (cctrl >> 23) & 1;
+};
+
+static inline void sparc_leon3_disable_cache(void)
 {
 	__asm__ __volatile__ ("lda [%%g0] 2, %%l1\n\t"
 			  "set 0x00000f, %%l2\n\t"
-- 
1.5.2.2

