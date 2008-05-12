From: Robert Reif <reif@earthlink.net>
Date: Mon, 12 May 2008 00:45:46 +0000
Subject: [PATCH] sparc32: fix rtrap.S typo
Message-Id: <4827933A.90507@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000300020204020505070102"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------000300020204020505070102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Fix compile problem in rtrap.S

arch/sparc/kernel/built-in.o: In function `ret_trap_userwins_ok':
arch/sparc/kernel/rtrap.S:(.text+0x1900): undefined reference to 
`PSR_SYCALL'

Signed-off-by: Robert Reif <reif@earthlink.net>

--------------000300020204020505070102
Content-Type: text/plain;
 name="rtrap.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rtrap.diff.txt"

diff --git a/arch/sparc/kernel/rtrap.S b/arch/sparc/kernel/rtrap.S
index b27b5b5..ab818cd 100644
--- a/arch/sparc/kernel/rtrap.S
+++ b/arch/sparc/kernel/rtrap.S
@@ -139,7 +139,7 @@ ret_trap_userwins_ok:
 	LOAD_PT_PRIV(sp, t_psr, t_pc, t_npc)
 	or	%t_pc, %t_npc, %g2
 	andcc	%g2, 0x3, %g0
-	sethi	%hi(PSR_SYCALL), %g2
+	sethi	%hi(PSR_SYSCALL), %g2
 	be	1f
 	 andn	%t_psr, %g2, %t_psr
 

--------------000300020204020505070102--
