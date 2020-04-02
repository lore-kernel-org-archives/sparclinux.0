From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 02 Apr 2020 17:20:26 +0000
Subject: [PATCH v1] serial: sunhv: Initialize lock for non-registered console
Message-Id: <20200402172026.79478-1-andriy.shevchenko@linux.intel.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Anatoly Pugachev <matorola@gmail.com>, David Miller <davem@davemloft.net>

The commit a3cb39d258ef
("serial: core: Allow detach and attach serial device for console")
changed a bit logic behind lock initialization since for most of the console
driver it's supposed to have lock already initialized even if console is not
enabled. However, it's not the case for Sparc HV console.

Initialize lock explicitly in the ->probe().

Note, there is still an open question should or shouldn't not this driver
register console properly.

Fixes: a3cb39d258ef ("serial: core: Allow detach and attach serial device for console")
Reported-by: Anatoly Pugachev <matorola@gmail.com>
Cc: David Miller <davem@davemloft.net>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/tty/serial/sunhv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index eafada8fb6fa..e35073e93a5b 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -567,6 +567,9 @@ static int hv_probe(struct platform_device *op)
 	sunserial_console_match(&sunhv_console, op->dev.of_node,
 				&sunhv_reg, port->line, false);
 
+	/* We need to initialize lock even for non-registered console */
+	spin_lock_init(&port->lock);
+
 	err = uart_add_one_port(&sunhv_reg, port);
 	if (err)
 		goto out_unregister_driver;
-- 
2.25.1
