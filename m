From: "David S. Miller" <davem@redhat.com>
Date: Thu, 26 Aug 2004 06:32:47 +0000
Subject: [PATCH] SunSAB console problems in 2.6.x
Message-Id: <20040825233247.237c1fb1.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Does this make the garbled (every other char missing) console
problem go away?

It isn't the best fix, and if this hack fix works I'll work on
the real cure.

Thanks.

=== drivers/serial/sunsab.c 1.33 vs edited ==--- 1.33/drivers/serial/sunsab.c	2004-05-30 17:43:04 -07:00
+++ edited/drivers/serial/sunsab.c	2004-08-25 23:14:30 -07:00
@@ -940,6 +940,7 @@
 	writeb(up->interrupt_mask1, &up->regs->w.imr1);
 
 	sunsab_convert_to_sab(up, con->cflag, 0, baud);
+	sunsab_set_mctrl(&up->port, TIOCM_DTR | TIOCM_RTS);
 
 	spin_unlock_irqrestore(&up->port.lock, flags);
 	
