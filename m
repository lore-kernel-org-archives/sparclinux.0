From: Bob Breuer <breuerr@mc.net>
Date: Fri, 14 Jan 2005 06:58:35 +0000
Subject: Re: dump_stack missing on sparc32
Message-Id: <41E76D9B.9090004@mc.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050114041906.GE6101@holomorphy.com>
In-Reply-To: <20050114041906.GE6101@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This adds a sparc32 specific dump_stack() to 2.6, based off of the sparc64
version.

Bob


--- linux-2.6.10-bk8-clean/arch/sparc/kernel/process.c	2005-01-12 00:16:01.000000000 -0600
+++ linux-2.6.10-bk8/arch/sparc/kernel/process.c	2005-01-14 00:38:11.000000000 -0600
@@ -333,6 +333,17 @@ void show_stack(struct task_struct *tsk,
  	printk("\n");
  }

+void dump_stack(void)
+{
+	unsigned long *ksp;
+
+	__asm__ __volatile__("mov	%%fp, %0"
+			     : "=r" (ksp));
+	show_stack(current, ksp);
+}
+
+EXPORT_SYMBOL(dump_stack);
+
  /*
   * Note: sparc64 has a pretty intricated thread_saved_pc, check it out.
   */

