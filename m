From: Kees Cook <keescook@chromium.org>
Date: Tue, 10 Oct 2017 22:07:27 +0000
Subject: [PATCH] sparc/led: Convert timers to use timer_setup()
Message-Id: <20171010220727.GA97619@beast>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Geliang Tang <geliangtang@gmail.com>, Ingo Molnar <mingo@kernel.org>, sparclinux@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly. Adds a static variable to hold timeout
value.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Geliang Tang <geliangtang@gmail.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
This requires commit 686fef928bba ("timer: Prepare to change timer
callback argument type") in v4.14-rc3, but should be otherwise
stand-alone.
---
 arch/sparc/kernel/led.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
index e278bf52963b..519f5ba7ed7e 100644
--- a/arch/sparc/kernel/led.c
+++ b/arch/sparc/kernel/led.c
@@ -31,19 +31,20 @@ static inline void led_toggle(void)
 }
 
 static struct timer_list led_blink_timer;
+static unsigned long led_blink_timer_timeout;
 
-static void led_blink(unsigned long timeout)
+static void led_blink(struct timer_list *unused)
 {
+	unsigned long timeout = led_blink_timer_timeout;
+
 	led_toggle();
 
 	/* reschedule */
 	if (!timeout) { /* blink according to load */
 		led_blink_timer.expires = jiffies +
 			((1 + (avenrun[0] >> FSHIFT)) * HZ);
-		led_blink_timer.data = 0;
 	} else { /* blink at user specified interval */
 		led_blink_timer.expires = jiffies + (timeout * HZ);
-		led_blink_timer.data = timeout;
 	}
 	add_timer(&led_blink_timer);
 }
@@ -88,9 +89,11 @@ static ssize_t led_proc_write(struct file *file, const char __user *buffer,
 	} else if (!strcmp(buf, "toggle")) {
 		led_toggle();
 	} else if ((*buf > '0') && (*buf <= '9')) {
-		led_blink(simple_strtoul(buf, NULL, 10));
+		led_blink_timer_timeout = simple_strtoul(buf, NULL, 10);
+		led_blink(&led_blink_timer);
 	} else if (!strcmp(buf, "load")) {
-		led_blink(0);
+		led_blink_timer_timeout = 0;
+		led_blink(&led_blink_timer);
 	} else {
 		auxio_set_led(AUXIO_LED_OFF);
 	}
@@ -115,8 +118,7 @@ static struct proc_dir_entry *led;
 
 static int __init led_init(void)
 {
-	init_timer(&led_blink_timer);
-	led_blink_timer.function = led_blink;
+	timer_setup(&led_blink_timer, led_blink, 0);
 
 	led = proc_create("led", 0, NULL, &led_proc_fops);
 	if (!led)
-- 
2.7.4


-- 
Kees Cook
Pixel Security
