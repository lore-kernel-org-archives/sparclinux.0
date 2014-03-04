From: David Miller <davem@davemloft.net>
Date: Tue, 04 Mar 2014 19:10:03 +0000
Subject: Re: [PATCH 3/4] sparc64: convert spinlock_t to raw_spinlock_t in mmu_context_t
Message-Id: <20140304.141003.1969905483115684548.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <359241392801938@web24j.yandex.ru>
	<530D9D1C.1060905@oracle.com>
	<39171393599083@web13h.yandex.ru>
In-Reply-To: <39171393599083@web13h.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tkhai@yandex.ru
Cc: allen.pais@oracle.com, linux-rt-users@vger.kernel.org, sparclinux@vger.kernel.org, bigeasy@linutronix.de

From: Kirill Tkhai <tkhai@yandex.ru>
Date: Fri, 28 Feb 2014 18:51:23 +0400

> This should be fixed like that's done for 8250
> [patch drivers-serial-cleanup-locking-for-rt.patch]

Like the patch below?

Is this transformation legitimate outside of the -rt tree?  I wish the commit
messages for the 8250 change was more verbose, explaining exactly why this
is needed.

And if it's needed, all the sparc serial/console drivers need this too.

diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index cf86e72..dc697ce 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -433,13 +433,10 @@ static void sunhv_console_write_paged(struct console *con, const char *s, unsign
 	unsigned long flags;
 	int locked = 1;
 
-	local_irq_save(flags);
-	if (port->sysrq) {
-		locked = 0;
-	} else if (oops_in_progress) {
-		locked = spin_trylock(&port->lock);
-	} else
-		spin_lock(&port->lock);
+	if (port->sysrq || oops_in_progress)
+		locked = spin_trylock_irqsave(&port->lock, flags);
+	else
+		spin_lock_irqsave(&port->lock, flags);
 
 	while (n > 0) {
 		unsigned long ra = __pa(con_write_page);
@@ -470,8 +467,7 @@ static void sunhv_console_write_paged(struct console *con, const char *s, unsign
 	}
 
 	if (locked)
-		spin_unlock(&port->lock);
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static inline void sunhv_console_putchar(struct uart_port *port, char c)
@@ -492,7 +488,10 @@ static void sunhv_console_write_bychar(struct console *con, const char *s, unsig
 	unsigned long flags;
 	int i, locked = 1;
 
-	local_irq_save(flags);
+	if (port->sysrq || oops_in_progress)
+		locked = spin_trylock_irqsave(&port->lock, flags);
+	else
+		spin_lock_irqsave(&port->lock, flags);
 	if (port->sysrq) {
 		locked = 0;
 	} else if (oops_in_progress) {
@@ -507,8 +506,7 @@ static void sunhv_console_write_bychar(struct console *con, const char *s, unsig
 	}
 
 	if (locked)
-		spin_unlock(&port->lock);
-	local_irq_restore(flags);
+		spin_unlock_irqrestore(&port->lock, flags);
 }
 
 static struct console sunhv_console = {
