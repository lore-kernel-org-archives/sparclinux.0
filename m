From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 06 Jan 2009 14:58:46 +0000
Subject: [PATCH 4/5] sparc: Kill exports of prom internal functions
Message-Id: <496371A6.3080000@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc: Kill exports of prom internal functions

__prom_getchild() and __prom_getsibling() are unused anywhere, so don't
export them.

Signed-off-by: Julian Calaby <julian.calaby@gmail.com>

---
  arch/sparc/include/asm/oplib_32.h |   11 -----------
  arch/sparc/include/asm/oplib_64.h |   10 ----------
  arch/sparc/prom/tree_32.c         |    2 --
  arch/sparc/prom/tree_64.c         |    2 --
  4 files changed, 0 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/include/asm/oplib_32.h
b/arch/sparc/include/asm/oplib_32.h
index 73d4552..33e31ce 100644
--- a/arch/sparc/include/asm/oplib_32.h
+++ b/arch/sparc/include/asm/oplib_32.h
@@ -177,17 +177,6 @@ extern void prom_putsegment(int context, unsigned
long virt_addr,

  /* PROM device tree traversal functions... */

-#ifdef PROMLIB_INTERNAL
-
-/* Internal version of prom_getchild. */
-extern int __prom_getchild(int parent_node);
-
-/* Internal version of prom_getsibling. */
-extern int __prom_getsibling(int node);
-
-#endif
-
-
  /* Get the child node of the given node, or zero if no child exists. */
  extern int prom_getchild(int parent_node);

diff --git a/arch/sparc/include/asm/oplib_64.h
b/arch/sparc/include/asm/oplib_64.h
index 6d2c2ca..a5db031 100644
--- a/arch/sparc/include/asm/oplib_64.h
+++ b/arch/sparc/include/asm/oplib_64.h
@@ -218,16 +218,6 @@ extern void prom_unmap(unsigned long size, unsigned
long vaddr);

  /* PROM device tree traversal functions... */

-#ifdef PROMLIB_INTERNAL
-
-/* Internal version of prom_getchild. */
-extern int __prom_getchild(int parent_node);
-
-/* Internal version of prom_getsibling. */
-extern int __prom_getsibling(int node);
-
-#endif
-
  /* Get the child node of the given node, or zero if no child exists. */
  extern int prom_getchild(int parent_node);

diff --git a/arch/sparc/prom/tree_32.c b/arch/sparc/prom/tree_32.c
index 7416827..f3e5ac0 100644
--- a/arch/sparc/prom/tree_32.c
+++ b/arch/sparc/prom/tree_32.c
@@ -33,7 +33,6 @@ int __prom_getchild(int node)

  	return cnode;
  }
-EXPORT_SYMBOL(__prom_getchild);

  /* Return the child of node 'node' or zero if no this node has no
   * direct descendent.
@@ -66,7 +65,6 @@ int __prom_getsibling(int node)

  	return cnode;
  }
-EXPORT_SYMBOL(__prom_getsibling);

  /* Return the next sibling of node 'node' or zero if no more siblings
   * at this level of depth in the tree.
diff --git a/arch/sparc/prom/tree_64.c b/arch/sparc/prom/tree_64.c
index 175c709..8ea73dd 100644
--- a/arch/sparc/prom/tree_64.c
+++ b/arch/sparc/prom/tree_64.c
@@ -23,7 +23,6 @@ inline int __prom_getchild(int node)
  {
  	return p1275_cmd ("child", P1275_INOUT(1, 1), node);
  }
-EXPORT_SYMBOL(__prom_getchild);

  inline int prom_getchild(int node)
  {
@@ -53,7 +52,6 @@ inline int __prom_getsibling(int node)
  {
  	return p1275_cmd(prom_peer_name, P1275_INOUT(1, 1), node);
  }
-EXPORT_SYMBOL(__prom_getsibling);

  inline int prom_getsibling(int node)
  {
