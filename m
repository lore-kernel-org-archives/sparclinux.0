From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 30 Mar 2012 14:13:24 +0000
Subject: [PATCH] sparc32: fix fallout from system.h removal
Message-Id: <20120330141324.GA7195@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From 26f7506bc6b2184c925534ed3e006dd0937b8147 Mon Sep 17 00:00:00 2001
From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 30 Mar 2012 15:53:50 +0200
Subject: [PATCH] sparc32: fix fallout from system.h removal

Build failures for the typical configs I use

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/ptrace.h |    1 +
 arch/sparc/kernel/sun4d_smp.c   |    1 +
 arch/sparc/kernel/sun4m_smp.c   |    1 +
 3 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/ptrace.h b/arch/sparc/include/asm/ptrace.h
index 9835adc..fd9c3f2 100644
--- a/arch/sparc/include/asm/ptrace.h
+++ b/arch/sparc/include/asm/ptrace.h
@@ -241,6 +241,7 @@ extern unsigned long profile_pc(struct pt_regs *);
 #ifndef __ASSEMBLY__
 
 #ifdef __KERNEL__
+#include <asm/switch_to.h>
 
 static inline bool pt_regs_is_syscall(struct pt_regs *regs)
 {
diff --git a/arch/sparc/kernel/sun4d_smp.c b/arch/sparc/kernel/sun4d_smp.c
index 1333879..540b2fe 100644
--- a/arch/sparc/kernel/sun4d_smp.c
+++ b/arch/sparc/kernel/sun4d_smp.c
@@ -14,6 +14,7 @@
 #include <asm/sbi.h>
 #include <asm/mmu.h>
 #include <asm/tlbflush.h>
+#include <asm/switch_to.h>
 #include <asm/cacheflush.h>
 
 #include "kernel.h"
diff --git a/arch/sparc/kernel/sun4m_smp.c b/arch/sparc/kernel/sun4m_smp.c
index 5947686..02db9a0 100644
--- a/arch/sparc/kernel/sun4m_smp.c
+++ b/arch/sparc/kernel/sun4m_smp.c
@@ -10,6 +10,7 @@
 #include <linux/cpu.h>
 
 #include <asm/cacheflush.h>
+#include <asm/switch_to.h>
 #include <asm/tlbflush.h>
 
 #include "irq.h"
-- 
1.6.0.6

