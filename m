From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 15 Jul 2016 11:17:33 +0000
Subject: [patch -old] sparc: serial: sunhv: fix a double lock bug
Message-Id: <20160715111733.GB13153@mwanda>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, sparclinux@vger.kernel.org, linux-serial@vger.kernel.org, kernel-janitors@vger.kernel.org

We accidentally take the "port->lock" twice in a row.  This old code
was supposed to be deleted.

Fixes: e58e241c1788 ('sparc: serial: Clean up the locking for -rt')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index ca0d380..4e603d0 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -490,12 +490,6 @@ static void sunhv_console_write_bychar(struct console *con, const char *s, unsig
 		locked = spin_trylock_irqsave(&port->lock, flags);
 	else
 		spin_lock_irqsave(&port->lock, flags);
-	if (port->sysrq) {
-		locked = 0;
-	} else if (oops_in_progress) {
-		locked = spin_trylock(&port->lock);
-	} else
-		spin_lock(&port->lock);
 
 	for (i = 0; i < n; i++) {
 		if (*s = '\n')
