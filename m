From: Julian Calaby <julian.calaby@gmail.com>
Date: Tue, 06 Jan 2009 14:58:56 +0000
Subject: [PATCH 5/5] sparc: Eliminate PROMLIB_INTERNAL as it does nothing
Message-Id: <496371B0.2070107@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sparc: Eliminate PROMLIB_INTERNAL as it does nothing

Signed-off-by: Julian Calaby <julian.calaby@gmail.com>
---
  arch/sparc/kernel/sparc_ksyms_32.c |    2 --
  arch/sparc/kernel/sparc_ksyms_64.c |    2 --
  arch/sparc/prom/tree_32.c          |    2 --
  3 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/sparc_ksyms_32.c
b/arch/sparc/kernel/sparc_ksyms_32.c
index 8397871..baeab87 100644
--- a/arch/sparc/kernel/sparc_ksyms_32.c
+++ b/arch/sparc/kernel/sparc_ksyms_32.c
@@ -5,8 +5,6 @@
   * Copyright (C) 1996 Eddie C. Dost (ecd@skynet.be)
   */

-#define PROMLIB_INTERNAL
-
  #include <linux/module.h>
  #include <linux/init.h>

diff --git a/arch/sparc/kernel/sparc_ksyms_64.c
b/arch/sparc/kernel/sparc_ksyms_64.c
index e92ad12..da8f804 100644
--- a/arch/sparc/kernel/sparc_ksyms_64.c
+++ b/arch/sparc/kernel/sparc_ksyms_64.c
@@ -5,8 +5,6 @@
   * Copyright (C) 1999 Jakub Jelinek (jj@ultra.linux.cz)
   */

-#define PROMLIB_INTERNAL
-
  #include <linux/module.h>
  #include <linux/pci.h>
  #include <linux/init.h>
diff --git a/arch/sparc/prom/tree_32.c b/arch/sparc/prom/tree_32.c
index f3e5ac0..65cbed4 100644
--- a/arch/sparc/prom/tree_32.c
+++ b/arch/sparc/prom/tree_32.c
@@ -5,8 +5,6 @@
   * Copyright (C) 1995 David S. Miller (davem@caip.rutgers.edu)
   */

-#define PROMLIB_INTERNAL
-
  #include <linux/string.h>
  #include <linux/types.h>
  #include <linux/kernel.h>
