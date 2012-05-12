From: David Miller <davem@davemloft.net>
Date: Sat, 12 May 2012 04:04:35 +0000
Subject: [PATCH] sparc32: Remove sun4c floppy assembler.
Message-Id: <20120512.000435.555735991523298219.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


There were two blocks of code for the two ways to twiddle
the terminal count pin in the AUXIO register, one for
sun4c and one for sun4m.  Kill the former.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/entry.S |   11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index b7a543c..1b87ea0 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -125,20 +125,11 @@ floppy_tdone:
 
 	set	sparc_cpu_model, %l5
 	ld	[%l5], %l5
-	subcc   %l5, 1, %g0		/* enum { sun4c = 1 }; */
-	be	1f
-	 ldub	[%l7], %l5
+	ldub	[%l7], %l5
 
 	or	%l5, 0xc2, %l5
 	stb	%l5, [%l7]
 	andn    %l5, 0x02, %l5
-	b	2f
-	 nop
-
-1:
-	or      %l5, 0xf4, %l5
-	stb     %l5, [%l7]
-	andn    %l5, 0x04, %l5
 
 2:
 	/* Kill some time so the bits set */
-- 
1.7.10

