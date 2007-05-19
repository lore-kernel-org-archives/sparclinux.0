From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Sat, 19 May 2007 17:37:22 +0000
Subject: [PATCH] sunzilog: section mismatch fix
Message-Id: <465089A2.4080401@wp.pl>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes section mismatch warnings in the sunzilog driver.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

Diff-ed agains 2.6.22-rc2

--- linux-2.6.21/drivers/serial/sunzilog.c	2007-05-20 18:45:03.687231937 +0200
+++ linux-2.6.21.new/drivers/serial/sunzilog.c	2007-05-20 19:43:00.297352656 +0200
@@ -1239,7 +1239,7 @@ static inline struct console *SUNZILOG_C
  #define SUNZILOG_CONSOLE()	(NULL)
  #endif

-static void __init sunzilog_init_kbdms(struct uart_sunzilog_port *up, int channel)
+static void __devinit sunzilog_init_kbdms(struct uart_sunzilog_port *up, int channel)
  {
  	int baud, brg;

@@ -1259,7 +1259,7 @@ static void __init sunzilog_init_kbdms(s
  }

  #ifdef CONFIG_SERIO
-static void __init sunzilog_register_serio(struct uart_sunzilog_port *up)
+static void __devinit sunzilog_register_serio(struct uart_sunzilog_port *up)
  {
  	struct serio *serio = &up->serio;

