From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Date: Sat, 27 Apr 2019 12:51:51 +0000
Subject: [PATCH 10/41] drivers: tty: serial: sb1250-duart: fix missing parentheses
Message-Id: <1556369542-13247-11-git-send-email-info@metux.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1556369542-13247-1-git-send-email-info@metux.net>
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org, linux-serial@vger.kernel.org, andrew@aj.id.au, gregkh@linuxfoundation.org, sudeep.holla@arm.com, liviu.dudau@arm.com, linux-mips@vger.kernel.org, vz@mleia.com, linux@prisktech.co.nz, sparclinux@vger.kernel.org, khilman@baylibre.com, macro@linux-mips.org, slemieux.tyco@gmail.com, matthias.bgg@gmail.com, jacmet@sunsite.dk, linux-amlogic@lists.infradead.org, andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

Fix checkpatch warning:

    ERROR: Macros with complex values should be enclosed in parentheses
    #911: FILE: drivers/tty/serial/sb1250-duart.c:911:
    +#define SERIAL_SB1250_DUART_CONSOLE	&sbd_console

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/sb1250-duart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 1184226..ec74f09 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -908,7 +908,7 @@ static int __init sbd_serial_console_init(void)
 
 console_initcall(sbd_serial_console_init);
 
-#define SERIAL_SB1250_DUART_CONSOLE	&sbd_console
+#define SERIAL_SB1250_DUART_CONSOLE	(&sbd_console)
 #else
 #define SERIAL_SB1250_DUART_CONSOLE	NULL
 #endif /* CONFIG_SERIAL_SB1250_DUART_CONSOLE */
-- 
1.9.1
