From: Dmitry Safonov <dima@arista.com>
Date: Fri, 13 Dec 2019 00:06:47 +0000
Subject: [PATCH 48/58] tty/serial: Migrate sunzilog to use has_sysrq
Message-Id: <20191213000657.931618-49-dima@arista.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20191213000657.931618-1-dima@arista.com>
In-Reply-To: <20191213000657.931618-1-dima@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Dmitry Safonov <0x7f454c46@gmail.com>, Dmitry Safonov <dima@arista.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Vasiliy Khoruzhick <vasilykh@arista.com>, linux-serial@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

The SUPPORT_SYSRQ ifdeffery is not nice as:
- May create misunderstanding about sizeof(struct uart_port) between
  different objects
- Prevents moving functions from serial_core.h
- Reduces readability (well, it's ifdeffery - it's hard to follow)

In order to remove SUPPORT_SYSRQ, has_sysrq variable has been added.
Initialise it in driver's probe and remove ifdeffery.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/tty/serial/sunzilog.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index bc7af8b08a72..103ab8c556e7 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -40,10 +40,6 @@
 #include <asm/prom.h>
 #include <asm/setup.h>
 
-#if defined(CONFIG_SERIAL_SUNZILOG_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/serial_core.h>
 #include <linux/sunserialcore.h>
 
@@ -1444,6 +1440,7 @@ static int zs_probe(struct platform_device *op)
 	up[0].port.line = (inst * 2) + 0;
 	up[0].port.dev = &op->dev;
 	up[0].flags |= SUNZILOG_FLAG_IS_CHANNEL_A;
+	up[0].port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_SUNZILOG_CONSOLE);
 	if (keyboard_mouse)
 		up[0].flags |= SUNZILOG_FLAG_CONS_KEYB;
 	sunzilog_init_hw(&up[0]);
@@ -1461,6 +1458,7 @@ static int zs_probe(struct platform_device *op)
 	up[1].port.line = (inst * 2) + 1;
 	up[1].port.dev = &op->dev;
 	up[1].flags |= 0;
+	up[1].port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_SUNZILOG_CONSOLE);
 	if (keyboard_mouse)
 		up[1].flags |= SUNZILOG_FLAG_CONS_MOUSE;
 	sunzilog_init_hw(&up[1]);
-- 
2.24.0
