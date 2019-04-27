From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Date: Sat, 27 Apr 2019 12:51:48 +0000
Subject: [PATCH 07/41] drivers: tty: serial: sb1250-duart: include <linux/io.h> instead of <asm/io.h>
Message-Id: <1556369542-13247-8-git-send-email-info@metux.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1556369542-13247-1-git-send-email-info@metux.net>
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org, linux-serial@vger.kernel.org, andrew@aj.id.au, gregkh@linuxfoundation.org, sudeep.holla@arm.com, liviu.dudau@arm.com, linux-mips@vger.kernel.org, vz@mleia.com, linux@prisktech.co.nz, sparclinux@vger.kernel.org, khilman@baylibre.com, macro@linux-mips.org, slemieux.tyco@gmail.com, matthias.bgg@gmail.com, jacmet@sunsite.dk, linux-amlogic@lists.infradead.org, andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

Fix checkpatch warning:

    WARNING: Use #include <linux/io.h> instead of <asm/io.h>
    #41: FILE: drivers/tty/serial/sb1250-duart.c:41:
    +#include <asm/io.h>

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/sb1250-duart.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sb1250-duart.c b/drivers/tty/serial/sb1250-duart.c
index 655961c..b4342c8 100644
--- a/drivers/tty/serial/sb1250-duart.c
+++ b/drivers/tty/serial/sb1250-duart.c
@@ -38,7 +38,7 @@
 #include <linux/types.h>
 
 #include <linux/refcount.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include <asm/war.h>
 
 #include <asm/sibyte/sb1250.h>
-- 
1.9.1
