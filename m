From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 09 Jul 2005 02:41:51 +0000
Subject: [PATCH] panic on sparc32 in tty_wakeup on shutdown
Message-Id: <Pine.LNX.4.61.0507082223570.3006@bobcat>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

The panic in tty_wakeup panic on shutdown, triggered on sparc32 with 
pristine kernels, is not present in Debian kernels. It turns out that the 
following patch (which I was not aware of) has been used in Debian for a 
while now to take care of that problem:

---------------------------cut here--------------------------------
--- kernel-source-2.6.11-2.6.11-orig/drivers/serial/serial_core.c	2005-03-02 08:37:50.000000000 +0100
+++ kernel-source-2.6.11-2.6.11/drivers/serial/serial_core.c	2005-03-05 10:46:43.417109240 +0100
@@ -108,7 +108,8 @@
  static void uart_tasklet_action(unsigned long data)
  {
  	struct uart_state *state = (struct uart_state *)data;
-	tty_wakeup(state->info->tty);
+	if (state->info->tty)
+		tty_wakeup(state->info->tty);
  }

  static inline void
---------------------------cut here--------------------------------

As I understand it, the cause of the problem is a race condition, with 
state->info->tty being destroyed somewhere between scheduling of the 
tasklet and its execution. This patch is not a proper solution, as it does 
not eliminate the source of the race, but hopefully it can provide the 
insight needed to fix the problem.

Best regards,

Jurij Smakov                                        jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                   KeyID: C99E03CC
