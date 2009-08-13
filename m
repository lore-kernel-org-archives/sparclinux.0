From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Thu, 13 Aug 2009 20:05:43 +0000
Subject: [PATCH] sparc64: cheaper asm/uaccess.h inclusion
Message-Id: <20090813200543.GA2376@x200.localdomain>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

sched.h inclusion is definitely not needed like in 32-bit version,
remove it, fixup compilation.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/sparc/include/asm/uaccess_64.h |    2 +-
 arch/sparc/kernel/sysfs.c           |    1 +
 samples/kprobes/kretprobe_example.c |    1 +
 3 files changed, 3 insertions(+), 1 deletion(-)

--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -7,8 +7,8 @@
 
 #ifdef __KERNEL__
 #include <linux/compiler.h>
-#include <linux/sched.h>
 #include <linux/string.h>
+#include <linux/thread_info.h>
 #include <asm/asi.h>
 #include <asm/system.h>
 #include <asm/spitfire.h>
--- a/arch/sparc/kernel/sysfs.c
+++ b/arch/sparc/kernel/sysfs.c
@@ -2,6 +2,7 @@
  *
  * Copyright (C) 2007 David S. Miller <davem@davemloft.net>
  */
+#include <linux/sched.h>
 #include <linux/sysdev.h>
 #include <linux/cpu.h>
 #include <linux/smp.h>
--- a/samples/kprobes/kretprobe_example.c
+++ b/samples/kprobes/kretprobe_example.c
@@ -23,6 +23,7 @@
 #include <linux/kprobes.h>
 #include <linux/ktime.h>
 #include <linux/limits.h>
+#include <linux/sched.h>
 
 static char func_name[NAME_MAX] = "do_fork";
 module_param_string(func, func_name, NAME_MAX, S_IRUGO);
