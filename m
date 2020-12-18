From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 18 Dec 2020 18:43:37 +0000
Subject: [PATCH v1 03/13] sparc32: Drop sun4m specific led driver
Message-Id: <20201218184347.2180772-4-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20201218184347.2180772-1-sam@ravnborg.org>
In-Reply-To: <20201218184347.2180772-1-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David S Miller <davem@davemloft.net>, sparclinux@vger.kernel.org, Andreas Larsson <andreas@gaisler.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual <anshuman.khandual@arm.com>, Arvind Sankar <nivedita@alum.mit.edu>, Christian Brauner <christian.brauner@ubuntu.com>, Denis Efremov <efremov@linux.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ira Weiny <ira.weiny@intel.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Mike Rapoport <rppt@kernel.org>, Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Sam Ravnborg <sam@ravnborg.org>, Stephen Rothwell <sfr@canb.auug.org.au>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, Willy Tarreau <w@1wt.eu>, linux-kernel@vger.kernel.org, debian-sparc@lists.debian.org, gentoo-sparc@l.g.o

The led driver is only relevant for the sun4m machines.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: sparclinux@vger.kernel.org
Cc: Arnd Bergmann <arnd@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>
---
 arch/sparc/Kconfig         |   9 ---
 arch/sparc/kernel/Makefile |   1 -
 arch/sparc/kernel/led.c    | 146 -------------------------------------
 3 files changed, 156 deletions(-)
 delete mode 100644 arch/sparc/kernel/led.c

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 2c6d8d834f9a..8447f5b7bb90 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -337,15 +337,6 @@ config SUN_PM
 	  Enable power management and CPU standby features on supported
 	  SPARC platforms.
 
-config SPARC_LED
-	tristate "Sun4m LED driver"
-	depends on SPARC32
-	help
-	  This driver toggles the front-panel LED on sun4m systems
-	  in a user-specifiable manner.  Its state can be probed
-	  by reading /proc/led and its blinking mode can be changed
-	  via writes to /proc/led
-
 config SERIAL_CONSOLE
 	bool
 	depends on SPARC32
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index d3a0e072ebe8..b6c9ca1d6c66 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -89,7 +89,6 @@ obj-$(CONFIG_SUN_PM)      += apc.o pmc.o
 
 obj-$(CONFIG_MODULES)     += module.o
 obj-$(CONFIG_MODULES)     += sparc_ksyms.o
-obj-$(CONFIG_SPARC_LED)   += led.o
 obj-$(CONFIG_KGDB)        += kgdb_$(BITS).o
 
 
diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
deleted file mode 100644
index bd48575172c3..000000000000
--- a/arch/sparc/kernel/led.c
+++ /dev/null
@@ -1,146 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/proc_fs.h>
-#include <linux/seq_file.h>
-#include <linux/slab.h>
-#include <linux/string.h>
-#include <linux/jiffies.h>
-#include <linux/timer.h>
-#include <linux/uaccess.h>
-#include <linux/sched/loadavg.h>
-
-#include <asm/auxio.h>
-
-#define LED_MAX_LENGTH 8 /* maximum chars written to proc file */
-
-static inline void led_toggle(void)
-{
-	unsigned char val = get_auxio();
-	unsigned char on, off;
-
-	if (val & AUXIO_LED) {
-		on = 0;
-		off = AUXIO_LED;
-	} else {
-		on = AUXIO_LED;
-		off = 0;
-	}
-
-	set_auxio(on, off);
-}
-
-static struct timer_list led_blink_timer;
-static unsigned long led_blink_timer_timeout;
-
-static void led_blink(struct timer_list *unused)
-{
-	unsigned long timeout = led_blink_timer_timeout;
-
-	led_toggle();
-
-	/* reschedule */
-	if (!timeout) { /* blink according to load */
-		led_blink_timer.expires = jiffies +
-			((1 + (avenrun[0] >> FSHIFT)) * HZ);
-	} else { /* blink at user specified interval */
-		led_blink_timer.expires = jiffies + (timeout * HZ);
-	}
-	add_timer(&led_blink_timer);
-}
-
-static int led_proc_show(struct seq_file *m, void *v)
-{
-	if (get_auxio() & AUXIO_LED)
-		seq_puts(m, "on\n");
-	else
-		seq_puts(m, "off\n");
-	return 0;
-}
-
-static int led_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, led_proc_show, NULL);
-}
-
-static ssize_t led_proc_write(struct file *file, const char __user *buffer,
-			      size_t count, loff_t *ppos)
-{
-	char *buf = NULL;
-
-	if (count > LED_MAX_LENGTH)
-		count = LED_MAX_LENGTH;
-
-	buf = memdup_user_nul(buffer, count);
-	if (IS_ERR(buf))
-		return PTR_ERR(buf);
-
-	/* work around \n when echo'ing into proc */
-	if (buf[count - 1] = '\n')
-		buf[count - 1] = '\0';
-
-	/* before we change anything we want to stop any running timers,
-	 * otherwise calls such as on will have no persistent effect
-	 */
-	del_timer_sync(&led_blink_timer);
-
-	if (!strcmp(buf, "on")) {
-		auxio_set_led(AUXIO_LED_ON);
-	} else if (!strcmp(buf, "toggle")) {
-		led_toggle();
-	} else if ((*buf > '0') && (*buf <= '9')) {
-		led_blink_timer_timeout = simple_strtoul(buf, NULL, 10);
-		led_blink(&led_blink_timer);
-	} else if (!strcmp(buf, "load")) {
-		led_blink_timer_timeout = 0;
-		led_blink(&led_blink_timer);
-	} else {
-		auxio_set_led(AUXIO_LED_OFF);
-	}
-
-	kfree(buf);
-
-	return count;
-}
-
-static const struct proc_ops led_proc_ops = {
-	.proc_open	= led_proc_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= single_release,
-	.proc_write	= led_proc_write,
-};
-
-static struct proc_dir_entry *led;
-
-#define LED_VERSION	"0.1"
-
-static int __init led_init(void)
-{
-	timer_setup(&led_blink_timer, led_blink, 0);
-
-	led = proc_create("led", 0, NULL, &led_proc_ops);
-	if (!led)
-		return -ENOMEM;
-
-	printk(KERN_INFO
-	       "led: version %s, Lars Kotthoff <metalhead@metalhead.ws>\n",
-	       LED_VERSION);
-
-	return 0;
-}
-
-static void __exit led_exit(void)
-{
-	remove_proc_entry("led", NULL);
-	del_timer_sync(&led_blink_timer);
-}
-
-module_init(led_init);
-module_exit(led_exit);
-
-MODULE_AUTHOR("Lars Kotthoff <metalhead@metalhead.ws>");
-MODULE_DESCRIPTION("Provides control of the front LED on SPARC systems.");
-MODULE_LICENSE("GPL");
-MODULE_VERSION(LED_VERSION);
-- 
2.27.0
