From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 20 May 2012 06:02:46 +0000
Subject: [PATCH 3/8] sparc32,leon: move leon ASI definitions to asi.h
Message-Id: <1337493771-18535-3-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Konrad Eisele <konrad@gaisler.com>
---
 arch/sparc/include/asm/asi.h  |   14 ++++++++++++++
 arch/sparc/include/asm/leon.h |   13 -------------
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/include/asm/asi.h b/arch/sparc/include/asm/asi.h
index b2e3db6..cbb93e5 100644
--- a/arch/sparc/include/asm/asi.h
+++ b/arch/sparc/include/asm/asi.h
@@ -112,6 +112,20 @@
 
 #define ASI_M_ACTION       0x4c   /* Breakpoint Action Register (GNU/Viking) */
 
+/* LEON ASI */
+#define ASI_LEON_NOCACHE        0x01
+
+#define ASI_LEON_DCACHE_MISS    0x01
+
+#define ASI_LEON_CACHEREGS      0x02
+#define ASI_LEON_IFLUSH         0x10
+#define ASI_LEON_DFLUSH         0x11
+
+#define ASI_LEON_MMUFLUSH       0x18
+#define ASI_LEON_MMUREGS        0x19
+#define ASI_LEON_BYPASS         0x1c
+#define ASI_LEON_FLUSH_PAGE     0x10
+
 /* V9 Architecture mandary ASIs. */
 #define ASI_N			0x04 /* Nucleus				*/
 #define ASI_NL			0x0c /* Nucleus, little endian		*/
diff --git a/arch/sparc/include/asm/leon.h b/arch/sparc/include/asm/leon.h
index 8095be2..ce76f40 100644
--- a/arch/sparc/include/asm/leon.h
+++ b/arch/sparc/include/asm/leon.h
@@ -10,19 +10,6 @@
 
 #ifdef CONFIG_SPARC_LEON
 
-#define ASI_LEON_NOCACHE	0x01
-
-#define ASI_LEON_DCACHE_MISS	0x1
-
-#define ASI_LEON_CACHEREGS	0x02
-#define ASI_LEON_IFLUSH		0x10
-#define ASI_LEON_DFLUSH		0x11
-
-#define ASI_LEON_MMUFLUSH	0x18
-#define ASI_LEON_MMUREGS	0x19
-#define ASI_LEON_BYPASS		0x1c
-#define ASI_LEON_FLUSH_PAGE	0x10
-
 /* mmu register access, ASI_LEON_MMUREGS */
 #define LEON_CNR_CTRL		0x000
 #define LEON_CNR_CTXP		0x100
-- 
1.6.0.6

