From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 12 May 2012 11:43:47 +0000
Subject: [PATCH 2/4] sparc32: drop prom version check in head_32.S
Message-Id: <1336823029-8206-2-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

We already sorted out if we are a sun4/sun4c and halted.
So no need to check the prom version as we know this is
a v2 or v3 as sun4m, sun4d etc. does not use a v1 prom.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/head_32.S |   13 -------------
 1 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/arch/sparc/kernel/head_32.S b/arch/sparc/kernel/head_32.S
index 10830b5..56e32a2 100644
--- a/arch/sparc/kernel/head_32.S
+++ b/arch/sparc/kernel/head_32.S
@@ -675,19 +675,6 @@ execute_in_high_mem:
 		sethi	%hi(linux_dbvec), %g1
 		st	%o1, [%g1 + %lo(linux_dbvec)]
 
-		ld	[%o0 + 0x4], %o3
-		and	%o3, 0x3, %o5			! get the version
-
-		cmp	%o3, 0x2			! a v2 prom?
-		be	found_version
-		 nop
-
-		/* paul@sfe.com.au */
-		cmp	%o3, 0x3			! a v3 prom?
-		be	found_version
-		 nop
-
-found_version:
 /* Get the machine type via the mysterious romvec node operations. */
 
 		add	%g7, 0x1c, %l1		
-- 
1.6.0.6

