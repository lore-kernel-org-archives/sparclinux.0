From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 May 2014 22:52:18 +0000
Subject: [PATCH 13/34] sparc64: fix sparse warning in traps_64.c
Message-Id: <1399157559-19901-13-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:
traps_64.c:2384:6: error: symbol 'die_if_kernel' redeclared with different type (originally declared at include/asm/bug.h:23) - different modifiers

Add proper __noreturn to the implementation to fix this

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/traps_64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 4d7e12d..86484704 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2381,7 +2381,7 @@ static inline struct reg_window *kernel_stack_up(struct reg_window *rw)
 	return (struct reg_window *) (fp + STACK_BIAS);
 }
 
-void die_if_kernel(char *str, struct pt_regs *regs)
+void __noreturn die_if_kernel(char *str, struct pt_regs *regs)
 {
 	static int die_counter;
 	int count = 0;
-- 
1.9.0

