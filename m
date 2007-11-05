From: Lucas Woods <woodzy@gmail.com>
Date: Mon, 05 Nov 2007 20:15:22 +0000
Subject: [PATCH 09/12] arch/sparc: Remove duplicate includes.
Message-Id: <472F79DA.3020501@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org


Signed-off-by: Lucas Woods <woodzy@gmail.com>
---
 arch/sparc/kernel/irq.c           |    1 -
 arch/sparc64/kernel/ds.c          |    1 -
 arch/sparc64/kernel/module.c      |    1 -
 arch/sparc64/kernel/sys_sparc32.c |    1 -
 arch/sparc64/kernel/sys_sunos32.c |    1 -
 arch/sparc64/kernel/time.c        |    2 --
 6 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/irq.c b/arch/sparc/kernel/irq.c
index e1e24f3..01a6756 100644
--- a/arch/sparc/kernel/irq.c
+++ b/arch/sparc/kernel/irq.c
@@ -18,7 +18,6 @@
 #include <linux/linkage.h>
 #include <linux/kernel_stat.h>
 #include <linux/signal.h>
-#include <linux/sched.h>
 #include <linux/interrupt.h>
 #include <linux/slab.h>
 #include <linux/random.h>
diff --git a/arch/sparc64/kernel/ds.c b/arch/sparc64/kernel/ds.c
index 9f472a7..eeb5a2f 100644
--- a/arch/sparc64/kernel/ds.c
+++ b/arch/sparc64/kernel/ds.c
@@ -6,7 +6,6 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/types.h>
-#include <linux/module.h>
 #include <linux/string.h>
 #include <linux/slab.h>
 #include <linux/sched.h>
diff --git a/arch/sparc64/kernel/module.c b/arch/sparc64/kernel/module.c
index 5798715..158484b 100644
--- a/arch/sparc64/kernel/module.c
+++ b/arch/sparc64/kernel/module.c
@@ -11,7 +11,6 @@
 #include <linux/fs.h>
 #include <linux/string.h>
 #include <linux/slab.h>
-#include <linux/vmalloc.h>
 #include <linux/mm.h>
 
 #include <asm/processor.h>
diff --git a/arch/sparc64/kernel/sys_sparc32.c b/arch/sparc64/kernel/sys_sparc32.c
index 78caff9..98c4688 100644
--- a/arch/sparc64/kernel/sys_sparc32.c
+++ b/arch/sparc64/kernel/sys_sparc32.c
@@ -51,7 +51,6 @@
 #include <linux/vfs.h>
 #include <linux/netfilter_ipv4/ip_tables.h>
 #include <linux/ptrace.h>
-#include <linux/highuid.h>
 
 #include <asm/types.h>
 #include <asm/uaccess.h>
diff --git a/arch/sparc64/kernel/sys_sunos32.c b/arch/sparc64/kernel/sys_sunos32.c
index 170d6ca..cfc22d3 100644
--- a/arch/sparc64/kernel/sys_sunos32.c
+++ b/arch/sparc64/kernel/sys_sunos32.c
@@ -57,7 +57,6 @@
 #include <linux/personality.h>
 
 /* For SOCKET_I */
-#include <linux/socket.h>
 #include <net/sock.h>
 #include <net/compat.h>
 
diff --git a/arch/sparc64/kernel/time.c b/arch/sparc64/kernel/time.c
index a2cf955..4352ee4 100644
--- a/arch/sparc64/kernel/time.c
+++ b/arch/sparc64/kernel/time.c
@@ -28,7 +28,6 @@
 #include <linux/jiffies.h>
 #include <linux/cpufreq.h>
 #include <linux/percpu.h>
-#include <linux/profile.h>
 #include <linux/miscdevice.h>
 #include <linux/rtc.h>
 #include <linux/kernel_stat.h>
@@ -47,7 +46,6 @@
 #include <asm/sections.h>
 #include <asm/cpudata.h>
 #include <asm/uaccess.h>
-#include <asm/prom.h>
 #include <asm/irq_regs.h>
 
 DEFINE_SPINLOCK(mostek_lock);
-- 



