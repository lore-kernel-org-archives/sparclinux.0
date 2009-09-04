From: David Miller <davem@davemloft.net>
Date: Fri, 04 Sep 2009 10:38:34 +0000
Subject: Re: 2.6.31-rc1: sparc T2: Fast Data Access MMU Miss
Message-Id: <20090904.033834.234166208.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090904.030857.98883610.davem@davemloft.net>
In-Reply-To: <20090904.030857.98883610.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The problem is that is a missing "notrace" annotation.

It triggers with your config because some functions don't get
inlined by the compiler which normally would be (which is why
I've never seen this before).

Please try this patch, thanks!

sparc64: Fix bootup with mcount in some configs.

Functions invoked early when booting up a cpu can't use
tracing because mcount requires a valid 'current_thread_info()'
and TLB mappings to be setup.

The code path of sun4v_register_mondo_queues --> register_one_mondo
is one such case.  sun4v_register_mondo_queues already has the
necessary 'notrace' annotation, but register_one_mondo does not.

Normally register_on_mondo is inlined so the bug doesn't trigger,
but with some config/compiler combinations, it won't be so we
must properly mark it notrace.

While we're here, add 'notrace' annoations to prom_printf and
prom_halt so that early error handling won't have the same problem.

Reported-by: Alexander Beregalov <a.beregalov@gmail.com>
Reported-by: Leif Sawyer <lsawyer@gci.com>
Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index f0ee790..8daab33 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -886,7 +886,7 @@ void notrace init_irqwork_curcpu(void)
  * Therefore you cannot make any OBP calls, not even prom_printf,
  * from these two routines.
  */
-static void __cpuinit register_one_mondo(unsigned long paddr, unsigned long type, unsigned long qmask)
+static void __cpuinit notrace register_one_mondo(unsigned long paddr, unsigned long type, unsigned long qmask)
 {
 	unsigned long num_entries = (qmask + 1) / 64;
 	unsigned long status;
diff --git a/arch/sparc/prom/misc_64.c b/arch/sparc/prom/misc_64.c
index eedffb4..39fc6af 100644
--- a/arch/sparc/prom/misc_64.c
+++ b/arch/sparc/prom/misc_64.c
@@ -88,7 +88,7 @@ void prom_cmdline(void)
 /* Drop into the prom, but completely terminate the program.
  * No chance of continuing.
  */
-void prom_halt(void)
+void notrace prom_halt(void)
 {
 #ifdef CONFIG_SUN_LDOMS
 	if (ldom_domaining_enabled)
diff --git a/arch/sparc/prom/printf.c b/arch/sparc/prom/printf.c
index 660943e..ca86926 100644
--- a/arch/sparc/prom/printf.c
+++ b/arch/sparc/prom/printf.c
@@ -14,14 +14,14 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/compiler.h>
 
 #include <asm/openprom.h>
 #include <asm/oplib.h>
 
 static char ppbuf[1024];
 
-void
-prom_write(const char *buf, unsigned int n)
+void notrace prom_write(const char *buf, unsigned int n)
 {
 	char ch;
 
@@ -33,8 +33,7 @@ prom_write(const char *buf, unsigned int n)
 	}
 }
 
-void
-prom_printf(const char *fmt, ...)
+void notrace prom_printf(const char *fmt, ...)
 {
 	va_list args;
 	int i;
