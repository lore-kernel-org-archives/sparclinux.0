From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 07 Aug 2015 18:34:12 +0000
Subject: [PATCH] sparc64: use ENTRY/ENDPROC in VISsave
Message-Id: <20150807183412.GA12019@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 7d8a508d74e6cacf0f2438286a959c3195a35a37 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 7 Aug 2015 20:26:12 +0200
Subject: [PATCH] sparc64: use ENTRY/ENDPROC in VISsave

Commit 44922150d87cef616fd183220d43d8fde4d41390
("sparc64: Fix userspace FPU register corruptions") left a
stale globl symbol which was not used.

Fix this and introduce use of ENTRY/ENDPROC

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

Noticed this while looking through the FPU fix patch.

	Sam


 arch/sparc/lib/VISsave.S | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/lib/VISsave.S b/arch/sparc/lib/VISsave.S
index a063d84..62c2647b 100644
--- a/arch/sparc/lib/VISsave.S
+++ b/arch/sparc/lib/VISsave.S
@@ -6,24 +6,23 @@
  * Copyright (C) 1998 Jakub Jelinek (jj@ultra.linux.cz)
  */
 
+#include <linux/linkage.h>
+
 #include <asm/asi.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
 #include <asm/visasm.h>
 #include <asm/thread_info.h>
 
-	.text
-	.globl		VISenter, VISenterhalf
-
 	/* On entry: %o5=current FPRS value, %g7 is callers address */
 	/* May clobber %o5, %g1, %g2, %g3, %g7, %icc, %xcc */
 
 	/* Nothing special need be done here to handle pre-emption, this
 	 * FPU save/restore mechanism is already preemption safe.
 	 */
-
+	.text
 	.align		32
-VISenter:
+ENTRY(VISenter)
 	ldub		[%g6 + TI_FPDEPTH], %g1
 	brnz,a,pn	%g1, 1f
 	 cmp		%g1, 1
@@ -79,3 +78,4 @@ vis1:	ldub		[%g6 + TI_FPSAVED], %g3
 	.align		32
 80:	jmpl		%g7 + %g0, %g0
 	 nop
+ENDPROC(VISenter)
-- 
2.1.0

