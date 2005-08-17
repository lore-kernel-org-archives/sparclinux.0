From: Martin Habets <errandir_news@mph.eclipse.co.uk>
Date: Wed, 17 Aug 2005 20:53:45 +0000
Subject: [PATCH 1/2] Enable magic SysRq key on SunZilog serial console
Message-Id: <20050817205345.GA9337@palantir8>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch against 2.6.10 enables the Magic SysRq commands on a SunZilog
serial console.
SysRq is activated by sending a BREAK. Send a command within 5 seconds.

You may notice from the patch below that the code replaces the call to
OpenBoot prompt. The 2nd part of this patch (send separately) resolves this
issue.

It seems to me that all the BRK_ABRT handling in sunzilog_receive_chars()
never gets executed, and could be cleaned up. Can anyone confirm/deny
this?

Martin

	Signed-off-by: Martin Habets <errandir_news@mph.eclipse.co.uk>

--- linux-2.6/drivers/serial/sunzilog.c.orig	2005-08-17 18:35:32.000000000 +0100
+++ linux-2.6/drivers/serial/sunzilog.c	2005-08-17 20:10:38.000000000 +0100
@@ -397,7 +397,7 @@
 			else if (r1 & CRC_ERR)
 				*tty->flip.flag_buf_ptr = TTY_FRAME;
 		}
-		if (uart_handle_sysrq_char(&up->port, ch, regs))
+		if (ch && uart_handle_sysrq_char(&up->port, ch, regs))
 			continue;
 
 		if (up->port.ignore_status_mask = 0xff ||
@@ -444,7 +444,12 @@
 				if (!(status & BRK_ABRT))
 					break;
 			}
+#ifdef SUPPORT_SYSRQ
+			up->port.icount.brk++;
+			uart_handle_break(&up->port);
+#else
 			sun_do_break();
+#endif
 			return;
 		}
 	}
