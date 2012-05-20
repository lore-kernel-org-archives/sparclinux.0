From: David Miller <davem@davemloft.net>
Date: Sun, 20 May 2012 04:26:45 +0000
Subject: [PATCH] sparc32: Move GET_PROCESSOR*_ID() out of asm/asmmacro.h
Message-Id: <20120520.002645.365061001770997651.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


GET_PROCESSOR4D_ID is completely unused, so delete it.

Move GET_PROCESSOR4M_ID to the sun4m specific trap code
which uses it.

We now no longer need to include asm/asi.h

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/asmmacro.h |   10 ----------
 arch/sparc/kernel/entry.S         |    5 +++++
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/include/asm/asmmacro.h b/arch/sparc/include/asm/asmmacro.h
index 1d51161..02a172f 100644
--- a/arch/sparc/include/asm/asmmacro.h
+++ b/arch/sparc/include/asm/asmmacro.h
@@ -6,16 +6,6 @@
 #ifndef _SPARC_ASMMACRO_H
 #define _SPARC_ASMMACRO_H
 
-#include <asm/asi.h>
-
-#define GET_PROCESSOR4M_ID(reg) \
-	rd	%tbr, %reg; \
-	srl	%reg, 12, %reg; \
-	and	%reg, 3, %reg;
-
-#define GET_PROCESSOR4D_ID(reg) \
-	lda	[%g0] ASI_M_VIKING_TMP1, %reg;
-
 /* All trap entry points _must_ begin with this macro or else you
  * lose.  It makes sure the kernel has a proper window so that
  * c-code can be called.
diff --git a/arch/sparc/kernel/entry.S b/arch/sparc/kernel/entry.S
index 3f3976e..2dbe180 100644
--- a/arch/sparc/kernel/entry.S
+++ b/arch/sparc/kernel/entry.S
@@ -254,6 +254,11 @@ smp4m_ticker:
 	WRITE_PAUSE
 	RESTORE_ALL
 
+#define GET_PROCESSOR4M_ID(reg)	\
+	rd	%tbr, %reg;	\
+	srl	%reg, 12, %reg;	\
+	and	%reg, 3, %reg;
+
 	/* Here is where we check for possible SMP IPI passed to us
 	 * on some level other than 15 which is the NMI and only used
 	 * for cross calls.  That has a separate entry point below.
-- 
1.7.10

