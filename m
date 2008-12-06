From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 06 Dec 2008 20:11:55 +0000
Subject: [PATCH] sparc: fix sparse warnings in cpu_*.c
Message-Id: <20081206201155.GA24227@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

o declare variables from cpu_*.c
o declare function from cpu_32.c

To do this introduce a new header "kernel.h" which is local to kernel/

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---

Just a quick sample where kernel.h is introduced.
With this I could get rid of a few sparse warnings and
the code is better.

	Sam

 arch/sparc/kernel/cpu_32.c   |    6 ++++--
 arch/sparc/kernel/cpu_64.c   |    1 +
 arch/sparc/kernel/entry.h    |    3 ---
 arch/sparc/kernel/kernel.h   |    8 ++++++++
 arch/sparc/kernel/setup_32.c |    5 ++---
 arch/sparc/kernel/setup_64.c |    1 +
 6 files changed, 16 insertions(+), 8 deletions(-)
 create mode 100644 arch/sparc/kernel/kernel.h

diff --git a/arch/sparc/kernel/cpu_32.c b/arch/sparc/kernel/cpu_32.c
index cdaf763..4e14240 100644
--- a/arch/sparc/kernel/cpu_32.c
+++ b/arch/sparc/kernel/cpu_32.c
@@ -15,6 +15,8 @@
 #include <asm/mbus.h>
 #include <asm/cpudata.h>
 
+#include "kernel.h"
+
 DEFINE_PER_CPU(cpuinfo_sparc, __cpu_data) = { 0 };
 
 struct cpu_iu_info {
@@ -125,8 +127,8 @@ static struct cpu_iu_info linux_sparc_chips[] = {
 
 #define NSPARCCHIPS  ARRAY_SIZE(linux_sparc_chips)
 
-char *sparc_cpu_type;
-char *sparc_fpu_type;
+const char *sparc_cpu_type;
+const char *sparc_fpu_type;
 
 unsigned int fsr_storage;
 
diff --git a/arch/sparc/kernel/cpu_64.c b/arch/sparc/kernel/cpu_64.c
index 0c9ac83..4a81ed7 100644
--- a/arch/sparc/kernel/cpu_64.c
+++ b/arch/sparc/kernel/cpu_64.c
@@ -16,6 +16,7 @@
 #include <asm/oplib.h>
 
 #include "entry.h"
+#include "kernel.h"
 
 DEFINE_PER_CPU(cpuinfo_sparc, __cpu_data) = { 0 };
 
diff --git a/arch/sparc/kernel/entry.h b/arch/sparc/kernel/entry.h
index 34d7ab5..a9ab19a 100644
--- a/arch/sparc/kernel/entry.h
+++ b/arch/sparc/kernel/entry.h
@@ -5,9 +5,6 @@
 #include <linux/types.h>
 #include <linux/init.h>
 
-extern const char *sparc_cpu_type;
-extern const char *sparc_fpu_type;
-
 extern void __init per_cpu_patch(void);
 extern void __init sun4v_patch(void);
 extern void __init boot_cpu_id_too_large(int cpu);
diff --git a/arch/sparc/kernel/kernel.h b/arch/sparc/kernel/kernel.h
new file mode 100644
index 0000000..7f02aad
--- /dev/null
+++ b/arch/sparc/kernel/kernel.h
@@ -0,0 +1,8 @@
+/* cpu.c */
+extern const char *sparc_cpu_type;
+extern const char *sparc_fpu_type;
+
+extern unsigned int fsr_storage;
+
+extern void cpu_probe(void);
+
diff --git a/arch/sparc/kernel/setup_32.c b/arch/sparc/kernel/setup_32.c
index d21abbe..c96c65d 100644
--- a/arch/sparc/kernel/setup_32.c
+++ b/arch/sparc/kernel/setup_32.c
@@ -46,6 +46,8 @@
 #include <asm/cpudata.h>
 #include <asm/setup.h>
 
+#include "kernel.h"
+
 struct screen_info screen_info = {
 	0, 0,			/* orig-x, orig-y */
 	0,			/* unused */
@@ -308,9 +310,6 @@ void __init setup_arch(char **cmdline_p)
 	smp_setup_cpu_possible_map();
 }
 
-extern char *sparc_cpu_type;
-extern char *sparc_fpu_type;
-
 static int ncpus_probed;
 
 static int show_cpuinfo(struct seq_file *m, void *__unused)
diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index c8b03a4..555db74 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -52,6 +52,7 @@
 #endif
 
 #include "entry.h"
+#include "kernel.h"
 
 /* Used to synchronize accesses to NatSemi SUPER I/O chip configure
  * operations in asm/ns87303.h
-- 
1.5.6.GIT

