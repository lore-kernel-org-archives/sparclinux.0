From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Mon, 06 Jan 2014 20:25:39 +0000
Subject: [PATCH] sparc: delete non-required instances of include <linux/init.h>
Message-Id: <1389039939-18314-1-git-send-email-paul.gortmaker@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

None of these files are actually using any __init type directives
and hence don't need to include <linux/init.h>.  Most are just a
left over from __devinit and __cpuinit removal, or simply due to
code getting copied from one driver to the next.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---

[build tested sparc allyes/modconfig and sparc64_defconfig on
 v3.13-rc7, with previously sent kdgb build commit fix applied]

 arch/sparc/kernel/cpumap.c           | 1 -
 arch/sparc/kernel/ebus.c             | 1 -
 arch/sparc/kernel/hvtramp.S          | 1 -
 arch/sparc/kernel/of_device_common.c | 1 -
 arch/sparc/kernel/pci_common.c       | 1 -
 arch/sparc/kernel/process_32.c       | 1 -
 arch/sparc/kernel/sparc_ksyms_32.c   | 1 -
 arch/sparc/kernel/sparc_ksyms_64.c   | 1 -
 arch/sparc/kernel/trampoline_32.S    | 1 -
 arch/sparc/kernel/trampoline_64.S    | 1 -
 arch/sparc/mm/hugetlbpage.c          | 1 -
 arch/sparc/mm/tlb.c                  | 1 -
 arch/sparc/prom/p1275.c              | 1 -
 drivers/sbus/char/bbc_i2c.c          | 1 -
 drivers/sbus/char/display7seg.c      | 1 -
 drivers/sbus/char/envctrl.c          | 1 -
 drivers/sbus/char/flash.c            | 1 -
 drivers/sbus/char/uctrl.c            | 1 -
 18 files changed, 18 deletions(-)

diff --git a/arch/sparc/kernel/cpumap.c b/arch/sparc/kernel/cpumap.c
index cb5d272d658a..de1c844dfabc 100644
--- a/arch/sparc/kernel/cpumap.c
+++ b/arch/sparc/kernel/cpumap.c
@@ -6,7 +6,6 @@
 #include <linux/export.h>
 #include <linux/slab.h>
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/cpumask.h>
 #include <linux/spinlock.h>
 #include <asm/cpudata.h>
diff --git a/arch/sparc/kernel/ebus.c b/arch/sparc/kernel/ebus.c
index e306fb08ee5e..acf8314cec48 100644
--- a/arch/sparc/kernel/ebus.c
+++ b/arch/sparc/kernel/ebus.c
@@ -7,7 +7,6 @@
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/types.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
 
diff --git a/arch/sparc/kernel/hvtramp.S b/arch/sparc/kernel/hvtramp.S
index 4eb1a5a1d544..b7ddcdd1dea9 100644
--- a/arch/sparc/kernel/hvtramp.S
+++ b/arch/sparc/kernel/hvtramp.S
@@ -3,7 +3,6 @@
  * Copyright (C) 2007, 2008 David S. Miller <davem@davemloft.net>
  */
 
-#include <linux/init.h>
 
 #include <asm/thread_info.h>
 #include <asm/hypervisor.h>
diff --git a/arch/sparc/kernel/of_device_common.c b/arch/sparc/kernel/of_device_common.c
index de199bf0cb05..3241f56331c2 100644
--- a/arch/sparc/kernel/of_device_common.c
+++ b/arch/sparc/kernel/of_device_common.c
@@ -1,7 +1,6 @@
 #include <linux/string.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
-#include <linux/init.h>
 #include <linux/export.h>
 #include <linux/mod_devicetable.h>
 #include <linux/errno.h>
diff --git a/arch/sparc/kernel/pci_common.c b/arch/sparc/kernel/pci_common.c
index a6895987fb70..944a06536ecc 100644
--- a/arch/sparc/kernel/pci_common.c
+++ b/arch/sparc/kernel/pci_common.c
@@ -5,7 +5,6 @@
 
 #include <linux/string.h>
 #include <linux/slab.h>
-#include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/device.h>
 #include <linux/of_device.h>
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.c
index fdd819dfdacf..510baec1b69b 100644
--- a/arch/sparc/kernel/process_32.c
+++ b/arch/sparc/kernel/process_32.c
@@ -22,7 +22,6 @@
 #include <linux/reboot.h>
 #include <linux/delay.h>
 #include <linux/pm.h>
-#include <linux/init.h>
 #include <linux/slab.h>
 
 #include <asm/auxio.h>
diff --git a/arch/sparc/kernel/sparc_ksyms_32.c b/arch/sparc/kernel/sparc_ksyms_32.c
index e521c54560f9..bf4ccb10a78c 100644
--- a/arch/sparc/kernel/sparc_ksyms_32.c
+++ b/arch/sparc/kernel/sparc_ksyms_32.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/init.h>
 
 #include <asm/pgtable.h>
 #include <asm/uaccess.h>
diff --git a/arch/sparc/kernel/sparc_ksyms_64.c b/arch/sparc/kernel/sparc_ksyms_64.c
index 9f5e24ddcc70..a92d5d2c46a3 100644
--- a/arch/sparc/kernel/sparc_ksyms_64.c
+++ b/arch/sparc/kernel/sparc_ksyms_64.c
@@ -7,7 +7,6 @@
 
 #include <linux/export.h>
 #include <linux/pci.h>
-#include <linux/init.h>
 #include <linux/bitops.h>
 
 #include <asm/cpudata.h>
diff --git a/arch/sparc/kernel/trampoline_32.S b/arch/sparc/kernel/trampoline_32.S
index 76dcbd3c988a..3eed99fc6989 100644
--- a/arch/sparc/kernel/trampoline_32.S
+++ b/arch/sparc/kernel/trampoline_32.S
@@ -5,7 +5,6 @@
  * Copyright (C) 1998 Jakub Jelinek (jj@sunsite.mff.cuni.cz)
  */
 
-#include <linux/init.h>
 #include <asm/head.h>
 #include <asm/psr.h>
 #include <asm/page.h>
diff --git a/arch/sparc/kernel/trampoline_64.S b/arch/sparc/kernel/trampoline_64.S
index ad4bde3bb61e..737f8cbc7d56 100644
--- a/arch/sparc/kernel/trampoline_64.S
+++ b/arch/sparc/kernel/trampoline_64.S
@@ -4,7 +4,6 @@
  * Copyright (C) 1997 David S. Miller (davem@caip.rutgers.edu)
  */
 
-#include <linux/init.h>
 
 #include <asm/head.h>
 #include <asm/asi.h>
diff --git a/arch/sparc/mm/hugetlbpage.c b/arch/sparc/mm/hugetlbpage.c
index 30963178d7e9..9bd9ce80bf77 100644
--- a/arch/sparc/mm/hugetlbpage.c
+++ b/arch/sparc/mm/hugetlbpage.c
@@ -4,7 +4,6 @@
  * Copyright (C) 2002, 2003, 2006 David S. Miller (davem@davemloft.net)
  */
 
-#include <linux/init.h>
 #include <linux/fs.h>
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
index ad3bf4b4324d..b12cb5e72812 100644
--- a/arch/sparc/mm/tlb.c
+++ b/arch/sparc/mm/tlb.c
@@ -4,7 +4,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/percpu.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
diff --git a/arch/sparc/prom/p1275.c b/arch/sparc/prom/p1275.c
index 04a4540509dd..e58b81726319 100644
--- a/arch/sparc/prom/p1275.c
+++ b/arch/sparc/prom/p1275.c
@@ -5,7 +5,6 @@
  */
 
 #include <linux/kernel.h>
-#include <linux/init.h>
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/string.h>
diff --git a/drivers/sbus/char/bbc_i2c.c b/drivers/sbus/char/bbc_i2c.c
index c1441ed282eb..c7763e482eb2 100644
--- a/drivers/sbus/char/bbc_i2c.c
+++ b/drivers/sbus/char/bbc_i2c.c
@@ -11,7 +11,6 @@
 #include <linux/sched.h>
 #include <linux/wait.h>
 #include <linux/delay.h>
-#include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
diff --git a/drivers/sbus/char/display7seg.c b/drivers/sbus/char/display7seg.c
index fc1339cf91ac..7c71e7b4febf 100644
--- a/drivers/sbus/char/display7seg.c
+++ b/drivers/sbus/char/display7seg.c
@@ -9,7 +9,6 @@
 #include <linux/fs.h>
 #include <linux/errno.h>
 #include <linux/major.h>
-#include <linux/init.h>
 #include <linux/miscdevice.h>
 #include <linux/ioport.h>		/* request_region */
 #include <linux/slab.h>
diff --git a/drivers/sbus/char/envctrl.c b/drivers/sbus/char/envctrl.c
index ddbe5a9e713d..af15a2fdab5e 100644
--- a/drivers/sbus/char/envctrl.c
+++ b/drivers/sbus/char/envctrl.c
@@ -19,7 +19,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/init.h>
 #include <linux/kthread.h>
 #include <linux/delay.h>
 #include <linux/ioport.h>
diff --git a/drivers/sbus/char/flash.c b/drivers/sbus/char/flash.c
index d9f268f23774..25c738e9ef19 100644
--- a/drivers/sbus/char/flash.c
+++ b/drivers/sbus/char/flash.c
@@ -9,7 +9,6 @@
 #include <linux/miscdevice.h>
 #include <linux/fcntl.h>
 #include <linux/poll.h>
-#include <linux/init.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/mm.h>
diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index b0aae0536d58..b7acafc85099 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -11,7 +11,6 @@
 #include <linux/slab.h>
 #include <linux/mutex.h>
 #include <linux/ioport.h>
-#include <linux/init.h>
 #include <linux/miscdevice.h>
 #include <linux/mm.h>
 #include <linux/of.h>
-- 
1.8.5.1

