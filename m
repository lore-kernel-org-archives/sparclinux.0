From: "Enrico Weigelt, metux IT consult" <info@metux.net>
Date: Sat, 27 Apr 2019 12:51:55 +0000
Subject: [PATCH 14/41] drivers: tty: serial: uartlite: remove unnecessary braces
Message-Id: <1556369542-13247-15-git-send-email-info@metux.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1556369542-13247-1-git-send-email-info@metux.net>
In-Reply-To: <1556369542-13247-1-git-send-email-info@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: lorenzo.pieralisi@arm.com, linux-ia64@vger.kernel.org, linux-serial@vger.kernel.org, andrew@aj.id.au, gregkh@linuxfoundation.org, sudeep.holla@arm.com, liviu.dudau@arm.com, linux-mips@vger.kernel.org, vz@mleia.com, linux@prisktech.co.nz, sparclinux@vger.kernel.org, khilman@baylibre.com, macro@linux-mips.org, slemieux.tyco@gmail.com, matthias.bgg@gmail.com, jacmet@sunsite.dk, linux-amlogic@lists.infradead.org, andriy.shevchenko@linux.intel.com, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net

checkpatch complains:

    WARNING: braces {} are not necessary for any arm of this statement
    #489: FILE: drivers/tty/serial/uartlite.c:489:
    +	if (oops_in_progress) {
    [...]
    +	} else
    [...]

Signed-off-by: Enrico Weigelt <info@metux.net>
---
 drivers/tty/serial/uartlite.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/uartlite.c b/drivers/tty/serial/uartlite.c
index c322ab6..4c28600 100644
--- a/drivers/tty/serial/uartlite.c
+++ b/drivers/tty/serial/uartlite.c
@@ -486,9 +486,9 @@ static void ulite_console_write(struct console *co, const char *s,
 	unsigned int ier;
 	int locked = 1;
 
-	if (oops_in_progress) {
+	if (oops_in_progress)
 		locked = spin_trylock_irqsave(&port->lock, flags);
-	} else
+	else
 		spin_lock_irqsave(&port->lock, flags);
 
 	/* save and disable interrupt */
-- 
1.9.1
