From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 06 Jan 2009 15:43:22 +0000
Subject: [PATCH] sparc: Add includes missing from sparc_ksyms_*.c minimisation
Message-Id: <49637C1A.7080307@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc: Add includes missing from sparc_ksyms_*.c minimisation

And fix a typo.

Signed-off-by: Julian Calaby <julian.calaby@gmail.com>

---

And of course, these little bits managed to slip through my build tests.

(You're saying: with a bug like the one in tree_32.c, how the hell can 
he claim build tests? Well I thought they were sparc32, but they were 
sparc64 thanks to the recent Kconfig change)

So, after I'm all done and dusted, I kick off my randconfig runs and the 
first one, the *first* *damn* *one* fails with these issues.

Thanks,

Julian Calaby

---
  arch/sparc/kernel/idprom.c |    1 +
  arch/sparc/prom/init_32.c  |    1 +
  arch/sparc/prom/misc_32.c  |    2 ++
  arch/sparc/prom/ranges.c   |    2 ++
  arch/sparc/prom/tree_32.c  |    3 ++-
  5 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/idprom.c b/arch/sparc/kernel/idprom.c
index 19ec377..57922f6 100644
--- a/arch/sparc/kernel/idprom.c
+++ b/arch/sparc/kernel/idprom.c
@@ -8,6 +8,7 @@
  #include <linux/kernel.h>
  #include <linux/types.h>
  #include <linux/init.h>
+#include <linux/module.h>

  #include <asm/oplib.h>
  #include <asm/idprom.h>
diff --git a/arch/sparc/prom/init_32.c b/arch/sparc/prom/init_32.c
index 14409a9..6193c33 100644
--- a/arch/sparc/prom/init_32.c
+++ b/arch/sparc/prom/init_32.c
@@ -8,6 +8,7 @@

  #include <linux/kernel.h>
  #include <linux/init.h>
+#include <linux/module.h>

  #include <asm/openprom.h>
  #include <asm/oplib.h>
diff --git a/arch/sparc/prom/misc_32.c b/arch/sparc/prom/misc_32.c
index 06b0936..4d61c54 100644
--- a/arch/sparc/prom/misc_32.c
+++ b/arch/sparc/prom/misc_32.c
@@ -8,6 +8,8 @@
  #include <linux/types.h>
  #include <linux/kernel.h>
  #include <linux/sched.h>
+#include <linux/module.h>
+
  #include <asm/openprom.h>
  #include <asm/oplib.h>
  #include <asm/auxio.h>
diff --git a/arch/sparc/prom/ranges.c b/arch/sparc/prom/ranges.c
index 6f30431..cd57908 100644
--- a/arch/sparc/prom/ranges.c
+++ b/arch/sparc/prom/ranges.c
@@ -6,6 +6,8 @@
   */

  #include <linux/init.h>
+#include <linux/module.h>
+
  #include <asm/openprom.h>
  #include <asm/oplib.h>
  #include <asm/types.h>
diff --git a/arch/sparc/prom/tree_32.c b/arch/sparc/prom/tree_32.c
index 65cbed4..646d244 100644
--- a/arch/sparc/prom/tree_32.c
+++ b/arch/sparc/prom/tree_32.c
@@ -10,6 +10,7 @@
  #include <linux/kernel.h>
  #include <linux/sched.h>
  #include <linux/ctype.h>
+#include <linux/module.h>

  #include <asm/openprom.h>
  #include <asm/oplib.h>
@@ -210,7 +211,7 @@ int prom_searchsiblings(int node_start, char *nodename)

  	return 0;
  }
-EXPORT_SYMBOL(prom_searchsiblinbs);
+EXPORT_SYMBOL(prom_searchsiblings);

  /* Interal version of nextprop that does not alter return values. */
  char * __prom_nextprop(int node, char * oprop)
-- 
1.5.6.5

