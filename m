From: konrad@gaisler.com
Date: Fri, 12 Jun 2009 08:43:51 +0000
Subject: round2 [PATCH 2/6] Redefine MMU register access asi if CONFIG_LEON
Message-Id: <1244796231-7278-1-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>

---
 arch/sparc/include/asm/asi.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/asi.h b/arch/sparc/include/asm/asi.h
index 74703c5..b2e3db6 100644
--- a/arch/sparc/include/asm/asi.h
+++ b/arch/sparc/include/asm/asi.h
@@ -40,7 +40,11 @@
 #define ASI_M_UNA01         0x01   /* Same here... */
 #define ASI_M_MXCC          0x02   /* Access to TI VIKING MXCC registers */
 #define ASI_M_FLUSH_PROBE   0x03   /* Reference MMU Flush/Probe; rw, ss */
+#ifndef CONFIG_SPARC_LEON
 #define ASI_M_MMUREGS       0x04   /* MMU Registers; rw, ss */
+#else
+#define ASI_M_MMUREGS       0x19
+#endif /* CONFIG_SPARC_LEON */
 #define ASI_M_TLBDIAG       0x05   /* MMU TLB only Diagnostics */
 #define ASI_M_DIAGS         0x06   /* Reference MMU Diagnostics */
 #define ASI_M_IODIAG        0x07   /* MMU I/O TLB only Diagnostics */
-- 
1.6.3.2

