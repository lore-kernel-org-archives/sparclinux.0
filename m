From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 04 Apr 2012 07:35:06 +0000
Subject: [PATCH v2] serial/sunzilog: fix keyboard on SUN SPARCstation
Message-Id: <20120404073506.GA10592@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The keyboard on my SUN SPARCstation 5 no longer worked.

    The culprint was: d4e33fac2408d37f7b52e80ca2a89f9fb482914f
    ("serial: Kill off NO_IRQ")

Fix up logic for no irq / irq so the keyboard works again.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

I assume the easy way is to channel this in via the sparc tree.
The bug was introduced in the merge window - so this is not a stable candidate.

v2: Fixed mail address of GregKH

	Sam

 drivers/tty/serial/sunzilog.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sunzilog.c b/drivers/tty/serial/sunzilog.c
index b3b70b0..babd947 100644
--- a/drivers/tty/serial/sunzilog.c
+++ b/drivers/tty/serial/sunzilog.c
@@ -1581,7 +1581,7 @@ static int __init sunzilog_init(void)
 	if (err)
 		goto out_unregister_uart;
 
-	if (!zilog_irq) {
+	if (zilog_irq) {
 		struct uart_sunzilog_port *up = sunzilog_irq_chain;
 		err = request_irq(zilog_irq, sunzilog_interrupt, IRQF_SHARED,
 				  "zs", sunzilog_irq_chain);
@@ -1622,7 +1622,7 @@ static void __exit sunzilog_exit(void)
 {
 	platform_driver_unregister(&zs_driver);
 
-	if (!zilog_irq) {
+	if (zilog_irq) {
 		struct uart_sunzilog_port *up = sunzilog_irq_chain;
 
 		/* Disable Interrupts */
-- 
1.6.0.6

--
To unsubscribe from this list: send the line "unsubscribe sparclinux" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

