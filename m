From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 01 Jan 2011 22:53:11 +0000
Subject: [PATCH 4/4] sparc: remove unused prom tree functions
Message-Id: <1293922391-17661-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Remove the following unused funtions:
prom_nodematch()
prom_firstprop()
prom_node_has_property()

Also declare a few local functions static.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/oplib_32.h |   11 ---------
 arch/sparc/prom/tree_32.c         |   44 ++----------------------------------
 2 files changed, 3 insertions(+), 52 deletions(-)

diff --git a/arch/sparc/include/asm/oplib_32.h b/arch/sparc/include/asm/oplib_32.h
index 6405588..98f7082 100644
--- a/arch/sparc/include/asm/oplib_32.h
+++ b/arch/sparc/include/asm/oplib_32.h
@@ -147,19 +147,11 @@ extern int prom_getbool(phandle node, char *prop);
 /* Acquire a string property, null string on error. */
 extern void prom_getstring(phandle node, char *prop, char *buf, int bufsize);
 
-/* Does the passed node have the given "name"? YES=1 NO=0 */
-extern int prom_nodematch(phandle thisnode, char *name);
-
 /* Search all siblings starting at the passed node for "name" matching
  * the given string.  Returns the node on success, zero on failure.
  */
 extern phandle prom_searchsiblings(phandle node_start, char *name);
 
-/* Return the first property type, as a string, for the given node.
- * Returns a null string on error.
- */
-extern char *prom_firstprop(phandle node, char *buffer);
-
 /* Returns the next property after the passed property for the given
  * node.  Returns null string on failure.
  */
@@ -168,9 +160,6 @@ extern char *prom_nextprop(phandle node, char *prev_property, char *buffer);
 /* Returns phandle of the path specified */
 extern phandle prom_finddevice(char *name);
 
-/* Returns 1 if the specified node has given property. */
-extern int prom_node_has_property(phandle node, char *property);
-
 /* Set the indicated property at the given node with the passed value.
  * Returns the number of bytes of your value that the prom took.
  */
diff --git a/arch/sparc/prom/tree_32.c b/arch/sparc/prom/tree_32.c
index 535e2e6..f8860eb 100644
--- a/arch/sparc/prom/tree_32.c
+++ b/arch/sparc/prom/tree_32.c
@@ -20,7 +20,7 @@ extern void restore_current(void);
 static char promlib_buf[128];
 
 /* Internal version of prom_getchild that does not alter return values. */
-phandle __prom_getchild(phandle node)
+static phandle __prom_getchild(phandle node)
 {
 	unsigned long flags;
 	phandle cnode;
@@ -52,7 +52,7 @@ phandle prom_getchild(phandle node)
 EXPORT_SYMBOL(prom_getchild);
 
 /* Internal version of prom_getsibling that does not alter return values. */
-phandle __prom_getsibling(phandle node)
+static phandle __prom_getsibling(phandle node)
 {
 	unsigned long flags;
 	phandle cnode;
@@ -177,20 +177,6 @@ void prom_getstring(phandle node, char *prop, char *user_buf, int ubuf_size)
 EXPORT_SYMBOL(prom_getstring);
 
 
-/* Does the device at node 'node' have name 'name'?
- * YES = 1   NO = 0
- */
-int prom_nodematch(phandle node, char *name)
-{
-	int error;
-
-	static char namebuf[128];
-	error = prom_getproperty(node, "name", namebuf, sizeof(namebuf));
-	if (error = -1) return 0;
-	if(strcmp(namebuf, name) = 0) return 1;
-	return 0;
-}
-
 /* Search siblings at 'node_start' for a node with name
  * 'nodename'.  Return node if successful, zero if not.
  */
@@ -214,7 +200,7 @@ phandle prom_searchsiblings(phandle node_start, char *nodename)
 EXPORT_SYMBOL(prom_searchsiblings);
 
 /* Interal version of nextprop that does not alter return values. */
-char *__prom_nextprop(phandle node, char * oprop)
+static char *__prom_nextprop(phandle node, char * oprop)
 {
 	unsigned long flags;
 	char *prop;
@@ -227,17 +213,6 @@ char *__prom_nextprop(phandle node, char * oprop)
 	return prop;
 }
 
-/* Return the first property name for node 'node'. */
-/* buffer is unused argument, but as v9 uses it, we need to have the same interface */
-char *prom_firstprop(phandle node, char *bufer)
-{
-	if (node = 0 || node = -1)
-		return "";
-
-	return __prom_nextprop(node, "");
-}
-EXPORT_SYMBOL(prom_firstprop);
-
 /* Return the property type string after property type 'oprop'
  * at node 'node' .  Returns empty string if no more
  * property types for this node.
@@ -299,19 +274,6 @@ phandle prom_finddevice(char *name)
 }
 EXPORT_SYMBOL(prom_finddevice);
 
-int prom_node_has_property(phandle node, char *prop)
-{
-	char *current_property = "";
-
-	do {
-		current_property = prom_nextprop(node, current_property, NULL);
-		if(!strcmp(current_property, prop))
-		   return 1;
-	} while (*current_property);
-	return 0;
-}
-EXPORT_SYMBOL(prom_node_has_property);
-
 /* Set property 'pname' at node 'node' to value 'value' which has a length
  * of 'size' bytes.  Return the number of bytes the prom accepted.
  */
-- 
1.6.0.6

