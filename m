From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 Jun 2012 16:58:06 +0000
Subject: [PATCH 1/2] sparc: Correct comments about prom_init() return values
Message-Id: <1340211487-24534-1-git-send-email-geert@linux-m68k.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

prom_init() returns void.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/sparc/prom/init_32.c |    4 ++--
 arch/sparc/prom/init_64.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/prom/init_32.c b/arch/sparc/prom/init_32.c
index 26c64ce..a8d9342 100644
--- a/arch/sparc/prom/init_32.c
+++ b/arch/sparc/prom/init_32.c
@@ -27,8 +27,8 @@ EXPORT_SYMBOL(prom_root_node);
 struct linux_nodeops *prom_nodeops;
 
 /* You must call prom_init() before you attempt to use any of the
- * routines in the prom library.  It returns 0 on success, 1 on
- * failure.  It gets passed the pointer to the PROM vector.
+ * routines in the prom library.
+ * It gets passed the pointer to the PROM vector.
  */
 
 extern void prom_meminit(void);
diff --git a/arch/sparc/prom/init_64.c b/arch/sparc/prom/init_64.c
index 5016c5e..d95db75 100644
--- a/arch/sparc/prom/init_64.c
+++ b/arch/sparc/prom/init_64.c
@@ -22,8 +22,8 @@ int prom_stdout;
 phandle prom_chosen_node;
 
 /* You must call prom_init() before you attempt to use any of the
- * routines in the prom library.  It returns 0 on success, 1 on
- * failure.  It gets passed the pointer to the PROM vector.
+ * routines in the prom library.
+ * It gets passed the pointer to the PROM vector.
  */
 
 extern void prom_cif_init(void *, void *);
-- 
1.7.0.4

