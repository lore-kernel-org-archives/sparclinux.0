From: Dmitry Safonov <dima@arista.com>
Date: Fri, 13 Dec 2019 00:06:45 +0000
Subject: [PATCH 46/58] tty/serial: Migrate sunsab to use has_sysrq
Message-Id: <20191213000657.931618-47-dima@arista.com>
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
 drivers/tty/serial/sunsab.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sunsab.c b/drivers/tty/serial/sunsab.c
index 72131b5e132e..1eb703c980e0 100644
--- a/drivers/tty/serial/sunsab.c
+++ b/drivers/tty/serial/sunsab.c
@@ -40,10 +40,6 @@
 #include <asm/prom.h>
 #include <asm/setup.h>
 
-#if defined(CONFIG_SERIAL_SUNSAB_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/serial_core.h>
 #include <linux/sunserialcore.h>
 
@@ -985,6 +981,7 @@ static int sunsab_init_one(struct uart_sunsab_port *up,
 
 	up->port.fifosize = SAB82532_XMIT_FIFO_SIZE;
 	up->port.iotype = UPIO_MEM;
+	up->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_SUNSAB_CONSOLE);
 
 	writeb(SAB82532_IPC_IC_ACT_LOW, &up->regs->w.ipc);
 
-- 
2.24.0
