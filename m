From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 07 May 2013 09:55:55 +0000
Subject: [PATCH 1/3] sparc: Switch to asm-generic/linkage.h
Message-Id: <1367920555-18544-1-git-send-email-geert@linux-m68k.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/sparc/include/asm/Kbuild    |    1 +
 arch/sparc/include/asm/linkage.h |    6 ------
 2 files changed, 1 insertions(+), 6 deletions(-)
 delete mode 100644 arch/sparc/include/asm/linkage.h

diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
index ff18e3c..7e4a97f 100644
--- a/arch/sparc/include/asm/Kbuild
+++ b/arch/sparc/include/asm/Kbuild
@@ -6,6 +6,7 @@ generic-y += cputime.h
 generic-y += div64.h
 generic-y += emergency-restart.h
 generic-y += exec.h
+generic-y += linkage.h
 generic-y += local64.h
 generic-y += mutex.h
 generic-y += irq_regs.h
diff --git a/arch/sparc/include/asm/linkage.h b/arch/sparc/include/asm/linkage.h
deleted file mode 100644
index 291c2d0..0000000
--- a/arch/sparc/include/asm/linkage.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef __ASM_LINKAGE_H
-#define __ASM_LINKAGE_H
-
-/* Nothing to see here... */
-
-#endif
-- 
1.7.0.4

