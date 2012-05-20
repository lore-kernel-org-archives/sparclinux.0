From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 06:02:47 +0000
Subject: [PATCH 4/8] sparc32,leon: remove duplicate UART register definitions
Message-Id: <1337493771-18535-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The registers are defined in leon_amba too.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/include/asm/leon.h |   25 -------------------------
 1 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index ce76f40..7a66bd9 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -44,29 +44,6 @@
 #define LEON_IRQMASK_R		0x0000fffe	/* bit 15- 1 of lregs.irqmask */
 #define LEON_IRQPRIO_R		0xfffe0000	/* bit 31-17 of lregs.irqmask */
 
-/* leon uart register definitions */
-#define LEON_OFF_UDATA	0x0
-#define LEON_OFF_USTAT	0x4
-#define LEON_OFF_UCTRL	0x8
-#define LEON_OFF_USCAL	0xc
-
-#define LEON_UCTRL_RE	0x01
-#define LEON_UCTRL_TE	0x02
-#define LEON_UCTRL_RI	0x04
-#define LEON_UCTRL_TI	0x08
-#define LEON_UCTRL_PS	0x10
-#define LEON_UCTRL_PE	0x20
-#define LEON_UCTRL_FL	0x40
-#define LEON_UCTRL_LB	0x80
-
-#define LEON_USTAT_DR	0x01
-#define LEON_USTAT_TS	0x02
-#define LEON_USTAT_TH	0x04
-#define LEON_USTAT_BR	0x08
-#define LEON_USTAT_OV	0x10
-#define LEON_USTAT_PE	0x20
-#define LEON_USTAT_FE	0x40
-
 #define LEON_MCFG2_SRAMDIS		0x00002000
 #define LEON_MCFG2_SDRAMEN		0x00004000
 #define LEON_MCFG2_SRAMBANKSZ		0x00001e00	/* [12-9] */
@@ -76,8 +53,6 @@
 
 #define LEON_TCNT0_MASK	0x7fffff
 
-#define LEON_USTAT_ERROR (LEON_USTAT_OV | LEON_USTAT_PE | LEON_USTAT_FE)
-/* no break yet */
 
 #define ASI_LEON3_SYSCTRL		0x02
 #define ASI_LEON3_SYSCTRL_ICFG		0x08
-- 
1.6.0.6

