From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 11:43:49 +0000
Subject: [PATCH 4/4] sparc32: simpler cputype check in head_32.S
Message-Id: <1336823029-8206-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We know this is not a sun4/sun4c - as we checked earlier.
So no need to repeat the check.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/head_32.S |   34 +++++++++-------------------------
 1 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 17e00c1..9b2d43d 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -699,35 +699,26 @@ execute_in_high_mem:
 		ba continue_boot
 		 nop
 #endif
+
+/* Check to cputype. We may be booted on a sun4u (64 bit box),
+ * and sun4d needs special treatment.
+ */
+
 		set	cputypval, %o2
 		ldub	[%o2 + 0x4], %l1
 
-		cmp	%l1, ' '
-		be	no_sun4c_here
-		 cmp	%l1, 'c'
-		be	no_sun4c_here
-		 cmp	%l1, 'm'
-		be	1f
+		cmp	%l1, 'm'
+		be	sun4m_init
 		 cmp	%l1, 's'
-		be	1f
+		be	sun4m_init
 		 cmp	%l1, 'd'
-		be	1f
+		be	sun4d_init
 		 cmp	%l1, 'e'
 		be	no_sun4e_here		! Could be a sun4e.
 		 nop
 		b	no_sun4u_here		! AIEEE, a V9 sun4u... Get our BIG BROTHER kernel :))
 		 nop
 
-1:		set	cputypval, %l1
-		ldub	[%l1 + 0x4], %l1
-		cmp	%l1, 'd'		! Let us see how the beast will die
-		be	sun4d_init
-		 nop
-
-		/* If not sun4d assume sun4m */
-		b	sun4m_init
-		 nop
-
 /* CPUID in bootbus can be found at PA 0xff0140000 */
 #define SUN4D_BOOTBUS_CPUID     0xf0140000
 
@@ -1026,13 +1017,6 @@ continue_boot:
 		/* We should not get here. */
 		call	halt_me
 		 nop
-no_sun4c_here:
-		ld	[%g7 + 0x68], %o1
-		set	sun4c_notsup, %o0
-		call	%o1
-		 nop
-		b	halt_me
-		 nop
 
 no_sun4e_here:
 		ld	[%g7 + 0x68], %o1
-- 
1.6.0.6

