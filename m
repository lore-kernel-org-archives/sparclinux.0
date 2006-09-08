From: Samuel Thibault <samuel.thibault@ens-lyon.org>
Date: Fri, 08 Sep 2006 00:06:02 +0000
Subject: [PATCH] no SA_NODEFER on sparc?
Message-Id: <20060908000602.GJ8569@bouh.residence.ens-lyon.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Hi,

I noticed that the sparc arch misses a definition for SA_NODEFER. Is
that on purpose?  If not, here is a patch for fixing this.

Add SA_NODEFER, deprecating linuxish SA_NOMASK.

Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

diff --git a/include/asm-sparc/signal.h b/include/asm-sparc/signal.h
index d03a21c..5484f65 100644
--- a/include/asm-sparc/signal.h
+++ b/include/asm-sparc/signal.h
@@ -133,16 +133,19 @@ #define _SV_IGNCHILD  8u    /* Do not se
  * the sigaction structure as a stack pointer. This is now possible due to
  * the changes in signal handling. LBT 010493.
  * SA_RESTART flag to get restarting signals (which were the default long ago)
+ * SA_NOMASK is the historical Linux name for the Single Unix name NODEFER.
  */
 #define SA_NOCLDSTOP	_SV_IGNCHILD
 #define SA_STACK	_SV_SSTACK
 #define SA_ONSTACK	_SV_SSTACK
 #define SA_RESTART	_SV_INTR
 #define SA_ONESHOT	_SV_RESET
-#define SA_NOMASK	0x20u
+#define SA_NODEFER	0x20u
 #define SA_NOCLDWAIT	0x100u
 #define SA_SIGINFO	0x200u
 
+#define SA_NOMASK	SA_NODEFER
+
 #define SIG_BLOCK          0x01	/* for blocking signals */
 #define SIG_UNBLOCK        0x02	/* for unblocking signals */
 #define SIG_SETMASK        0x04	/* for setting the signal mask */
diff --git a/include/asm-sparc64/signal.h b/include/asm-sparc64/signal.h
index 9968871..f40f2bc 100644
--- a/include/asm-sparc64/signal.h
+++ b/include/asm-sparc64/signal.h
@@ -134,16 +134,18 @@ #define _SV_IGNCHILD  8u    /* Do not se
  * the sigaction structure as a stack pointer. This is now possible due to
  * the changes in signal handling. LBT 010493.
  * SA_RESTART flag to get restarting signals (which were the default long ago)
+ * SA_NOMASK is the historical Linux name for the Single Unix name NODEFER.
  */
 #define SA_NOCLDSTOP	_SV_IGNCHILD
 #define SA_STACK	_SV_SSTACK
 #define SA_ONSTACK	_SV_SSTACK
 #define SA_RESTART	_SV_INTR
 #define SA_ONESHOT	_SV_RESET
-#define SA_NOMASK	0x20u
+#define SA_NODEFER	0x20u
 #define SA_NOCLDWAIT    0x100u
 #define SA_SIGINFO      0x200u
 
+#define SA_NOMASK	SA_NODEFER
 
 #define SIG_BLOCK          0x01	/* for blocking signals */
 #define SIG_UNBLOCK        0x02	/* for unblocking signals */
