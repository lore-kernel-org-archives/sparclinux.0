From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 26 May 2012 07:20:18 +0000
Subject: [PATCH 14/15] sparc32: drop LEON hack for ASI_M_MMUREGS
Message-Id: <1338016819-22245-14-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

All users of MMUREGS ASI is now LEON/SUN aware,
so this is no longer required.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/include/asm/asi.h |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/asi.h b/arch/sparc/include/asm/asi.h
index cbb93e5..61ebe74 100644
--- a/arch/sparc/include/asm/asi.h
+++ b/arch/sparc/include/asm/asi.h
@@ -40,11 +40,7 @@
 #define ASI_M_UNA01         0x01   /* Same here... */
 #define ASI_M_MXCC          0x02   /* Access to TI VIKING MXCC registers */
 #define ASI_M_FLUSH_PROBE   0x03   /* Reference MMU Flush/Probe; rw, ss */
-#ifndef CONFIG_SPARC_LEON
 #define ASI_M_MMUREGS       0x04   /* MMU Registers; rw, ss */
-#else
-#define ASI_M_MMUREGS       0x19
-#endif /* CONFIG_SPARC_LEON */
 #define ASI_M_TLBDIAG       0x05   /* MMU TLB only Diagnostics */
 #define ASI_M_DIAGS         0x06   /* Reference MMU Diagnostics */
 #define ASI_M_IODIAG        0x07   /* MMU I/O TLB only Diagnostics */
-- 
1.6.0.6

