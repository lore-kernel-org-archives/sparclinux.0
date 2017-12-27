From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 27 Dec 2017 08:50:28 +0000
Subject: [PATCH v6 3/8] init: allow initcall tables to be emitted using relative references
Message-Id: <20171227085033.22389-4-ard.biesheuvel@linaro.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
In-Reply-To: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Allow the initcall tables to be emitted using relative references that
are only half the size on 64-bit architectures and don't require fixups
at runtime on relocatable kernels.

Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: James Morris <james.l.morris@oracle.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/linux/init.h   | 44 +++++++++++++++-----
 init/main.c            | 32 +++++++-------
 kernel/printk/printk.c |  4 +-
 security/security.c    |  4 +-
 4 files changed, 53 insertions(+), 31 deletions(-)

diff --git a/include/linux/init.h b/include/linux/init.h
index ea1b31101d9e..125bbea99c6b 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -109,8 +109,24 @@
 typedef int (*initcall_t)(void);
 typedef void (*exitcall_t)(void);
 
-extern initcall_t __con_initcall_start[], __con_initcall_end[];
-extern initcall_t __security_initcall_start[], __security_initcall_end[];
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+typedef signed int initcall_entry_t;
+
+static inline initcall_t initcall_from_entry(initcall_entry_t *entry)
+{
+	return (initcall_t)((unsigned long)entry + *entry);
+}
+#else
+typedef initcall_t initcall_entry_t;
+
+static inline initcall_t initcall_from_entry(initcall_entry_t *entry)
+{
+	return *entry;
+}
+#endif
+
+extern initcall_entry_t __con_initcall_start[], __con_initcall_end[];
+extern initcall_entry_t __security_initcall_start[], __security_initcall_end[];
 
 /* Used for contructor calls. */
 typedef void (*ctor_fn_t)(void);
@@ -160,9 +176,20 @@ extern bool initcall_debug;
  * as KEEP() in the linker script.
  */
 
-#define __define_initcall(fn, id) \
+#ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
+#define ___define_initcall(fn, id, __sec)			\
+	__ADDRESSABLE(fn)					\
+	asm(".section	\"" #__sec ".init\", \"a\"	\n"	\
+	"__initcall_" #fn #id ":			\n"	\
+	    ".long "	VMLINUX_SYMBOL_STR(fn) " - .	\n"	\
+	    ".previous					\n");
+#else
+#define ___define_initcall(fn, id, __sec) \
 	static initcall_t __initcall_##fn##id __used \
-	__attribute__((__section__(".initcall" #id ".init"))) = fn;
+		__attribute__((__section__(#__sec ".init"))) = fn;
+#endif
+
+#define __define_initcall(fn, id) ___define_initcall(fn, id, .initcall##id)
 
 /*
  * Early initcalls run before initializing SMP.
@@ -201,13 +228,8 @@ extern bool initcall_debug;
 #define __exitcall(fn)						\
 	static exitcall_t __exitcall_##fn __exit_call = fn
 
-#define console_initcall(fn)					\
-	static initcall_t __initcall_##fn			\
-	__used __section(.con_initcall.init) = fn
-
-#define security_initcall(fn)					\
-	static initcall_t __initcall_##fn			\
-	__used __section(.security_initcall.init) = fn
+#define console_initcall(fn)	___define_initcall(fn,, .con_initcall)
+#define security_initcall(fn)	___define_initcall(fn,, .security_initcall)
 
 struct obs_kernel_param {
 	const char *str;
diff --git a/init/main.c b/init/main.c
index 7b606fc48482..2cbe3c2804ab 100644
--- a/init/main.c
+++ b/init/main.c
@@ -845,18 +845,18 @@ int __init_or_module do_one_initcall(initcall_t fn)
 }
 
 
-extern initcall_t __initcall_start[];
-extern initcall_t __initcall0_start[];
-extern initcall_t __initcall1_start[];
-extern initcall_t __initcall2_start[];
-extern initcall_t __initcall3_start[];
-extern initcall_t __initcall4_start[];
-extern initcall_t __initcall5_start[];
-extern initcall_t __initcall6_start[];
-extern initcall_t __initcall7_start[];
-extern initcall_t __initcall_end[];
-
-static initcall_t *initcall_levels[] __initdata = {
+extern initcall_entry_t __initcall_start[];
+extern initcall_entry_t __initcall0_start[];
+extern initcall_entry_t __initcall1_start[];
+extern initcall_entry_t __initcall2_start[];
+extern initcall_entry_t __initcall3_start[];
+extern initcall_entry_t __initcall4_start[];
+extern initcall_entry_t __initcall5_start[];
+extern initcall_entry_t __initcall6_start[];
+extern initcall_entry_t __initcall7_start[];
+extern initcall_entry_t __initcall_end[];
+
+static initcall_entry_t *initcall_levels[] __initdata = {
 	__initcall0_start,
 	__initcall1_start,
 	__initcall2_start,
@@ -882,7 +882,7 @@ static char *initcall_level_names[] __initdata = {
 
 static void __init do_initcall_level(int level)
 {
-	initcall_t *fn;
+	initcall_entry_t *fn;
 
 	strcpy(initcall_command_line, saved_command_line);
 	parse_args(initcall_level_names[level],
@@ -892,7 +892,7 @@ static void __init do_initcall_level(int level)
 		   NULL, &repair_env_string);
 
 	for (fn = initcall_levels[level]; fn < initcall_levels[level+1]; fn++)
-		do_one_initcall(*fn);
+		do_one_initcall(initcall_from_entry(fn));
 }
 
 static void __init do_initcalls(void)
@@ -923,10 +923,10 @@ static void __init do_basic_setup(void)
 
 static void __init do_pre_smp_initcalls(void)
 {
-	initcall_t *fn;
+	initcall_entry_t *fn;
 
 	for (fn = __initcall_start; fn < __initcall0_start; fn++)
-		do_one_initcall(*fn);
+		do_one_initcall(initcall_from_entry(fn));
 }
 
 /*
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index b9006617710f..0516005261c7 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2611,7 +2611,7 @@ EXPORT_SYMBOL(unregister_console);
  */
 void __init console_init(void)
 {
-	initcall_t *call;
+	initcall_entry_t *call;
 
 	/* Setup the default TTY line discipline. */
 	n_tty_init();
@@ -2622,7 +2622,7 @@ void __init console_init(void)
 	 */
 	call = __con_initcall_start;
 	while (call < __con_initcall_end) {
-		(*call)();
+		initcall_from_entry(call)();
 		call++;
 	}
 }
diff --git a/security/security.c b/security/security.c
index 1cd8526cb0b7..f648eeff06de 100644
--- a/security/security.c
+++ b/security/security.c
@@ -45,10 +45,10 @@ static __initdata char chosen_lsm[SECURITY_NAME_MAX + 1]  
 static void __init do_security_initcalls(void)
 {
-	initcall_t *call;
+	initcall_entry_t *call;
 	call = __security_initcall_start;
 	while (call < __security_initcall_end) {
-		(*call) ();
+		initcall_from_entry(call)();
 		call++;
 	}
 }
-- 
2.11.0

