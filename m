From: David Miller <davem@davemloft.net>
Date: Fri, 03 Dec 2010 18:40:49 +0000
Subject: [PATCH 2/9] sparc: Remove prom_pathtoinode()
Message-Id: <20101203.104049.212676352.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Unused.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/oplib_32.h |    1 -
 arch/sparc/include/asm/oplib_64.h |    1 -
 arch/sparc/prom/tree_32.c         |   16 ----------------
 arch/sparc/prom/tree_64.c         |   18 ------------------
 4 files changed, 0 insertions(+), 36 deletions(-)

diff --git a/arch/sparc/include/asm/oplib_32.h b/arch/sparc/include/asm/oplib_32.h
index 51296a6..b0f79be 100644
--- a/arch/sparc/include/asm/oplib_32.h
+++ b/arch/sparc/include/asm/oplib_32.h
@@ -238,7 +238,6 @@ extern int prom_node_has_property(phandle node, char *property);
 extern int prom_setprop(phandle node, const char *prop_name, char *prop_value,
 			int value_size);
 
-extern phandle prom_pathtoinode(char *path);
 extern phandle prom_inst2pkg(int);
 
 /* Dorking with Bus ranges... */
diff --git a/arch/sparc/include/asm/oplib_64.h b/arch/sparc/include/asm/oplib_64.h
index c9cc078..9b01a4b 100644
--- a/arch/sparc/include/asm/oplib_64.h
+++ b/arch/sparc/include/asm/oplib_64.h
@@ -279,7 +279,6 @@ extern phandle prom_finddevice(const char *name);
 extern int prom_setprop(phandle node, const char *prop_name, char *prop_value,
 			int value_size);
 
-extern phandle prom_pathtoinode(const char *path);
 extern phandle prom_inst2pkg(int);
 extern int prom_service_exists(const char *service_name);
 extern void prom_sun4v_guest_soft_state(void);
diff --git a/arch/sparc/prom/tree_32.c b/arch/sparc/prom/tree_32.c
index 63e08e1..535e2e6 100644
--- a/arch/sparc/prom/tree_32.c
+++ b/arch/sparc/prom/tree_32.c
@@ -342,19 +342,3 @@ phandle prom_inst2pkg(int inst)
 	if (node = -1) return 0;
 	return node;
 }
-
-/* Return 'node' assigned to a particular prom 'path'
- * FIXME: Should work for v0 as well
- */
-phandle prom_pathtoinode(char *path)
-{
-	phandle node;
-	int inst;
-	
-	inst = prom_devopen (path);
-	if (inst = -1) return 0;
-	node = prom_inst2pkg (inst);
-	prom_devclose (inst);
-	if (node = -1) return 0;
-	return node;
-}
diff --git a/arch/sparc/prom/tree_64.c b/arch/sparc/prom/tree_64.c
index 691be68..d936600 100644
--- a/arch/sparc/prom/tree_64.c
+++ b/arch/sparc/prom/tree_64.c
@@ -374,24 +374,6 @@ inline phandle prom_inst2pkg(int inst)
 	return node;
 }
 
-/* Return 'node' assigned to a particular prom 'path'
- * FIXME: Should work for v0 as well
- */
-phandle prom_pathtoinode(const char *path)
-{
-	phandle node;
-	int inst;
-
-	inst = prom_devopen (path);
-	if (inst = 0)
-		return 0;
-	node = prom_inst2pkg(inst);
-	prom_devclose(inst);
-	if (node = -1)
-		return 0;
-	return node;
-}
-
 int prom_ihandle2path(int handle, char *buffer, int bufsize)
 {
 	unsigned long args[7];
-- 
1.7.3.2

