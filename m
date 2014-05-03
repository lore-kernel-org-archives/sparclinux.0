From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 03 May 2014 22:52:31 +0000
Subject: [PATCH 26/34] sparc64: fix sparse warnings in perf_event.c
Message-Id: <1399157559-19901-26-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following sparse warnings:
kernel/perf_event.c:113:1: warning: symbol 'cpu_hw_events' was not declared. Should it be static?
kernel/perf_event.c:1156:6: warning: symbol 'perf_event_grab_pmc' was not declared. Should it be static?
kernel/perf_event.c:1172:6: warning: symbol 'perf_event_release_pmc' was not declared. Should it be static?
kernel/perf_event.c:1672:12: warning: symbol 'init_hw_perf_events' was not declared. Should it be static?
kernel/perf_event.c:1749:52: warning: incorrect type in argument 2 (different address spaces)
kernel/perf_event.c:1772:60: warning: incorrect type in argument 2 (different address spaces)
kernel/perf_event.c:1779:60: warning: incorrect type in argument 2 (different address spaces)

Define the functions static as they are not used outside this file.
Fix it so copy_from_user are supplied with pointers annotated _user

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/perf_event.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/sparc/kernel/perf_event.c b/arch/sparc/kernel/perf_event.c
index b5c38fa..9cd0b44 100644
--- a/arch/sparc/kernel/perf_event.c
+++ b/arch/sparc/kernel/perf_event.c
@@ -110,7 +110,7 @@ struct cpu_hw_events {
 
 	unsigned int		group_flag;
 };
-DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = { .enabled = 1, };
+static DEFINE_PER_CPU(struct cpu_hw_events, cpu_hw_events) = { .enabled = 1, };
 
 /* An event map describes the characteristics of a performance
  * counter event.  In particular it gives the encoding as well as
@@ -1153,7 +1153,7 @@ static void perf_stop_nmi_watchdog(void *unused)
 		cpuc->pcr[i] = pcr_ops->read_pcr(i);
 }
 
-void perf_event_grab_pmc(void)
+static void perf_event_grab_pmc(void)
 {
 	if (atomic_inc_not_zero(&active_events))
 		return;
@@ -1169,7 +1169,7 @@ void perf_event_grab_pmc(void)
 	mutex_unlock(&pmc_grab_mutex);
 }
 
-void perf_event_release_pmc(void)
+static void perf_event_release_pmc(void)
 {
 	if (atomic_dec_and_mutex_lock(&active_events, &pmc_grab_mutex)) {
 		if (atomic_read(&nmi_active) = 0)
@@ -1669,7 +1669,7 @@ static bool __init supported_pmu(void)
 	return false;
 }
 
-int __init init_hw_perf_events(void)
+static int __init init_hw_perf_events(void)
 {
 	pr_info("Performance events: ");
 
@@ -1742,10 +1742,11 @@ static void perf_callchain_user_64(struct perf_callchain_entry *entry,
 
 	ufp = regs->u_regs[UREG_I6] + STACK_BIAS;
 	do {
-		struct sparc_stackf *usf, sf;
+		struct sparc_stackf __user *usf;
+		struct sparc_stackf sf;
 		unsigned long pc;
 
-		usf = (struct sparc_stackf *) ufp;
+		usf = (struct sparc_stackf __user *) ufp;
 		if (__copy_from_user_inatomic(&sf, usf, sizeof(sf)))
 			break;
 
@@ -1765,17 +1766,19 @@ static void perf_callchain_user_32(struct perf_callchain_entry *entry,
 		unsigned long pc;
 
 		if (thread32_stack_is_64bit(ufp)) {
-			struct sparc_stackf *usf, sf;
+			struct sparc_stackf __user *usf;
+			struct sparc_stackf sf;
 
 			ufp += STACK_BIAS;
-			usf = (struct sparc_stackf *) ufp;
+			usf = (struct sparc_stackf __user *) ufp;
 			if (__copy_from_user_inatomic(&sf, usf, sizeof(sf)))
 				break;
 			pc = sf.callers_pc & 0xffffffff;
 			ufp = ((unsigned long) sf.fp) & 0xffffffff;
 		} else {
-			struct sparc_stackf32 *usf, sf;
-			usf = (struct sparc_stackf32 *) ufp;
+			struct sparc_stackf32 __user *usf;
+			struct sparc_stackf32 sf;
+			usf = (struct sparc_stackf32 __user *) ufp;
 			if (__copy_from_user_inatomic(&sf, usf, sizeof(sf)))
 				break;
 			pc = sf.callers_pc;
-- 
1.9.0

