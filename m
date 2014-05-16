From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 16 May 2014 21:26:05 +0000
Subject: [PATCH 27/34] sparc: fix sparse warnings in smp_32.c + smp_64.c
Message-Id: <1400275572-17424-27-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1399157559-19901-27-git-send-email-sam@ravnborg.org>
In-Reply-To: <1399157559-19901-27-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix following warnings:
smp_32.c:177:5: warning: symbol 'setup_profiling_timer' was not declared. Should it be static?
smp_64.c:1202:5: warning: symbol 'setup_profiling_timer' was not declared. Should it be static?
smp_64.c:989:6: warning: symbol 'kgdb_roundup_cpus' was not declared. Should it be static?

Add prototype to include/linux/profile.h of setup_profiling_timer
Add missing include to smp_64.c

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/kernel/smp_32.c | 1 +
 arch/sparc/kernel/smp_64.c | 1 +
 include/linux/profile.h    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/arch/sparc/kernel/smp_32.c b/arch/sparc/kernel/smp_32.c
index 9d3297d..7958242 100644
--- a/arch/sparc/kernel/smp_32.c
+++ b/arch/sparc/kernel/smp_32.c
@@ -20,6 +20,7 @@
 #include <linux/seq_file.h>
 #include <linux/cache.h>
 #include <linux/delay.h>
+#include <linux/profile.h>
 #include <linux/cpu.h>
 
 #include <asm/ptrace.h>
diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
index df91e78..afc71bf 100644
--- a/arch/sparc/kernel/smp_64.c
+++ b/arch/sparc/kernel/smp_64.c
@@ -25,6 +25,7 @@
 #include <linux/ftrace.h>
 #include <linux/cpu.h>
 #include <linux/slab.h>
+#include <linux/kgdb.h>
 
 #include <asm/head.h>
 #include <asm/ptrace.h>
diff --git a/include/linux/profile.h b/include/linux/profile.h
index aaad386..b537a25 100644
--- a/include/linux/profile.h
+++ b/include/linux/profile.h
@@ -44,6 +44,7 @@ extern int prof_on __read_mostly;
 int profile_init(void);
 int profile_setup(char *str);
 void profile_tick(int type);
+int setup_profiling_timer(unsigned int multiplier);
 
 /*
  * Add multiple profiler hits to a given address:
-- 
1.9.0

