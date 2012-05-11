From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 11 May 2012 21:35:07 +0000
Subject: [PATCH 04/14] sparc32: drop sun4c specific ___xchg32 implementation
Message-Id: <1336772117-1539-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/lib/atomic_32.S |   20 --------------------
 1 files changed, 0 insertions(+), 20 deletions(-)

diff --git a/arch/sparc/lib/atomic_32.S b/arch/sparc/lib/atomic_32.S
index eb6c735..e2a9085 100644
--- a/arch/sparc/lib/atomic_32.S
+++ b/arch/sparc/lib/atomic_32.S
@@ -13,26 +13,6 @@
 __atomic_begin:
 
 #ifndef CONFIG_SMP
-	.globl	___xchg32_sun4c
-___xchg32_sun4c:
-	rd	%psr, %g3
-	andcc	%g3, PSR_PIL, %g0
-	bne	1f
-	 nop
-	wr	%g3, PSR_PIL, %psr
-	nop; nop; nop
-1:
-	andcc	%g3, PSR_PIL, %g0
-	ld	[%g1], %g7
-	bne	1f
-	 st	%g2, [%g1]
-	wr	%g3, 0x0, %psr
-	nop; nop; nop
-1:
-	mov	%g7, %g2
-	jmpl	%o7 + 8, %g0
-	 mov	%g4, %o7
-
 	.globl	___xchg32_sun4md
 ___xchg32_sun4md:
 	swap	[%g1], %g2
-- 
1.6.0.6

