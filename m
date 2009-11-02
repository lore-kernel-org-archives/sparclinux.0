From: Kristoffer Glembo <kristoffer@gaisler.com>
Date: Mon, 02 Nov 2009 14:28:11 +0000
Subject: [PATCH 1/2] Added sparc_leon3_snooping_enabled()
Message-Id: <1257172092-25026-1-git-send-email-kristoffer@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Added a function for checking if snooping is enabled.

Best regards,
Kristoffer Glembo


---
 arch/sparc/include/asm/leon.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 28a42b7..9f4ff4e 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -209,6 +209,13 @@ extern inline void sparc_leon3_enable_snooping(void)
 			  "sta %%l2, [%%g0] 2\n\t" : : : "l1", "l2");
 };
 
+extern inline int sparc_leon3_snooping_enabled(void)
+{
+	u32 cctrl;
+	__asm__ __volatile__("lda [%%g0] 2, %0\n\t" : "=r"(cctrl));
+        return (cctrl >> 23) & 1;
+};
+
 extern inline void sparc_leon3_disable_cache(void)
 {
 	__asm__ __volatile__ ("lda [%%g0] 2, %%l1\n\t"
-- 
1.5.2.2

