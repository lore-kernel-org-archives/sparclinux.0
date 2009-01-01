From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 01 Jan 2009 20:03:08 +0000
Subject: [PATCH 5/7] sparc: prepare openprom for unification
Message-Id: <1230840190-31884-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Align the sparc and sparc64 versions so differences are minimal.
A few data types are changed to better reflect there actual usage.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/openprom_32.h |    8 ++++----
 arch/sparc/include/asm/openprom_64.h |   14 +++++++-------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/arch/sparc/include/asm/openprom_32.h b/arch/sparc/include/asm/openprom_32.h
index f8b4bf7..2e58db5 100644
--- a/arch/sparc/include/asm/openprom_32.h
+++ b/arch/sparc/include/asm/openprom_32.h
@@ -47,7 +47,7 @@ struct linux_dev_v2_funcs {
 
 struct linux_mlist_v0 {
 	struct linux_mlist_v0 *theres_more;
-	char *start_adr;
+	unsigned int start_adr;
 	unsigned num_bytes;
 };
 
@@ -182,9 +182,9 @@ struct linux_nodeops {
 #define PROMINTR_MAX    15
 
 struct linux_prom_registers {
-	unsigned int which_io;         /* is this in OBIO space? */
-	unsigned int phys_addr;        /* The physical address of this register */
-	unsigned int reg_size;         /* How many bytes does this register take up? */
+	unsigned int which_io;	/* is this in OBIO space? */
+	unsigned int phys_addr;	/* The physical address of this register */
+	unsigned int reg_size;	/* How many bytes does this register take up? */
 };
 
 struct linux_prom_irqs {
diff --git a/arch/sparc/include/asm/openprom_64.h b/arch/sparc/include/asm/openprom_64.h
index 955d7f6..db3711e 100644
--- a/arch/sparc/include/asm/openprom_64.h
+++ b/arch/sparc/include/asm/openprom_64.h
@@ -44,7 +44,7 @@ struct linux_dev_v2_funcs {
 
 struct linux_mlist_v0 {
 	struct linux_mlist_v0 *theres_more;
-	unsigned start_adr;
+	unsigned int start_adr;
 	unsigned num_bytes;
 };
 
@@ -167,9 +167,9 @@ struct linux_romvec {
 struct linux_nodeops {
 	int (*no_nextnode)(int node);
 	int (*no_child)(int node);
-	int (*no_proplen)(int node, char *name);
-	int (*no_getprop)(int node, char *name, char *val);
-	int (*no_setprop)(int node, char *name, char *val, int len);
+	int (*no_proplen)(int node, const char *name);
+	int (*no_getprop)(int node, const char *name, char *val);
+	int (*no_setprop)(int node, const char *name, char *val, int len);
 	char * (*no_nextprop)(int node, char *name);
 };
 
@@ -179,9 +179,9 @@ struct linux_nodeops {
 #define PROMINTR_MAX    32
 
 struct linux_prom_registers {
-	unsigned which_io;	/* hi part of physical address			*/
-	unsigned phys_addr;	/* The physical address of this register	*/
-	int reg_size;		/* How many bytes does this register take up?	*/
+	unsigned int which_io;	/* hi part of physical address */
+	unsigned int phys_addr;	/* The physical address of this register */
+	unsigned int reg_size;	/* How many bytes does this register take up? */
 };
 
 struct linux_prom64_registers {
-- 
1.6.0.2.GIT

