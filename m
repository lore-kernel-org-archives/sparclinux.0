From: Jason Wessel <jason.wessel@windriver.com>
Date: Fri, 30 Jul 2010 19:17:35 +0000
Subject: [PATCH 14/15] sunhv,kgdboc: Add sunhv console poll hooks for kgdboc
Message-Id: <1280517456-1167-15-git-send-email-jason.wessel@windriver.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1280517456-1167-1-git-send-email-jason.wessel@windriver.com>
In-Reply-To: <1280517456-1167-1-git-send-email-jason.wessel@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: kgdb-bugreport@lists.sourceforge.net, mingo@elte.hu, Jason Wessel <jason.wessel@windriver.com>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Add the CONSOLE_POLL hooks for use with kgdboc on the sunhv uart
driver.

Signed-off-by: Jason Wessel <jason.wessel@windriver.com>
CC: David S. Miller <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
---
 drivers/serial/sunhv.c |   51 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 51 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/sunhv.c b/drivers/serial/sunhv.c
index 890f917..bab9515 100644
--- a/drivers/serial/sunhv.c
+++ b/drivers/serial/sunhv.c
@@ -309,6 +309,53 @@ static void sunhv_break_ctl(struct uart_port *port, int break_state)
 	}
 }
 
+#ifdef CONFIG_CONSOLE_POLL
+/*
+ * Console polling routines for writing and reading from the uart while
+ * in an interrupt or debug context.
+ */
+
+static int poll_buf[PAGE_SIZE];
+static int poll_buf_cnt;
+static int poll_buf_idx;
+
+static int sunhv_get_poll_char(struct uart_port *port)
+{
+	unsigned long bytes_read;
+	long stat;
+	unsigned long ra;
+	int i;
+
+	if (poll_buf_idx < poll_buf_cnt)
+		return poll_buf[poll_buf_idx++];
+
+	ra = __pa(con_read_page);
+	stat = sun4v_con_read(ra, PAGE_SIZE, &bytes_read);
+	if (stat = HV_EOK) {
+		poll_buf_idx = 1;
+		poll_buf_cnt = bytes_read;
+		for (i = 0; i < bytes_read; i++)
+			poll_buf[i] = con_read_page[i];
+		return poll_buf[0];
+	}
+
+	return NO_POLL_CHAR;
+}
+
+
+static void sunhv_put_poll_char(struct uart_port *port,
+			 unsigned char c)
+{
+	while (1) {
+		long status = sun4v_con_putchar(c);
+		if (status = HV_EOK)
+			break;
+		udelay(1);
+	}
+}
+
+#endif /* CONFIG_CONSOLE_POLL */
+
 /* port->lock is not held.  */
 static int sunhv_startup(struct uart_port *port)
 {
@@ -388,6 +435,10 @@ static struct uart_ops sunhv_pops = {
 	.request_port	= sunhv_request_port,
 	.config_port	= sunhv_config_port,
 	.verify_port	= sunhv_verify_port,
+#ifdef CONFIG_CONSOLE_POLL
+	.poll_get_char = sunhv_get_poll_char,
+	.poll_put_char = sunhv_put_poll_char,
+#endif
 };
 
 static struct uart_driver sunhv_reg = {
-- 
1.6.4.rc1

