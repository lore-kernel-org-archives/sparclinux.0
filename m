From: David Ahern <david.ahern@oracle.com>
Date: Mon, 15 Jun 2015 20:15:46 +0000
Subject: [PATCH 4/4] sparc64: perf: Use UREG_FP rather than UREG_I6
Message-Id: <1434399346-21665-5-git-send-email-david.ahern@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

perf walks userspace callchains by following frame pointers. Use the
UREG_FP macro to make it clearer that the %fp is being used.

Signed-off-by: David Ahern <david.ahern@oracle.com>
---
 arch/sparc/kernel/perf_event.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index a665e3f8c6c6..689db65f8529 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -1756,7 +1756,7 @@ static void perf_callchain_user_64(struct perf_callchain_entry *entry,
 {
 	unsigned long ufp;
 
-	ufp = regs->u_regs[UREG_I6] + STACK_BIAS;
+	ufp = regs->u_regs[UREG_FP] + STACK_BIAS;
 	do {
 		struct sparc_stackf __user *usf;
 		struct sparc_stackf sf;
@@ -1780,7 +1780,7 @@ static void perf_callchain_user_32(struct perf_callchain_entry *entry,
 {
 	unsigned long ufp;
 
-	ufp = regs->u_regs[UREG_I6] & 0xffffffffUL;
+	ufp = regs->u_regs[UREG_FP] & 0xffffffffUL;
 	do {
 		unsigned long pc;
 
-- 
2.3.0

