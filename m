From: David Miller <davem@davemloft.net>
Date: Thu, 25 Sep 2014 19:41:11 +0000
Subject: [PATCH 3/6] sparc64: Fix hibernation code refrence to PAGE_OFFSET.
Message-Id: <20140925.154111.539959250566101066.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


We changed PAGE_OFFSET to be a variable rather than a constant,
but this reference here in the hibernate assembler got missed.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/power/hibernate_asm.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/power/hibernate_asm.S b/arch/sparc/power/hibernate_asm.S
index 7994216..d7d9017 100644
--- a/arch/sparc/power/hibernate_asm.S
+++ b/arch/sparc/power/hibernate_asm.S
@@ -54,8 +54,8 @@ ENTRY(swsusp_arch_resume)
 	 nop
 
 	/* Write PAGE_OFFSET to %g7 */
-	sethi	%uhi(PAGE_OFFSET), %g7
-	sllx	%g7, 32, %g7
+	sethi	%hi(PAGE_OFFSET), %g7
+	ldx	[%g7 + %lo(PAGE_OFFSET)], %g7
 
 	setuw	(PAGE_SIZE-8), %g3
 
-- 
1.8.1.2

