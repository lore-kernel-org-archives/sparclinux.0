From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>
Date: Sun, 03 Aug 2014 14:01:53 +0000
Subject: [PATCH] sunsab: Fix detection of BREAK on sunsab serial console
Message-Id: <201408031601.53597.cat.schulze@alice-dsl.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>

Fix detection of BREAK on sunsab serial console: BREAK detection was only
performed when there were also serial characters received simultaneously.
To handle all BREAKs correctly, the check for BREAK and the corresponding
call to uart_handle_break() must also be done if count = 0, therefore
duplicate this code fragment and pull it out of the loop over the received
characters.

Patch applies to 3.16-rc6.

Signed-off-by: Christopher Alexander Tobias Schulze <cat.schulze@alice-dsl.net>

---

diff -Naupr linux-3.16-rc6-orig/drivers/tty/serial/sunsab.c linux-3.16-rc6-patched/drivers/tty/serial/sunsab.c
--- linux-3.16-rc6-orig/drivers/tty/serial/sunsab.c	2014-07-27 11:50:32.000000000 +0200
+++ linux-3.16-rc6-patched/drivers/tty/serial/sunsab.c	2014-08-03 15:59:41.000000000 +0200
@@ -157,6 +157,15 @@ receive_chars(struct uart_sunsab_port *u
 	    (up->port.line = up->port.cons->index))
 		saw_console_brk = 1;
 
+	if (count = 0) {
+		if (unlikely(stat->sreg.isr1 & SAB82532_ISR1_BRK)) {
+			stat->sreg.isr0 &= ~(SAB82532_ISR0_PERR |
+					     SAB82532_ISR0_FERR);
+			up->port.icount.brk++;
+			uart_handle_break(&up->port);
+		}
+	}
+
 	for (i = 0; i < count; i++) {
 		unsigned char ch = buf[i], flag;
 
