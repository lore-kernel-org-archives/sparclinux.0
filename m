From: David Miller <davem@davemloft.net>
Date: Sat, 22 Jul 2006 08:10:14 +0000
Subject: Re: oops on e4k5
Message-Id: <20060722.011014.74747052.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <877j26m8kl.fsf@xserver.flexserv.de>
In-Reply-To: <877j26m8kl.fsf@xserver.flexserv.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The OOPS is severely truncated where the most important
information would normally appear.  Please reproduce with
the following patch applied.

It might also help if you turn off CONFIG_PROM_CONSOLE.
The zilog serial driver should drive your console just fine,
and your logs show it does register properly.

Also, what kind of cpus are in this machine?  (/proc/cpuinfo
output is sufficient)

Thanks.

diff --git a/arch/sparc64/mm/fault.c b/arch/sparc64/mm/fault.c
index 6e002aa..b8f0d2e 100644
--- a/arch/sparc64/mm/fault.c
+++ b/arch/sparc64/mm/fault.c
@@ -19,6 +19,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/kprobes.h>
+#include <linux/kallsyms.h>
 
 #include <asm/page.h>
 #include <asm/pgtable.h>
@@ -98,6 +99,8 @@ static void bad_kernel_pc(struct pt_regs
 
 	printk(KERN_CRIT "OOPS: Bogus kernel PC [%016lx] in fault handler\n",
 	       regs->tpc);
+	printk(KERN_CRIT "OOPS: RPC [%016lx]\n", regs->u_regs[15]);
+	print_symbol("RPC: <%s>\n", regs->u_regs[15]);
 	printk(KERN_CRIT "OOPS: Fault was to vaddr[%lx]\n", vaddr);
 	__asm__("mov %%sp, %0" : "=r" (ksp));
 	show_stack(current, ksp);
