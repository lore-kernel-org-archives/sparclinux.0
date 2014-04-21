From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 21 Apr 2014 19:39:36 +0000
Subject: [PATCH 21/29] sparc32: fix sparse warnings in smp_32.c
Message-Id: <1398109184-3283-21-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
smp_32.c:300:6: warning: symbol 'arch_cpu_pre_starting' was not declared. Should it be static?
smp_32.c:320:6: warning: symbol 'arch_cpu_pre_online' was not declared. Should it be static?
smp_32.c:347:6: warning: symbol 'sparc_start_secondary' was not declared. Should it be static?

Add missing static definition.

This left one warning:
   warning: symbol 'setup_profiling_timer' was not declared.

This is a global symbol that has no declaration in any global header.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/smp_32.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index a102bfb..632bf7c 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -297,7 +297,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	return ret;
 }
 
-void arch_cpu_pre_starting(void *arg)
+static void arch_cpu_pre_starting(void *arg)
 {
 	local_ops->cache_all();
 	local_ops->tlb_all();
@@ -317,7 +317,7 @@ void arch_cpu_pre_starting(void *arg)
 	}
 }
 
-void arch_cpu_pre_online(void *arg)
+static void arch_cpu_pre_online(void *arg)
 {
 	unsigned int cpuid = hard_smp_processor_id();
 
@@ -344,7 +344,7 @@ void arch_cpu_pre_online(void *arg)
 	}
 }
 
-void sparc_start_secondary(void *arg)
+static void sparc_start_secondary(void *arg)
 {
 	unsigned int cpu;
 
-- 
1.8.3.1

