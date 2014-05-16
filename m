From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:26:10 +0000
Subject: [PATCH 32/34] sparc64: fix sparse warning in kprobes.c
Message-Id: <1400275572-17424-32-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1399157559-19901-32-git-send-email-sam@ravnborg.org>
In-Reply-To: <1399157559-19901-32-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warning:
kprobes.c:419:27: warning: symbol 'kprobe_trap' was not declared. Should it be static?

Add proper prototype

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/include/asm/kprobes.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/sparc/include/asm/kprobes.h b/arch/sparc/include/asm/kprobes.h
index b2613c28..a145d79 100644
--- a/arch/sparc/include/asm/kprobes.h
+++ b/arch/sparc/include/asm/kprobes.h
@@ -46,4 +46,6 @@ struct kprobe_ctlblk {
 int kprobe_exceptions_notify(struct notifier_block *self,
 			     unsigned long val, void *data);
 int kprobe_fault_handler(struct pt_regs *regs, int trapnr);
+asmlinkage void __kprobes kprobe_trap(unsigned long trap_level,
+				      struct pt_regs *regs);
 #endif /* _SPARC64_KPROBES_H */
-- 
1.9.0

