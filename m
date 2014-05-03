From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 May 2014 22:52:30 +0000
Subject: [PATCH 25/34] sparc64: fix sparse warnings in kprobes.c
Message-Id: <1399157559-19901-25-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
kprobes.c:515:15: warning: symbol 'trampoline_probe_handler' was not declared. Should it be static?
kprobes.c:579:6: warning: symbol 'kretprobe_trampoline_holder' was not declared. Should it be static?

Declare the functions static.
One is magically used without any real reference so mark is __used, like other arch do too.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/kprobes.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index 1b09735..98d7128 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -512,7 +512,8 @@ void __kprobes arch_prepare_kretprobe(struct kretprobe_instance *ri,
 /*
  * Called when the probe at kretprobe trampoline is hit
  */
-int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
+static int __kprobes trampoline_probe_handler(struct kprobe *p,
+					      struct pt_regs *regs)
 {
 	struct kretprobe_instance *ri = NULL;
 	struct hlist_head *head, empty_rp;
@@ -576,7 +577,7 @@ int __kprobes trampoline_probe_handler(struct kprobe *p, struct pt_regs *regs)
 	return 1;
 }
 
-void kretprobe_trampoline_holder(void)
+static void __used kretprobe_trampoline_holder(void)
 {
 	asm volatile(".global kretprobe_trampoline\n"
 		     "kretprobe_trampoline:\n"
-- 
1.9.0

