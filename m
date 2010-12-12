From: David Miller <davem@davemloft.net>
Date: Sun, 12 Dec 2010 22:58:10 +0000
Subject: [PATCH] sparc: Eliminate prom_stdin.
Message-Id: <20101212.145810.232741904.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Completely unused.

Based upon a patch by Julian Calaby.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/oplib_64.h |    4 ++--
 arch/sparc/prom/console_64.c      |    2 --
 arch/sparc/prom/init_64.c         |    3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/include/asm/oplib_64.h b/arch/sparc/include/asm/oplib_64.h
index 8cd0df3..97a9047 100644
--- a/arch/sparc/include/asm/oplib_64.h
+++ b/arch/sparc/include/asm/oplib_64.h
@@ -18,8 +18,8 @@ extern char prom_version[];
  */
 extern phandle prom_root_node;
 
-/* PROM stdin and stdout */
-extern int prom_stdin, prom_stdout;
+/* PROM stdout */
+extern int prom_stdout;
 
 /* /chosen node of the prom device tree, this stays constant after
  * initialization is complete.
diff --git a/arch/sparc/prom/console_64.c b/arch/sparc/prom/console_64.c
index ed39e75..9de6c8c 100644
--- a/arch/sparc/prom/console_64.c
+++ b/arch/sparc/prom/console_64.c
@@ -13,8 +13,6 @@
 #include <asm/system.h>
 #include <linux/string.h>
 
-extern int prom_stdin, prom_stdout;
-
 static int __prom_console_write_buf(const char *buf, int len)
 {
 	unsigned long args[7];
diff --git a/arch/sparc/prom/init_64.c b/arch/sparc/prom/init_64.c
index 3ff911e..9c6ac4b 100644
--- a/arch/sparc/prom/init_64.c
+++ b/arch/sparc/prom/init_64.c
@@ -18,7 +18,7 @@
 char prom_version[80];
 
 /* The root node of the prom device tree. */
-int prom_stdin, prom_stdout;
+int prom_stdout;
 phandle prom_chosen_node;
 
 /* You must call prom_init() before you attempt to use any of the
@@ -38,7 +38,6 @@ void __init prom_init(void *cif_handler, void *cif_stack)
 	if (!prom_chosen_node || prom_chosen_node = -1)
 		prom_halt();
 
-	prom_stdin = prom_getint(prom_chosen_node, "stdin");
 	prom_stdout = prom_getint(prom_chosen_node, "stdout");
 
 	node = prom_finddevice("/openprom");
-- 
1.7.3.2

