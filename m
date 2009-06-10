From: konrad@gaisler.com
Date: Wed, 10 Jun 2009 10:11:14 +0000
Subject: [PATCH 2/7] Redefine MMU register access asi if CONFIG_LEON
Message-Id: <1244628674-23822-1-git-send-email-konrad@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
References: <4A2E45D8.7080609@gaisler.com>
In-Reply-To: <4A2E45D8.7080609@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Konrad Eisele <konrad@gaisler.com>

> Would it not be better to put the ifdefs around the original
> definition of ASI_M_MMUREGS?

Done


is defined
---
 arch/sparc/include/asm/asi.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/asi.h b/arch/sparc/include/asm/asi.h
index 74703c5..b2e3db6 100644
--- a/arch/sparc/include/asm/asi.h
+++ b/arch/sparc/include/asm/asi.h
@@ -40,7 +40,11 @@ #define ASI_M_RES00         0x00   /* Do
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
1.4.2.1

