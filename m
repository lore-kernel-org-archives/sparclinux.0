From: Abhishek Sagar <sagar.abhishek@gmail.com>
Date: Tue, 01 Jul 2008 18:52:50 +0000
Subject: Re: next-0630: sparc64: build failed
Message-Id: <486A7C19.5080905@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <a4423d670807010825t7ea2eb44oda3f08dc007c40a2@mail.gmail.com> <20080701154648.GA31057@elte.hu>
In-Reply-To: <20080701154648.GA31057@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ingo Molnar <mingo@elte.hu>, David Miller <davem@davemloft.net>
Cc: Alexander Beregalov <a.beregalov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, sparclinux@vger.kernel.org, rostedt@goodmis.org

Ingo Molnar wrote:
>     Alexander Beregalov reported this build failure:
>     
>     $ make CROSS_COMPILE=sparc64-unknown-linux-gnu- image modules && sudo
>     make modules_install
>       CHK     include/linux/version.h
>       CHK     include/linux/utsrelease.h
>       CALL    scripts/checksyscalls.sh
>       CHK     include/linux/compile.h
>     dnsdomainname: Unknown host
>       CC      arch/sparc64/kernel/sparc64_ksyms.o
>     arch/sparc64/kernel/sparc64_ksyms.c:116: error: '_mcount' undeclared
>     here (not in a function)
>     cc1: warnings being treated as errors
>     arch/sparc64/kernel/sparc64_ksyms.c:116: error: type defaults to 'int'
>     in declaration of '_mcount'
>     
>     And bisected it back to:
>     
>     | commit 395a59d0f8e86bb39cd700c3d185d30c670bb958
>     | Author: Abhishek Sagar <sagar.abhishek@gmail.com>
>     | Date:   Sat Jun 21 23:47:27 2008 +0530
>     |
>     |     ftrace: store mcount address in rec->ip
>     
>     the mcount prototype is only available under CONFIG_FTRACE,
>     extend it to CONFIG_MCOUNT as well.
>     
>     Reported-and-bisected-by: Alexander Beregalov <a.beregalov@gmail.com>
>     Signed-off-by: Ingo Molnar <mingo@elte.hu>

Hi Ingo/David,

CONFIG_MCOUNT currently controls the compilation with -pg flag and the export
of _mcount. But with ftrace, the former is redundant and the latter should be
made unconditional since _mcount is always defined. In which case, does the
inlined patch (untested) make sense? It should solve the build failure as well.

[for tip/master]

Signed-off-by: Abhishek Sagar <sagar.abhishek@gmail.com>
---
sparc64: get rid of CONFIG_MCOUNT

There are two possible (not necessarily exclusive) uses of the _mcount call:
1. To do stack usage debugging.
2. Function tracing.

Both have separate CONFIG_* options and don't require an alias such as
CONFIG_MCOUNT.

diff --git a/arch/sparc64/Kconfig.debug b/arch/sparc64/Kconfig.debug
index d6d32d1..6065be7 100644
--- a/arch/sparc64/Kconfig.debug
+++ b/arch/sparc64/Kconfig.debug
@@ -31,11 +31,6 @@ config DEBUG_PAGEALLOC
 	  This results in a large slowdown, but helps to find certain types
 	  of memory corruptions.
 
-config MCOUNT
-	bool
-	depends on STACK_DEBUG || FTRACE
-	default y
-
 config FRAME_POINTER
 	bool
 	depends on MCOUNT
diff --git a/arch/sparc64/Makefile b/arch/sparc64/Makefile
index 4b8f2b0..c182e5c 100644
--- a/arch/sparc64/Makefile
+++ b/arch/sparc64/Makefile
@@ -19,8 +19,10 @@ KBUILD_CFLAGS += -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow \
 KBUILD_CFLAGS += $(call cc-option,-mtune=ultrasparc3)
 KBUILD_AFLAGS += -m64 -mcpu=ultrasparc -Wa,--undeclared-regs
 
-ifeq ($(CONFIG_MCOUNT),y)
-  KBUILD_CFLAGS += -pg
+ifneq ($(CONFIG_FTRACE),y)
+ifeq ($(CONFIG_STACK_DEBUG),y)
+KBUILD_CFLAGS += -pg
+endif
 endif
 
 head-y := arch/sparc64/kernel/head.o arch/sparc64/kernel/init_task.o
diff --git a/arch/sparc64/kernel/sparc64_ksyms.c b/arch/sparc64/kernel/sparc64_ksyms.c
index b80d982..13c243c 100644
--- a/arch/sparc64/kernel/sparc64_ksyms.c
+++ b/arch/sparc64/kernel/sparc64_ksyms.c
@@ -112,10 +112,7 @@ EXPORT_SYMBOL(__write_trylock);
 EXPORT_SYMBOL(smp_call_function);
 #endif /* CONFIG_SMP */
 
-#if defined(CONFIG_MCOUNT)
 EXPORT_SYMBOL(_mcount);
-#endif
-
 EXPORT_SYMBOL(sparc64_get_clock_tick);
 
 /* RW semaphores */
diff --git a/include/asm-sparc64/ftrace.h b/include/asm-sparc64/ftrace.h
index f76a40a..51036c3 100644
--- a/include/asm-sparc64/ftrace.h
+++ b/include/asm-sparc64/ftrace.h
@@ -4,11 +4,10 @@
 #ifdef CONFIG_FTRACE
 #define MCOUNT_ADDR		((long)(_mcount))
 #define MCOUNT_INSN_SIZE	4 /* sizeof mcount call */
+#endif
 
 #ifndef __ASSEMBLY__
 extern void _mcount(void);
 #endif
 
-#endif
-
 #endif /* _ASM_SPARC64_FTRACE */
