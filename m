From: Randy Dunlap <rdunlap@infradead.org>
Date: Tue, 17 Nov 2020 00:48:00 +0000
Subject: [PATCH] sparc: fix led.c driver when PROC_FS is not enabled
Message-Id: <20201117004800.16734-1-rdunlap@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, kernel test robot <lkp@intel.com>, Alexey Dobriyan <adobriyan@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Lars Kotthoff <metalhead@metalhead.ws>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Fix Sparc build when CONFIG_PROC_FS is not enabled.

Fixes this build error:
arch/sparc/kernel/led.c:107:30: error: 'led_proc_ops' defined but not used [-Werror=unused-const-variable=]
     107 | static const struct proc_ops led_proc_ops = {
         |                              ^~~~~~~~~~~~
   cc1: all warnings being treated as errors

Fixes: 97a32539b956 ("proc: convert everything to "struct proc_ops"")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Lars Kotthoff <metalhead@metalhead.ws>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
This driver is mostly useless without CONFIG_PROC_FS.
I think it would be just as satisfactory to make it depend on
PROC_FS.  Eh?

 arch/sparc/kernel/led.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20201116.orig/arch/sparc/kernel/led.c
+++ linux-next-20201116/arch/sparc/kernel/led.c
@@ -50,6 +50,7 @@ static void led_blink(struct timer_list
 	add_timer(&led_blink_timer);
 }
 
+#ifdef CONFIG_PROC_FS
 static int led_proc_show(struct seq_file *m, void *v)
 {
 	if (get_auxio() & AUXIO_LED)
@@ -111,6 +112,7 @@ static const struct proc_ops led_proc_op
 	.proc_release	= single_release,
 	.proc_write	= led_proc_write,
 };
+#endif
 
 static struct proc_dir_entry *led;
 
