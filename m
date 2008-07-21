From: Jaswinder Singh <jaswinder@infradead.org>
Date: Mon, 21 Jul 2008 00:05:13 +0000
Subject: [PATCH 18/22] sparc: Introducing asm/syscalls.h
Message-Id: <1216597993.3679.144.camel@jaswinder.satnam>
List-Id: <sparclinux.vger.kernel.org>
References: <1216592500.3679.14.camel@jaswinder.satnam>
	 <1216592798.3679.22.camel@jaswinder.satnam>
	 <1216592879.3679.24.camel@jaswinder.satnam>
	 <1216593035.3679.27.camel@jaswinder.satnam>
	 <1216596035.3679.95.camel@jaswinder.satnam>
	 <1216596106.3679.98.camel@jaswinder.satnam>
	 <1216596325.3679.104.camel@jaswinder.satnam>
	 <1216596669.3679.112.camel@jaswinder.satnam>
	 <1216596749.3679.115.camel@jaswinder.satnam>
	 <1216596835.3679.117.camel@jaswinder.satnam>
	 <1216596932.3679.120.camel@jaswinder.satnam>
	 <1216597066.3679.123.camel@jaswinder.satnam>
	 <1216597151.3679.125.camel@jaswinder.satnam>
	 <1216597237.3679.128.camel@jaswinder.satnam>
	 <1216597352.3679.131.camel@jaswinder.satnam>
	 <1216597566.3679.135.camel@jaswinder.satnam>
	 <1216597856.3679.139.camel@jaswinder.satnam>
	 <1216597923.3679.141.camel@jaswinder.satnam>
In-Reply-To: <1216597923.3679.141.camel@jaswinder.satnam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, kernelnewbies <kernelnewbies@nl.linux.org>, David Woodhouse <dwmw2@infradead.org>, davem@davemloft.net, sparclinux@vger.kernel.org

Declaring arch-dependent syscalls for sparc architecture

Signed-off-by: Jaswinder Singh <jaswinder@infradead.org>
---
 arch/sparc/kernel/signal.c   |    1 +
 include/asm-sparc/syscalls.h |   30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/signal.c b/arch/sparc/kernel/signal.c
index 3fd1df9..6fe2da5 100644
--- a/arch/sparc/kernel/signal.c
+++ b/arch/sparc/kernel/signal.c
@@ -18,6 +18,7 @@
 #include <linux/smp.h>
 #include <linux/binfmts.h>	/* do_coredum */
 #include <linux/bitops.h>
+#include <linux/syscalls.h>
 
 #include <asm/uaccess.h>
 #include <asm/ptrace.h>
diff --git a/include/asm-sparc/syscalls.h b/include/asm-sparc/syscalls.h
index e69de29..65c25cd 100644
--- a/include/asm-sparc/syscalls.h
+++ b/include/asm-sparc/syscalls.h
@@ -0,0 +1,30 @@
+/*
+ * syscalls.h - Linux syscall interfaces (arch-specific)
+ *
+ * Copyright (c) 2008 Jaswinder Singh
+ *
+ * This file is released under the GPLv2.
+ * See the file COPYING for more details.
+ *
+ * Please do not call me directly, include linux/syscalls.h
+ */
+
+#ifndef _ASM_SPARC_SYSCALLS_H
+#define _ASM_SPARC_SYSCALLS_H
+
+/* kernel/signal.c */
+asmlinkage int sys_sigsuspend(old_sigset_t);
+
+/* kernel/sys_sparc.c */
+asmlinkage unsigned long sys_getpagesize(void);
+asmlinkage int sys_ipc(uint, int, int, int, void __user *, long);
+asmlinkage long sys_mmap2(unsigned long, unsigned long, unsigned long,
+			  unsigned long, unsigned long, unsigned long);
+asmlinkage long sys_mmap(unsigned long, unsigned long, unsigned long,
+			 unsigned long, unsigned long, unsigned long);
+asmlinkage long sys_rt_sigaction(int, const struct sigaction __user *,
+				 struct sigaction __user *,
+				 void __user *, size_t);
+asmlinkage int sys_getdomainname(char __user *, int);
+
+#endif /* _ASM_SPARC_SYSCALLS_H */
-- 
1.5.5.1



