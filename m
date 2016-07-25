From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 25 Jul 2016 03:42:39 +0000
Subject: [PATCH 06/14] sparc: migrate exception table users off module.h and onto extable.h
Message-Id: <20160725034247.109173-7-paul.gortmaker@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20160725034247.109173-1-paul.gortmaker@windriver.com>
In-Reply-To: <20160725034247.109173-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

These files were only including module.h for exception table
related functions.  We've now separated that content out into its
own file "extable.h" so now move over to that and avoid all the
extra header content in module.h that we don't really need to compile
these files.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/sparc/kernel/kprobes.c      | 2 +-
 arch/sparc/kernel/traps_64.c     | 2 +-
 arch/sparc/kernel/unaligned_64.c | 2 +-
 arch/sparc/mm/fault_64.c         | 2 +-
 arch/sparc/mm/init_64.c          | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index cd83be527586..b0377db12d83 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -5,7 +5,7 @@
 
 #include <linux/kernel.h>
 #include <linux/kprobes.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/kdebug.h>
 #include <linux/slab.h>
 #include <linux/context_tracking.h>
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index d21cd625c0de..4094a51b1970 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -8,7 +8,7 @@
  * I like traps on v9, :))))
  */
 
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/sched.h>
 #include <linux/linkage.h>
 #include <linux/kernel.h>
diff --git a/arch/sparc/kernel/unaligned_64.c b/arch/sparc/kernel/unaligned_64.c
index 9aacb9159262..52c00d90d4b4 100644
--- a/arch/sparc/kernel/unaligned_64.c
+++ b/arch/sparc/kernel/unaligned_64.c
@@ -11,7 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/mm.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <asm/asi.h>
 #include <asm/ptrace.h>
 #include <asm/pstate.h>
diff --git a/arch/sparc/mm/fault_64.c b/arch/sparc/mm/fault_64.c
index 6c43b924a7a2..0e9773ca7ff1 100644
--- a/arch/sparc/mm/fault_64.c
+++ b/arch/sparc/mm/fault_64.c
@@ -14,7 +14,7 @@
 #include <linux/mman.h>
 #include <linux/signal.h>
 #include <linux/mm.h>
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/init.h>
 #include <linux/perf_event.h>
 #include <linux/interrupt.h>
diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index aec508e37490..96680a687799 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -5,7 +5,7 @@
  *  Copyright (C) 1997-1999 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  */
  
-#include <linux/module.h>
+#include <linux/extable.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
 #include <linux/string.h>
-- 
2.8.4

