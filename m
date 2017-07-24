From: Allen Pais <allen.pais@oracle.com>
Date: Mon, 24 Jul 2017 06:26:17 +0000
Subject: [PATCH v2 1/3] sparc64: properly name the cpu constants
Message-Id: <1500876859-8398-1-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Acked-by: Sam Ravnborg <sam@ravnborg.org>
Acked-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 arch/sparc/include/asm/spitfire.h | 14 ++++++++++++++
 arch/sparc/kernel/head_64.S       | 16 ++++++++--------
 2 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/include/asm/spitfire.h b/arch/sparc/include/asm/spitfire.h
index 1d8321c..9cc2afe 100644
--- a/arch/sparc/include/asm/spitfire.h
+++ b/arch/sparc/include/asm/spitfire.h
@@ -51,6 +51,20 @@
 #define SUN4V_CHIP_SPARC_SN	0x8b
 #define SUN4V_CHIP_UNKNOWN	0xff
 
+/*
+ * The following CPU_ID_xxx constants are used
+ * to identify the CPU type in the setup phase
+ * (see head_64.S)
+ */
+#define CPU_ID_NIAGARA1		('1')
+#define CPU_ID_NIAGARA2		('2')
+#define CPU_ID_NIAGARA3		('3')
+#define CPU_ID_NIAGARA4		('4')
+#define CPU_ID_NIAGARA5		('5')
+#define CPU_ID_M6		('6')
+#define CPU_ID_M7		('7')
+#define CPU_ID_SONOMA1		('N')
+
 #ifndef __ASSEMBLY__
 
 enum ultra_tlb_layout {
diff --git a/arch/sparc/kernel/head_64.S b/arch/sparc/kernel/head_64.S
index 41a4073..ddb5e24 100644
--- a/arch/sparc/kernel/head_64.S
+++ b/arch/sparc/kernel/head_64.S
@@ -424,22 +424,22 @@ EXPORT_SYMBOL(sun4v_chip_type)
 	 nop
 
 70:	ldub	[%g1 + 7], %g2
-	cmp	%g2, '3'
+	cmp	%g2, CPU_ID_NIAGARA3
 	be,pt	%xcc, 5f
 	 mov	SUN4V_CHIP_NIAGARA3, %g4
-	cmp	%g2, '4'
+	cmp	%g2, CPU_ID_NIAGARA4
 	be,pt	%xcc, 5f
 	 mov	SUN4V_CHIP_NIAGARA4, %g4
-	cmp	%g2, '5'
+	cmp	%g2, CPU_ID_NIAGARA5
 	be,pt	%xcc, 5f
 	 mov	SUN4V_CHIP_NIAGARA5, %g4
-	cmp	%g2, '6'
+	cmp	%g2, CPU_ID_M6
 	be,pt	%xcc, 5f
 	 mov	SUN4V_CHIP_SPARC_M6, %g4
-	cmp	%g2, '7'
+	cmp	%g2, CPU_ID_M7
 	be,pt	%xcc, 5f
 	 mov	SUN4V_CHIP_SPARC_M7, %g4
-	cmp	%g2, 'N'
+	cmp	%g2, CPU_ID_SONOMA1
 	be,pt	%xcc, 5f
 	 mov	SUN4V_CHIP_SPARC_SN, %g4
 	ba,pt	%xcc, 49f
@@ -448,10 +448,10 @@ EXPORT_SYMBOL(sun4v_chip_type)
 91:	sethi	%hi(prom_cpu_compatible), %g1
 	or	%g1, %lo(prom_cpu_compatible), %g1
 	ldub	[%g1 + 17], %g2
-	cmp	%g2, '1'
+	cmp	%g2, CPU_ID_NIAGARA1
 	be,pt	%xcc, 5f
 	 mov	SUN4V_CHIP_NIAGARA1, %g4
-	cmp	%g2, '2'
+	cmp	%g2, CPU_ID_NIAGARA2
 	be,pt	%xcc, 5f
 	 mov	SUN4V_CHIP_NIAGARA2, %g4
 	
-- 
1.9.1

