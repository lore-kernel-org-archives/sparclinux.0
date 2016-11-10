From: Vijay Kumar <vijay.ac.kumar@oracle.com>
Date: Thu, 10 Nov 2016 22:43:35 +0000
Subject: [PATCH 3/4] sparc64: Send break twice from console to return to boot prom
Message-Id: <1478817816-98939-3-git-send-email-vijay.ac.kumar@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1478817816-98939-1-git-send-email-vijay.ac.kumar@oracle.com>
In-Reply-To: <1478817816-98939-1-git-send-email-vijay.ac.kumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, sparclinux@vger.kernel.org
Cc: karl.volz@oracle.com, rob.gardner@oracle.com, linux-kernel@vger.kernel.org

Now we can also jump to boot prom from sunhv console by sending
break twice on console for both running and panicked kernel
cases.

Signed-off-by: Vijay Kumar <vijay.ac.kumar@oracle.com>
---
 drivers/tty/serial/sunhv.c |    6 +++++-
 kernel/panic.c             |    3 ++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index 59828d8..33c35b4 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -116,7 +116,7 @@ static int receive_chars_getchar(struct uart_port *port)
 
 static int receive_chars_read(struct uart_port *port)
 {
-	int saw_console_brk = 0;
+	static int saw_console_brk;
 	int limit = 10000;
 
 	while (limit-- > 0) {
@@ -128,6 +128,9 @@ static int receive_chars_read(struct uart_port *port)
 			bytes_read = 0;
 
 			if (stat = CON_BREAK) {
+				if (saw_console_brk)
+					sun_do_break();
+
 				if (uart_handle_break(port))
 					continue;
 				saw_console_brk = 1;
@@ -151,6 +154,7 @@ static int receive_chars_read(struct uart_port *port)
 		if (port->sysrq != 0 &&  *con_read_page) {
 			for (i = 0; i < bytes_read; i++)
 				uart_handle_sysrq_char(port, con_read_page[i]);
+			saw_console_brk = 0;
 		}
 
 		if (port->state = NULL)
diff --git a/kernel/panic.c b/kernel/panic.c
index ca8cea1..4fe3b28 100644
--- a/kernel/panic.c
+++ b/kernel/panic.c
@@ -240,7 +240,8 @@ void panic(const char *fmt, ...)
 		extern int stop_a_enabled;
 		/* Make sure the user can actually press Stop-A (L1-A) */
 		stop_a_enabled = 1;
-		pr_emerg("Press Stop-A (L1-A) to return to the boot prom\n");
+		pr_emerg("Press Stop-A (L1-A) from sun keyboard or send break\n"
+			 "twice on console to return to the boot prom\n");
 	}
 #endif
 #if defined(CONFIG_S390)
-- 
1.7.1

