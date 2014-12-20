From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Date: Sat, 20 Dec 2014 12:33:54 +0000
Subject: [PATCH] arch: sparc: kernel: traps_64.c:  Remove some unused functions
Message-Id: <1419078835-31499-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "David S. Miller" <davem@davemloft.net>, Sam Ravnborg <sam@ravnborg.org>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, bob picco <bpicco@meloft.net>, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

Removes some functions that are not used anywhere:
do_fpdis_tl1() do_iae_tl1() do_dae_tl1() do_cee_tl1()

This was partially found by using a static code analysis program called cppcheck.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 arch/sparc/kernel/entry.h    |    4 ----
 arch/sparc/kernel/traps_64.c |   28 ----------------------------
 2 files changed, 32 deletions(-)

diff --git a/arch/sparc/kernel/entry.h b/arch/sparc/kernel/entry.h
index 88d322b..07cc49e 100644
--- a/arch/sparc/kernel/entry.h
+++ b/arch/sparc/kernel/entry.h
@@ -98,11 +98,7 @@ void sun4v_do_mna(struct pt_regs *regs,
 void do_privop(struct pt_regs *regs);
 void do_privact(struct pt_regs *regs);
 void do_cee(struct pt_regs *regs);
-void do_cee_tl1(struct pt_regs *regs);
-void do_dae_tl1(struct pt_regs *regs);
-void do_iae_tl1(struct pt_regs *regs);
 void do_div0_tl1(struct pt_regs *regs);
-void do_fpdis_tl1(struct pt_regs *regs);
 void do_fpieee_tl1(struct pt_regs *regs);
 void do_fpother_tl1(struct pt_regs *regs);
 void do_ill_tl1(struct pt_regs *regs);
diff --git a/arch/sparc/kernel/traps_64.c b/arch/sparc/kernel/traps_64.c
index 981a769..204315d 100644
--- a/arch/sparc/kernel/traps_64.c
+++ b/arch/sparc/kernel/traps_64.c
@@ -2564,27 +2564,6 @@ void do_cee(struct pt_regs *regs)
 	die_if_kernel("TL0: Cache Error Exception", regs);
 }
 
-void do_cee_tl1(struct pt_regs *regs)
-{
-	exception_enter();
-	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
-	die_if_kernel("TL1: Cache Error Exception", regs);
-}
-
-void do_dae_tl1(struct pt_regs *regs)
-{
-	exception_enter();
-	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
-	die_if_kernel("TL1: Data Access Exception", regs);
-}
-
-void do_iae_tl1(struct pt_regs *regs)
-{
-	exception_enter();
-	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
-	die_if_kernel("TL1: Instruction Access Exception", regs);
-}
-
 void do_div0_tl1(struct pt_regs *regs)
 {
 	exception_enter();
@@ -2592,13 +2571,6 @@ void do_div0_tl1(struct pt_regs *regs)
 	die_if_kernel("TL1: DIV0 Exception", regs);
 }
 
-void do_fpdis_tl1(struct pt_regs *regs)
-{
-	exception_enter();
-	dump_tl1_traplog((struct tl1_traplog *)(regs + 1));
-	die_if_kernel("TL1: FPU Disabled", regs);
-}
-
 void do_fpieee_tl1(struct pt_regs *regs)
 {
 	exception_enter();
-- 
1.7.10.4

