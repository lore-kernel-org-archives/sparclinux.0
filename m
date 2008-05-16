From: Alexey Dobriyan <adobriyan@gmail.com>
Date: Fri, 16 May 2008 22:57:56 +0000
Subject: [PATCH] sparc: switch /proc/led to seq_file
Message-Id: <20080516235331.GA21207@martell.zuzino.mipt.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/sparc/kernel/led.c |   34 +++++++++++++++++++++-------------
 1 file changed, 21 insertions(+), 13 deletions(-)

--- a/arch/sparc/kernel/led.c
+++ b/arch/sparc/kernel/led.c
@@ -2,6 +2,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/proc_fs.h>
+#include <linux/seq_file.h>
 #include <linux/string.h>
 #include <linux/jiffies.h>
 #include <linux/timer.h>
@@ -45,21 +46,22 @@ static void led_blink(unsigned long timeout)
 	add_timer(&led_blink_timer);
 }
 
-static int led_read_proc(char *buf, char **start, off_t offset, int count,
-			 int *eof, void *data)
+static int led_proc_show(struct seq_file *m, void *v)
 {
-	int len = 0;
-
 	if (get_auxio() & AUXIO_LED)
-		len = sprintf(buf, "on\n");
+		seq_puts(m, "on\n");
 	else
-		len = sprintf(buf, "off\n");
+		seq_puts(m, "off\n");
+	return 0;
+}
 
-	return len;
+static int led_proc_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, led_proc_show, NULL);
 }
 
-static int led_write_proc(struct file *file, const char __user *buffer,
-			  unsigned long count, void *data)
+static ssize_t led_proc_write(struct file *file, const char __user *buffer,
+			      size_t count, loff_t *ppos)
 {
 	char *buf = NULL;
 
@@ -103,6 +105,15 @@ static int led_write_proc(struct file *file, const char __user *buffer,
 	return count;
 }
 
+static const struct file_operations led_proc_fops = {
+	.owner		= THIS_MODULE,
+	.open		= led_proc_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+	.write		= led_proc_write,
+};
+
 static struct proc_dir_entry *led;
 
 #define LED_VERSION	"0.1"
@@ -112,12 +123,9 @@ static int __init led_init(void)
 	init_timer(&led_blink_timer);
 	led_blink_timer.function = led_blink;
 
-	led = create_proc_entry("led", 0, NULL);
+	led = proc_create("led", 0, NULL, &led_proc_fops);
 	if (!led)
 		return -ENOMEM;
-
-	led->read_proc = led_read_proc; /* reader function */
-	led->write_proc = led_write_proc; /* writer function */
 	led->owner = THIS_MODULE;
 
 	printk(KERN_INFO

