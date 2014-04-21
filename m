From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 17:12:36 +0000
Subject: [PATCH 24/24] sparc32: fix sparse warnings in leon_smp.c
Message-Id: <1398100356-19794-24-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
leon_smp.c:133:6: warning: symbol 'leon_smp_setbroadcast' was not declared. Should it be static?
leon_smp.c:151:14: warning: symbol 'leon_smp_getbroadcast' was not declared. Should it be static?
leon_smp.c:269:6: warning: symbol 'leon_irq_rotate' was not declared. Should it be static?
leon_smp.c:355:6: warning: symbol 'leonsmp_ipi_interrupt' was not declared. Should it be static?
leon_smp.c:457:6: warning: symbol 'leon_cross_call_irq' was not declared. Should it be static?

Add static.
Remove unused functions.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
Cc: Daniel Hellstrom <daniel@gaisler.com>
---
 arch/sparc/kernel/kernel.h   |  6 ++++--
 arch/sparc/kernel/leon_smp.c | 13 +------------
 2 files changed, 5 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
index 7678e9a..c355419 100644
--- a/arch/sparc/kernel/kernel.h
+++ b/arch/sparc/kernel/kernel.h
@@ -79,8 +79,10 @@ extern void smp4d_cross_call_irq(void);
 extern void smp4d_percpu_timer_interrupt(struct pt_regs *regs);
 
 /* leon_smp.c */
-void leon_cpu_pre_starting(void *arg);
-void leon_cpu_pre_online(void *arg);
+extern void leon_cpu_pre_starting(void *arg);
+extern void leon_cpu_pre_online(void *arg);
+extern void leonsmp_ipi_interrupt(void);
+extern void leon_cross_call_irq(void);
 
 /* head_32.S */
 extern unsigned int t_nmi[];
diff --git a/arch/sparc/kernel/leon_smp.c b/arch/sparc/kernel/leon_smp.c
index 6edf955..018ef11 100644
--- a/arch/sparc/kernel/leon_smp.c
+++ b/arch/sparc/kernel/leon_smp.c
@@ -130,7 +130,7 @@ void leon_configure_cache_smp(void)
 	local_ops->tlb_all();
 }
 
-void leon_smp_setbroadcast(unsigned int mask)
+static void leon_smp_setbroadcast(unsigned int mask)
 {
 	int broadcast  	    ((LEON3_BYPASS_LOAD_PA(&(leon3_irqctrl_regs->mpstatus)) >>
@@ -148,13 +148,6 @@ void leon_smp_setbroadcast(unsigned int mask)
 	LEON_BYPASS_STORE_PA(&(leon3_irqctrl_regs->mpbroadcast), mask);
 }
 
-unsigned int leon_smp_getbroadcast(void)
-{
-	unsigned int mask;
-	mask = LEON_BYPASS_LOAD_PA(&(leon3_irqctrl_regs->mpbroadcast));
-	return mask;
-}
-
 int leon_smp_nrcpus(void)
 {
 	int nrcpu @@ -266,10 +259,6 @@ void __init leon_smp_done(void)
 
 }
 
-void leon_irq_rotate(int cpu)
-{
-}
-
 struct leon_ipi_work {
 	int single;
 	int msk;
-- 
1.8.3.1

