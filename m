From: David Miller <davem@davemloft.net>
Date: Sat, 06 Dec 2008 03:05:03 +0000
Subject: [PATCH 2/14]: sparc: Const'ify prom_*prop*() on sparc32.
Message-Id: <20081205.190503.89290225.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


sparc: Const'ify prom_*prop*() on sparc32.

This brings things in line with sparc64.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/openprom_32.h |    6 +++---
 arch/sparc/include/asm/oplib_32.h    |    6 +++---
 arch/sparc/prom/tree_32.c            |    6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/sparc/include/asm/openprom_32.h b/arch/sparc/include/asm/openprom_32.h
index 8b1649f..875da35 100644
--- a/arch/sparc/include/asm/openprom_32.h
+++ b/arch/sparc/include/asm/openprom_32.h
@@ -170,9 +170,9 @@ struct linux_romvec {
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
 
diff --git a/arch/sparc/include/asm/oplib_32.h b/arch/sparc/include/asm/oplib_32.h
index 699da05..3bdf56f 100644
--- a/arch/sparc/include/asm/oplib_32.h
+++ b/arch/sparc/include/asm/oplib_32.h
@@ -199,12 +199,12 @@ extern int prom_getsibling(int node);
 /* Get the length, at the passed node, of the given property type.
  * Returns -1 on error (ie. no such property at this node).
  */
-extern int prom_getproplen(int thisnode, char *property);
+extern int prom_getproplen(int thisnode, const char *property);
 
 /* Fetch the requested property using the given buffer.  Returns
  * the number of bytes the prom put into your buffer or -1 on error.
  */
-extern int __must_check prom_getproperty(int thisnode, char *property,
+extern int __must_check prom_getproperty(int thisnode, const char *property,
 					 char *prop_buffer, int propbuf_size);
 
 /* Acquire an integer property. */
@@ -246,7 +246,7 @@ extern int prom_node_has_property(int node, char *property);
 /* Set the indicated property at the given node with the passed value.
  * Returns the number of bytes of your value that the prom took.
  */
-extern int prom_setprop(int node, char *prop_name, char *prop_value,
+extern int prom_setprop(int node, const char *prop_name, char *prop_value,
 			int value_size);
 
 extern int prom_pathtoinode(char *path);
diff --git a/arch/sparc/prom/tree_32.c b/arch/sparc/prom/tree_32.c
index f228fe0..6d81873 100644
--- a/arch/sparc/prom/tree_32.c
+++ b/arch/sparc/prom/tree_32.c
@@ -85,7 +85,7 @@ int prom_getsibling(int node)
 /* Return the length in bytes of property 'prop' at node 'node'.
  * Return -1 on error.
  */
-int prom_getproplen(int node, char *prop)
+int prom_getproplen(int node, const char *prop)
 {
 	int ret;
 	unsigned long flags;
@@ -104,7 +104,7 @@ int prom_getproplen(int node, char *prop)
  * 'buffer' which has a size of 'bufsize'.  If the acquisition
  * was successful the length will be returned, else -1 is returned.
  */
-int prom_getproperty(int node, char *prop, char *buffer, int bufsize)
+int prom_getproperty(int node, const char *prop, char *buffer, int bufsize)
 {
 	int plen, ret;
 	unsigned long flags;
@@ -303,7 +303,7 @@ int prom_node_has_property(int node, char *prop)
 /* Set property 'pname' at node 'node' to value 'value' which has a length
  * of 'size' bytes.  Return the number of bytes the prom accepted.
  */
-int prom_setprop(int node, char *pname, char *value, int size)
+int prom_setprop(int node, const char *pname, char *value, int size)
 {
 	unsigned long flags;
 	int ret;
-- 
1.5.6.5

