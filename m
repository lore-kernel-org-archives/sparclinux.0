From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 06 Nov 2004 23:34:49 +0000
Subject: sunzilog possible bug
Message-Id: <1099784090.10262.112.camel@gaston>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi !

I found recently a bug in pmac_zilog, which originates from sunzilog who so might
have the same problem. The "timeout" member of the port structure was never
initialized, causing very long pauses to happen on port close, that is pretty much
all the time when hitting userland.

Quick untested patch (I don't have a sparc)

=== drivers/serial/sunzilog.c 1.46 vs edited ==--- 1.46/drivers/serial/sunzilog.c	2004-09-21 06:46:03 +10:00
+++ edited/drivers/serial/sunzilog.c	2004-11-07 10:05:37 +11:00
@@ -974,6 +974,8 @@
 
 	sunzilog_maybe_update_regs(up, ZILOG_CHANNEL_FROM_PORT(port));
 
+	uart_update_timeout(port, termios->c_cflag, baud);
+
 	spin_unlock_irqrestore(&up->port.lock, flags);
 }
 



