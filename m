From: Adrien Mazarguil <maz@p0d.org>
Date: Sun, 07 Nov 2010 13:20:51 +0000
Subject: [PATCH] sparc64: Netra AX1105 loses console output while booting
Message-Id: <20101107132051.GE19881@here>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi list,

While trying recent kernels on a Sun Netra AX1105 board, I noticed that the
boot process stopped before init had a chance to run. Using git bisect, I
narrowed this regression down to that commit:

25edd6946a1d74e5e77813c2324a0908c68bcf9e is the first bad commit
commit 25edd6946a1d74e5e77813c2324a0908c68bcf9e
Author: David S. Miller <davem@davemloft.net>
Date:   Mon Aug 23 23:10:57 2010 -0700

    sparc64: Get rid of indirect p1275 PROM call buffer.

I already sent this information to David but since did additional testing.

On this board, the new prom_nbputchar() fails at some point in the boot
process and no subsequent output is shown. Using either the older function
in place of this one or a static buffer solve that issue. This seems related
to this paragraph in the above commit log:

    The reasoning behind the temporary buffer is entirely historical.  It
    used to be the case that we had problems referencing dynamic kernel
    memory (including the stack) early in the boot process before we
    explicitly told the firwmare to switch us over to the kernel trap
    table.

Looks like it is still required by older boards, or maybe something else
needs to be fixed? This is strange because everything works fine until the
first call to schedule() just before the last assembly part of switch_to()
macro.

diff --git a/arch/sparc/prom/console_64.c b/arch/sparc/prom/console_64.c
index 10322dc..fe2a7c0 100644
--- a/arch/sparc/prom/console_64.c
+++ b/arch/sparc/prom/console_64.c
@@ -22,7 +22,7 @@ inline int
 prom_nbgetchar(void)
 {
	unsigned long args[7];
-	char inc;
+	static char inc;
 
	args[0] = (unsigned long) "read";
 	args[1] = 3;
@@ -46,8 +46,8 @@ inline int
 prom_nbputchar(char c)
 {
	unsigned long args[7];
-	char outc;
-	
+	static char outc;
+
	outc = c;
 
	args[0] = (unsigned long) "write";
@@ -62,8 +62,7 @@ prom_nbputchar(char c)
 
	if (args[6] = 1)
 	   return 0;
-	   else
-		return -1;
+		return -1;
 }
 
 /* Blocking version of get character routine above. */

-- 
Adrien Mazarguil
