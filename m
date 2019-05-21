From: houweitao <houweitaoo@gmail.com>
Date: Tue, 21 May 2019 14:47:40 +0000
Subject: [PATCH] tracing: fix typos in code and comments
Message-Id: <20190521144740.22490-1-houweitao@xiaomi.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linus.walleij@linaro.org, yamada.masahiro@socionext.com, a.zummo@towertech.it, alexandre.belloni@bootlin.com, baohua@kernel.org, gregkh@linuxfoundation.org, jslaby@suse.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, davem@davemloft.net, rostedt@goodmis.org, mingo@redhat.com
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, houweitao <houweitao@xiaomi.com>, linux-arm-kernel@lists.infradead.org

fix ingore to ignore in kernel; since there are other
mistakes can be found with "git grep ",fix all

Signed-off-by: houweitao <houweitao@xiaomi.com>
---
 drivers/pinctrl/uniphier/pinctrl-uniphier-core.c | 2 +-
 drivers/rtc/rtc-sirfsoc.c                        | 2 +-
 drivers/tty/serial/mxs-auart.c                   | 2 +-
 drivers/tty/serial/serial_txx9.c                 | 2 +-
 drivers/tty/serial/sunsab.c                      | 2 +-
 kernel/trace/trace.c                             | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
index 57babf31e320..9f56863ed481 100644
--- a/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
+++ b/drivers/pinctrl/uniphier/pinctrl-uniphier-core.c
@@ -399,7 +399,7 @@ static int uniphier_conf_pin_bias_set(struct pinctrl_dev *pctldev,
 		}
 
 		if (arg = 0)
-			return 0; /* configuration ingored */
+			return 0; /* configuration ignored */
 		break;
 	default:
 		BUG();
diff --git a/drivers/rtc/rtc-sirfsoc.c b/drivers/rtc/rtc-sirfsoc.c
index 9ba28d1ebd87..af1b7ba403fc 100644
--- a/drivers/rtc/rtc-sirfsoc.c
+++ b/drivers/rtc/rtc-sirfsoc.c
@@ -121,7 +121,7 @@ static int sirfsoc_rtc_set_alarm(struct device *dev,
 		rtc_status_reg = sirfsoc_rtc_readl(rtcdrv, RTC_STATUS);
 		if (rtc_status_reg & SIRFSOC_RTC_AL0E) {
 			/*
-			 * An ongoing alarm in progress - ingore it and not
+			 * An ongoing alarm in progress - ignore it and not
 			 * to return EBUSY
 			 */
 			dev_info(dev, "An old alarm was set, will be replaced by a new one\n");
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 4c188f4079b3..9f83a387d6ed 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -667,7 +667,7 @@ static void mxs_auart_rx_char(struct mxs_auart_port *s)
 	}
 
 	/*
-	 * Mask off conditions which should be ingored.
+	 * Mask off conditions which should be ignored.
 	 */
 	stat &= s->port.read_status_mask;
 
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index d22ccb32aa9b..372890e3b896 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -314,7 +314,7 @@ receive_chars(struct uart_txx9_port *up, unsigned int *status)
 			}
 
 			/*
-			 * Mask off conditions which should be ingored.
+			 * Mask off conditions which should be ignored.
 			 */
 			disr &= up->port.read_status_mask;
 
diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 72131b5e132e..daae2b0dbe11 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -200,7 +200,7 @@ receive_chars(struct uart_sunsab_port *up,
 				up->port.icount.overrun++;
 
 			/*
-			 * Mask off conditions which should be ingored.
+			 * Mask off conditions which should be ignored.
 			 */
 			stat->sreg.isr0 &= (up->port.read_status_mask & 0xff);
 			stat->sreg.isr1 &= ((up->port.read_status_mask >> 8) & 0xff);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2c92b3d9ea30..bfa5ab0663e7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8554,7 +8554,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	ftrace_init_tracefs(tr, d_tracer);
 }
 
-static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
+static struct vfsmount *trace_automount(struct dentry *mntpt, void *ignore)
 {
 	struct vfsmount *mnt;
 	struct file_system_type *type;
-- 
2.18.0
