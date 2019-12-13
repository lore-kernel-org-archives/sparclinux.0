From: Dmitry Safonov <dima@arista.com>
Date: Fri, 13 Dec 2019 00:06:46 +0000
Subject: [PATCH 47/58] tty/serial: Migrate sunsu to use has_sysrq
Message-Id: <20191213000657.931618-48-dima@arista.com>
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
 drivers/tty/serial/sunsu.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/tty/serial/sunsu.c b/drivers/tty/serial/sunsu.c
index 4db6aaa330b2..8ce9a7a256e5 100644
--- a/drivers/tty/serial/sunsu.c
+++ b/drivers/tty/serial/sunsu.c
@@ -44,10 +44,6 @@
 #include <asm/prom.h>
 #include <asm/setup.h>
 
-#if defined(CONFIG_SERIAL_SUNSU_CONSOLE) && defined(CONFIG_MAGIC_SYSRQ)
-#define SUPPORT_SYSRQ
-#endif
-
 #include <linux/serial_core.h>
 #include <linux/sunserialcore.h>
 
@@ -1475,6 +1471,7 @@ static int su_probe(struct platform_device *op)
 
 	up->port.type = PORT_UNKNOWN;
 	up->port.uartclk = (SU_BASE_BAUD * 16);
+	up->port.has_sysrq = IS_ENABLED(CONFIG_SERIAL_SUNSU_CONSOLE);
 
 	err = 0;
 	if (up->su_type = SU_PORT_KBD || up->su_type = SU_PORT_MS) {
-- 
2.24.0
