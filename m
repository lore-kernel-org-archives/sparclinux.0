From: Kees Cook <keescook@chromium.org>
Date: Thu, 31 Aug 2017 23:29:34 +0000
Subject: [PATCH 22/31] sparc/led: Use separate static data field with with static timer
Message-Id: <1504222183-61202-23-git-send-email-keescook@chromium.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1504222183-61202-1-git-send-email-keescook@chromium.org>
In-Reply-To: <1504222183-61202-1-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@chromium.org>, "David S. Miller" <davem@davemloft.net>, Ingo Molnar <mingo@kernel.org>, Geliang Tang <geliangtang@gmail.com>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

In preparation for changing the timer callback argument to the timer
pointer, move to a separate static data variable.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Geliang Tang <geliangtang@gmail.com>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/sparc/kernel/led.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/kernel/led.c b/arch/sparc/kernel/led.c
index e278bf52963b..382860e482e0 100644
--- a/arch/sparc/kernel/led.c
+++ b/arch/sparc/kernel/led.c
@@ -31,19 +31,20 @@ static inline void led_toggle(void)
 }
 
 static struct timer_list led_blink_timer;
+static unsigned long led_blink_timer_timeout;
 
-static void led_blink(unsigned long timeout)
+static void led_blink(unsigned long unused)
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
@@ -88,8 +89,10 @@ static ssize_t led_proc_write(struct file *file, const char __user *buffer,
 	} else if (!strcmp(buf, "toggle")) {
 		led_toggle();
 	} else if ((*buf > '0') && (*buf <= '9')) {
-		led_blink(simple_strtoul(buf, NULL, 10));
+		led_blink_timer_timeout = simple_strtoul(buf, NULL, 10);
+		led_blink(0);
 	} else if (!strcmp(buf, "load")) {
+		led_blink_timer_timeout = 0;
 		led_blink(0);
 	} else {
 		auxio_set_led(AUXIO_LED_OFF);
@@ -115,8 +118,7 @@ static struct proc_dir_entry *led;
 
 static int __init led_init(void)
 {
-	init_timer(&led_blink_timer);
-	led_blink_timer.function = led_blink;
+	setup_timer(&led_blink_timer, led_blink, 0);
 
 	led = proc_create("led", 0, NULL, &led_proc_fops);
 	if (!led)
-- 
2.7.4

