From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 04 Apr 2012 07:28:07 +0000
Subject: [PATCH] serial/sunzilog: fix keyboard on SUN SPARCstation
Message-Id: <20120404072807.GA10041@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 360d177dd8c19f23a26371d4e9337a46a1cde779 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Wed, 4 Apr 2012 09:00:11 +0200
Subject: [PATCH] serial/sunzilog: fix keyboard on SUN sparcstation

The keyboard on my SUN SPARCstation 5 no longer worked.

    The culprint was: d4e33fac2408d37f7b52e80ca2a89f9fb482914f
    ("serial: Kill off NO_IRQ")

Fix up logic for no irq / irq so the keyboard works again.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@suse.de>
---

I assume the easy way is to channel this in via the sparc tree.
The bug was introduced in the merge window - so this is not a stable candidate.

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

