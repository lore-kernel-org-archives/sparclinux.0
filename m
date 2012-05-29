From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 29 May 2012 18:14:13 +0000
Subject: [PATCH 2/3] sparc32: remove unused variable in head_32.S
Message-Id: <1338315254-3829-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

It was assigned, but never referenced later.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/head_32.S |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 5364a05..afeb1d7 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -30,10 +30,6 @@
  * the cpu-type
  */
 	.align 4
-cputyp:
-        .word   1
-
-	.align 4
 	.globl cputypval
 cputypval:
 	.asciz "sun4m"
@@ -509,10 +505,6 @@ continue_boot:
 /* Aieee, now set PC and nPC, enable traps, give ourselves a stack and it's
  * show-time!
  */
-
-		sethi	%hi(cputyp), %o0
-		st	%g4, [%o0 + %lo(cputyp)]
-
 		/* Turn on Supervisor, EnableFloating, and all the PIL bits.
 		 * Also puts us in register window zero with traps off.
 		 */
-- 
1.6.0.6

