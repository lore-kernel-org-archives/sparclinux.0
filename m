From: David Miller <davem@davemloft.net>
Date: Sat, 13 Jun 2009 08:10:20 +0000
Subject: [PATCH] Bring sparc64 dynamic ftrace up to snuff...
Message-Id: <20090613.011020.214065340.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: sparclinux@vger.kernel.org, mingo@elte.hu, rostedt@goodmis.org


Do the ftrace maintainers mind if I merge the following in via my
sparc-next-2.6 tree?

Thanks!

sparc64: Add proper dynamic ftrace support.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/Kconfig              |    2 +
 arch/sparc/include/asm/ftrace.h |   11 +++++++++
 arch/sparc/kernel/ftrace.c      |   47 ++++++++++++++++++++++++++------------
 scripts/recordmcount.pl         |   20 ++++++++++++++++
 4 files changed, 65 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 2185cf9..3f8b6a9 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -37,6 +37,8 @@ config SPARC64
 	select HAVE_KPROBES
 	select HAVE_LMB
 	select HAVE_SYSCALL_WRAPPERS
+	select HAVE_DYNAMIC_FTRACE
+	select HAVE_FTRACE_MCOUNT_RECORD
 	select USE_GENERIC_SMP_HELPERS if SMP
 	select RTC_DRV_CMOS
 	select RTC_DRV_BQ4802
diff --git a/arch/sparc/include/asm/ftrace.h b/arch/sparc/include/asm/ftrace.h
index d27716c..b0f18e9 100644
--- a/arch/sparc/include/asm/ftrace.h
+++ b/arch/sparc/include/asm/ftrace.h
@@ -11,4 +11,15 @@ extern void _mcount(void);
 
 #endif
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+/* reloction of mcount call site is the same as the address */
+static inline unsigned long ftrace_call_adjust(unsigned long addr)
+{
+	return addr;
+}
+
+struct dyn_arch_ftrace {
+};
+#endif /*  CONFIG_DYNAMIC_FTRACE */
+
 #endif /* _ASM_SPARC64_FTRACE */
diff --git a/arch/sparc/kernel/ftrace.c b/arch/sparc/kernel/ftrace.c
index d0218e7..d3b1a30 100644
--- a/arch/sparc/kernel/ftrace.c
+++ b/arch/sparc/kernel/ftrace.c
@@ -7,14 +7,10 @@
 
 #include <asm/ftrace.h>
 
+#ifdef CONFIG_DYNAMIC_FTRACE
 static const u32 ftrace_nop = 0x01000000;
 
-unsigned char *ftrace_nop_replace(void)
-{
-	return (char *)&ftrace_nop;
-}
-
-unsigned char *ftrace_call_replace(unsigned long ip, unsigned long addr)
+static u32 ftrace_call_replace(unsigned long ip, unsigned long addr)
 {
 	static u32 call;
 	s32 off;
@@ -22,15 +18,11 @@ unsigned char *ftrace_call_replace(unsigned long ip, unsigned long addr)
 	off = ((s32)addr - (s32)ip);
 	call = 0x40000000 | ((u32)off >> 2);
 
-	return (unsigned char *) &call;
+	return call;
 }
 
-int
-ftrace_modify_code(unsigned long ip, unsigned char *old_code,
-		   unsigned char *new_code)
+static int ftrace_modify_code(unsigned long ip, u32 old, u32 new)
 {
-	u32 old = *(u32 *)old_code;
-	u32 new = *(u32 *)new_code;
 	u32 replaced;
 	int faulted;
 
@@ -59,18 +51,43 @@ ftrace_modify_code(unsigned long ip, unsigned char *old_code,
 	return faulted;
 }
 
+int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned long ip = rec->ip;
+	u32 old, new;
+
+	old = ftrace_call_replace(ip, addr);
+	new = ftrace_nop;
+	return ftrace_modify_code(ip, old, new);
+}
+
+int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned long ip = rec->ip;
+	u32 old, new;
+
+	old = ftrace_nop;
+	new = ftrace_call_replace(ip, addr);
+	return ftrace_modify_code(ip, old, new);
+}
+
 int ftrace_update_ftrace_func(ftrace_func_t func)
 {
 	unsigned long ip = (unsigned long)(&ftrace_call);
-	unsigned char old[MCOUNT_INSN_SIZE], *new;
+	u32 old, new;
 
-	memcpy(old, &ftrace_call, MCOUNT_INSN_SIZE);
+	old = *(u32 *) &ftrace_call;
 	new = ftrace_call_replace(ip, (unsigned long)func);
 	return ftrace_modify_code(ip, old, new);
 }
 
 int __init ftrace_dyn_arch_init(void *data)
 {
-	ftrace_mcount_set(data);
+	unsigned long *p = data;
+
+	*p = 0;
+
 	return 0;
 }
+#endif
+
diff --git a/scripts/recordmcount.pl b/scripts/recordmcount.pl
index 409596e..e694eaf 100755
--- a/scripts/recordmcount.pl
+++ b/scripts/recordmcount.pl
@@ -213,6 +213,26 @@ if ($arch eq "x86_64") {
     if ($is_module eq "0") {
         $cc .= " -mconstant-gp";
     }
+} elsif ($arch eq "sparc64") {
+    # In the objdump output there are giblets like:
+    # 0000000000000000 <igmp_net_exit-0x18>:
+    # As there's some data blobs that get emitted into the
+    # text section before the first instructions and the first
+    # real symbols.  We don't want to match that, so to combat
+    # this we use '\w' so we'll match just plain symbol names,
+    # and not those that also include hex offsets inside of the
+    # '<>' brackets.  Actually the generic function_regex setting
+    # could safely use this too.
+    $function_regex = "^([0-9a-fA-F]+)\\s+<(\\w*?)>:";
+
+    # Sparc64 calls '_mcount' instead of plain 'mcount'.
+    $mcount_regex = "^\\s*([0-9a-fA-F]+):.*\\s_mcount\$";
+
+    $alignment = 8;
+    $type = ".xword";
+    $ld .= " -m elf64_sparc";
+    $cc .= " -m64";
+    $objcopy .= " -O elf64-sparc";
 } else {
     die "Arch $arch is not supported with CONFIG_FTRACE_MCOUNT_RECORD";
 }
-- 
1.6.3.2

