From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 17:12:13 +0000
Subject: [PATCH 01/24] sparc32: fix sparse warning in traps_32.c
Message-Id: <1398100356-19794-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:
traps_32.c:47:6: error: symbol 'die_if_kernel' redeclared with different type - different modifiers

Add __noreturn to both definition and declaration

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/bug.h | 2 +-
 arch/sparc/kernel/traps_32.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/bug.h b/arch/sparc/include/asm/bug.h
index 6bd9f43..8b50230 100644
--- a/arch/sparc/include/asm/bug.h
+++ b/arch/sparc/include/asm/bug.h
@@ -20,6 +20,6 @@ extern void do_BUG(const char *file, int line);
 #include <asm-generic/bug.h>
 
 struct pt_regs;
-extern void die_if_kernel(char *str, struct pt_regs *regs) __attribute__ ((noreturn));
+extern void __noreturn die_if_kernel(char *str, struct pt_regs *regs);
 
 #endif
diff --git a/arch/sparc/kernel/traps_32.c b/arch/sparc/kernel/traps_32.c
index 6629829..a655e5b 100644
--- a/arch/sparc/kernel/traps_32.c
+++ b/arch/sparc/kernel/traps_32.c
@@ -44,7 +44,7 @@ static void instruction_dump(unsigned long *pc)
 #define __SAVE __asm__ __volatile__("save %sp, -0x40, %sp\n\t")
 #define __RESTORE __asm__ __volatile__("restore %g0, %g0, %g0\n\t")
 
-void die_if_kernel(char *str, struct pt_regs *regs)
+void __noreturn die_if_kernel(char *str, struct pt_regs *regs)
 {
 	static int die_counter;
 	int count = 0;
-- 
1.8.3.1

