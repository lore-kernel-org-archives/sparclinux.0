From: daniel.m.jordan@oracle.com
Date: Mon, 10 Apr 2017 15:50:52 +0000
Subject: [PATCH] sparc64: Use LOCKDEP_SMALL, not PROVE_LOCKING_SMALL
Message-Id: <1491839452-480748-1-git-send-email-daniel.m.jordan@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

CONFIG_PROVE_LOCKING_SMALL shrinks the memory usage of lockdep so the
kernel text, data, and bss fit in the required 32MB limit, but this
option is not set for every config that enables lockdep.

A 4.10 kernel fails to boot with the console output

    Kernel: Using 8 locked TLB entries for main kernel image.
    hypervisor_tlb_lock[2000000:0:8000000071c007c3:1]: errors with f
    Program terminated

with these config options

    CONFIG_LOCKDEP=y
    CONFIG_LOCK_STAT=y
    CONFIG_PROVE_LOCKING=n

To fix, rename CONFIG_PROVE_LOCKING_SMALL to CONFIG_LOCKDEP_SMALL, and
enable this option with CONFIG_LOCKDEP=y so we get the reduced memory
usage every time lockdep is turned on.

Tested that CONFIG_LOCKDEP_SMALL is set to 'y' if and only if
CONFIG_LOCKDEP is set to 'y'.  When other lockdep-related config options
that select CONFIG_LOCKDEP are enabled (e.g. CONFIG_LOCK_STAT or
CONFIG_PROVE_LOCKING), verified that CONFIG_LOCKDEP_SMALL is also
enabled.

Fixes: e6b5f1be7afe ("config: Adding the new config parameter CONFIG_PROVE_LOCKING_SMALL for sparc")
Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Reviewed-by: Babu Moger <babu.moger@oracle.com>
---
 arch/sparc/Kconfig                 |    2 +-
 kernel/locking/lockdep_internals.h |    6 +++---
 lib/Kconfig.debug                  |    6 +++---
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 68ac5c7..a59deae 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -43,7 +43,7 @@ config SPARC
 	select ARCH_HAS_SG_CHAIN
 	select CPU_NO_EFFICIENT_FFS
 	select HAVE_ARCH_HARDENED_USERCOPY
-	select PROVE_LOCKING_SMALL if PROVE_LOCKING
+	select LOCKDEP_SMALL if LOCKDEP
 	select ARCH_WANT_RELAX_ORDER
 
 config SPARC32
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index c2b8849..c08fbd2 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -46,13 +46,13 @@ enum {
 		(LOCKF_USED_IN_HARDIRQ_READ | LOCKF_USED_IN_SOFTIRQ_READ)
 
 /*
- * CONFIG_PROVE_LOCKING_SMALL is defined for sparc. Sparc requires .text,
+ * CONFIG_LOCKDEP_SMALL is defined for sparc. Sparc requires .text,
  * .data and .bss to fit in required 32MB limit for the kernel. With
- * PROVE_LOCKING we could go over this limit and cause system boot-up problems.
+ * CONFIG_LOCKDEP we could go over this limit and cause system boot-up problems.
  * So, reduce the static allocations for lockdeps related structures so that
  * everything fits in current required size limit.
  */
-#ifdef CONFIG_PROVE_LOCKING_SMALL
+#ifdef CONFIG_LOCKDEP_SMALL
 /*
  * MAX_LOCKDEP_ENTRIES is the maximum number of lock dependencies
  * we track.
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 97d62c2..fa16c0f 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1103,9 +1103,6 @@ config PROVE_LOCKING
 
 	 For more details, see Documentation/locking/lockdep-design.txt.
 
-config PROVE_LOCKING_SMALL
-	bool
-
 config LOCKDEP
 	bool
 	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
@@ -1114,6 +1111,9 @@ config LOCKDEP
 	select KALLSYMS
 	select KALLSYMS_ALL
 
+config LOCKDEP_SMALL
+	bool
+
 config LOCK_STAT
 	bool "Lock usage statistics"
 	depends on DEBUG_KERNEL && TRACE_IRQFLAGS_SUPPORT && STACKTRACE_SUPPORT && LOCKDEP_SUPPORT
-- 
1.7.1

