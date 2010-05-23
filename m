From: Andrea Gelmini <andrea.gelmini@gelma.net>
Date: Sun, 23 May 2010 20:02:07 +0000
Subject: [PATCH 180/199] arch/sparc/kernel/tadpole.c: Checkpatch cleanup
Message-Id: <1274644930-26600-23-git-send-email-andrea.gelmini@gelma.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

arch/sparc/kernel/tadpole.c:26: ERROR: trailing whitespace
arch/sparc/kernel/tadpole.c:27: ERROR: trailing whitespace
arch/sparc/kernel/tadpole.c:105: ERROR: trailing whitespace
arch/sparc/kernel/tadpole.c:123: ERROR: space required after that ',' (ctx:VxV)
arch/sparc/kernel/tadpole.c:125: ERROR: space required after that ',' (ctx:VxV)

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/sparc/kernel/tadpole.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/tadpole.c b/arch/sparc/kernel/tadpole.c
index f476a5f..fbc58e3 100644
--- a/arch/sparc/kernel/tadpole.c
+++ b/arch/sparc/kernel/tadpole.c
@@ -23,8 +23,8 @@ void (*cpu_pwr_save)(void);
 static inline unsigned int ldphys(unsigned int addr)
 {
 	unsigned long data;
-    
-	__asm__ __volatile__("\n\tlda [%1] %2, %0\n\t" : 
+
+	__asm__ __volatile__("\n\tlda [%1] %2, %0\n\t" :
 			     "=r" (data) :
 			     "r" (addr), "i" (ASI_M_BYPASS));
 	return data;
@@ -102,7 +102,7 @@ void __init clock_stop_probe(void)
 {
 	unsigned int node, clk_nd;
 	char name[20];
-    
+
 	prom_getstring(prom_root_node, "name", name, sizeof(name));
 	if (strncmp(name, "Tadpole", 7))
 		return;
@@ -120,7 +120,7 @@ void __init clock_stop_probe(void)
 		printk("enabled (S3)\n");
 	} else if ((name[10] = 'X') || (name[10] = 'G')) {
 		cpu_pwr_save = swift_clockstop;
-		printk("enabled (%s)\n",name+7);
+		printk("enabled (%s)\n", name+7);
 	} else
-		printk("disabled %s\n",name+7);
+		printk("disabled %s\n", name+7);
 }
-- 
1.7.1.251.gf80a2

