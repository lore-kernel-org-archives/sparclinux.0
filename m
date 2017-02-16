From: Anton Blanchard <anton@ozlabs.org>
Date: Thu, 16 Feb 2017 06:00:50 +0000
Subject: [PATCH] perf: Rename CONFIG_[UK]PROBE_EVENT to CONFIG_[UK]PROBE_EVENTS
Message-Id: <20170216060050.20866-1-anton@ozlabs.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: davem@davemloft.net, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Anton Blanchard <anton@samba.org>

We have uses of CONFIG_UPROBE_EVENT and CONFIG_KPROBE_EVENT as
well as CONFIG_UPROBE_EVENTS and CONFIG_KPROBE_EVENTS. Consistently
use the plurals.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 Documentation/trace/kprobetrace.txt         |  2 +-
 Documentation/trace/uprobetracer.txt        |  2 +-
 arch/powerpc/configs/85xx/kmp204x_defconfig |  2 +-
 arch/s390/configs/default_defconfig         |  2 +-
 arch/s390/configs/gcov_defconfig            |  2 +-
 arch/s390/configs/performance_defconfig     |  2 +-
 arch/s390/defconfig                         |  2 +-
 kernel/trace/Kconfig                        |  6 +++---
 kernel/trace/Makefile                       |  4 ++--
 kernel/trace/trace.c                        | 10 +++++-----
 kernel/trace/trace_probe.h                  |  4 ++--
 11 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/Documentation/trace/kprobetrace.txt b/Documentation/trace/kpro=
betrace.txt
index e4991fb..41ef9d8 100644
--- a/Documentation/trace/kprobetrace.txt
+++ b/Documentation/trace/kprobetrace.txt
@@ -12,7 +12,7 @@ kprobes can probe (this means, all functions body except =
for __kprobes
 functions). Unlike the Tracepoint based event, this can be added and remov=
ed
 dynamically, on the fly.
=20
-To enable this feature, build your kernel with CONFIG_KPROBE_EVENT=3Dy.
+To enable this feature, build your kernel with CONFIG_KPROBE_EVENTS=3Dy.
=20
 Similar to the events tracer, this doesn't need to be activated via
 current_tracer. Instead of that, add probe points via
diff --git a/Documentation/trace/uprobetracer.txt b/Documentation/trace/upr=
obetracer.txt
index fa7b680..bf526a7c 100644
--- a/Documentation/trace/uprobetracer.txt
+++ b/Documentation/trace/uprobetracer.txt
@@ -7,7 +7,7 @@
 Overview
 --------
 Uprobe based trace events are similar to kprobe based trace events.
-To enable this feature, build your kernel with CONFIG_UPROBE_EVENT=3Dy.
+To enable this feature, build your kernel with CONFIG_UPROBE_EVENTS=3Dy.
=20
 Similar to the kprobe-event tracer, this doesn't need to be activated via
 current_tracer. Instead of that, add probe points via
diff --git a/arch/powerpc/configs/85xx/kmp204x_defconfig b/arch/powerpc/con=
figs/85xx/kmp204x_defconfig
index aaaaa60..34a4da2 100644
--- a/arch/powerpc/configs/85xx/kmp204x_defconfig
+++ b/arch/powerpc/configs/85xx/kmp204x_defconfig
@@ -210,7 +210,7 @@ CONFIG_DEBUG_SHIRQ=3Dy
 CONFIG_DETECT_HUNG_TASK=3Dy
 CONFIG_SCHEDSTATS=3Dy
 CONFIG_RCU_TRACE=3Dy
-CONFIG_UPROBE_EVENT=3Dy
+CONFIG_UPROBE_EVENTS=3Dy
 CONFIG_CRYPTO_NULL=3Dy
 CONFIG_CRYPTO_PCBC=3Dm
 CONFIG_CRYPTO_MD4=3Dy
diff --git a/arch/s390/configs/default_defconfig b/arch/s390/configs/defaul=
t_defconfig
index e0097536..53d7cbb 100644
--- a/arch/s390/configs/default_defconfig
+++ b/arch/s390/configs/default_defconfig
@@ -609,7 +609,7 @@ CONFIG_SCHED_TRACER=3Dy
 CONFIG_FTRACE_SYSCALLS=3Dy
 CONFIG_STACK_TRACER=3Dy
 CONFIG_BLK_DEV_IO_TRACE=3Dy
-CONFIG_UPROBE_EVENT=3Dy
+CONFIG_UPROBE_EVENTS=3Dy
 CONFIG_FUNCTION_PROFILER=3Dy
 CONFIG_HIST_TRIGGERS=3Dy
 CONFIG_TRACE_ENUM_MAP_FILE=3Dy
diff --git a/arch/s390/configs/gcov_defconfig b/arch/s390/configs/gcov_defc=
onfig
index f05d2d6..0de46cc 100644
--- a/arch/s390/configs/gcov_defconfig
+++ b/arch/s390/configs/gcov_defconfig
@@ -560,7 +560,7 @@ CONFIG_SCHED_TRACER=3Dy
 CONFIG_FTRACE_SYSCALLS=3Dy
 CONFIG_STACK_TRACER=3Dy
 CONFIG_BLK_DEV_IO_TRACE=3Dy
-CONFIG_UPROBE_EVENT=3Dy
+CONFIG_UPROBE_EVENTS=3Dy
 CONFIG_FUNCTION_PROFILER=3Dy
 CONFIG_HIST_TRIGGERS=3Dy
 CONFIG_TRACE_ENUM_MAP_FILE=3Dy
diff --git a/arch/s390/configs/performance_defconfig b/arch/s390/configs/pe=
rformance_defconfig
index 2cf8734..e77f0dc 100644
--- a/arch/s390/configs/performance_defconfig
+++ b/arch/s390/configs/performance_defconfig
@@ -558,7 +558,7 @@ CONFIG_SCHED_TRACER=3Dy
 CONFIG_FTRACE_SYSCALLS=3Dy
 CONFIG_STACK_TRACER=3Dy
 CONFIG_BLK_DEV_IO_TRACE=3Dy
-CONFIG_UPROBE_EVENT=3Dy
+CONFIG_UPROBE_EVENTS=3Dy
 CONFIG_FUNCTION_PROFILER=3Dy
 CONFIG_HIST_TRIGGERS=3Dy
 CONFIG_TRACE_ENUM_MAP_FILE=3Dy
diff --git a/arch/s390/defconfig b/arch/s390/defconfig
index d00e368..0732a7f 100644
--- a/arch/s390/defconfig
+++ b/arch/s390/defconfig
@@ -179,7 +179,7 @@ CONFIG_FTRACE_SYSCALLS=3Dy
 CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP=3Dy
 CONFIG_STACK_TRACER=3Dy
 CONFIG_BLK_DEV_IO_TRACE=3Dy
-CONFIG_UPROBE_EVENT=3Dy
+CONFIG_UPROBE_EVENTS=3Dy
 CONFIG_FUNCTION_PROFILER=3Dy
 CONFIG_TRACE_ENUM_MAP_FILE=3Dy
 CONFIG_KPROBES_SANITY_TEST=3Dy
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index d503800..d4a06e7 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -429,7 +429,7 @@ config BLK_DEV_IO_TRACE
=20
 	  If unsure, say N.
=20
-config KPROBE_EVENT
+config KPROBE_EVENTS
 	depends on KPROBES
 	depends on HAVE_REGS_AND_STACK_ACCESS_API
 	bool "Enable kprobes-based dynamic events"
@@ -447,7 +447,7 @@ config KPROBE_EVENT
 	  This option is also required by perf-probe subcommand of perf tools.
 	  If you want to use perf tools, this option is strongly recommended.
=20
-config UPROBE_EVENT
+config UPROBE_EVENTS
 	bool "Enable uprobes-based dynamic events"
 	depends on ARCH_SUPPORTS_UPROBES
 	depends on MMU
@@ -466,7 +466,7 @@ config UPROBE_EVENT
=20
 config BPF_EVENTS
 	depends on BPF_SYSCALL
-	depends on (KPROBE_EVENT || UPROBE_EVENT) && PERF_EVENTS
+	depends on (KPROBE_EVENTS || UPROBE_EVENTS) && PERF_EVENTS
 	bool
 	default y
 	help
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index e579808..90f2701 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -57,7 +57,7 @@ obj-$(CONFIG_EVENT_TRACING) +=3D trace_events_filter.o
 obj-$(CONFIG_EVENT_TRACING) +=3D trace_events_trigger.o
 obj-$(CONFIG_HIST_TRIGGERS) +=3D trace_events_hist.o
 obj-$(CONFIG_BPF_EVENTS) +=3D bpf_trace.o
-obj-$(CONFIG_KPROBE_EVENT) +=3D trace_kprobe.o
+obj-$(CONFIG_KPROBE_EVENTS) +=3D trace_kprobe.o
 obj-$(CONFIG_TRACEPOINTS) +=3D power-traces.o
 ifeq ($(CONFIG_PM),y)
 obj-$(CONFIG_TRACEPOINTS) +=3D rpm-traces.o
@@ -66,7 +66,7 @@ ifeq ($(CONFIG_TRACING),y)
 obj-$(CONFIG_KGDB_KDB) +=3D trace_kdb.o
 endif
 obj-$(CONFIG_PROBE_EVENTS) +=3D trace_probe.o
-obj-$(CONFIG_UPROBE_EVENT) +=3D trace_uprobe.o
+obj-$(CONFIG_UPROBE_EVENTS) +=3D trace_uprobe.o
=20
 obj-$(CONFIG_TRACEPOINT_BENCHMARK) +=3D trace_benchmark.o
=20
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index d744978..9a8b415 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4348,22 +4348,22 @@ static const char readme_msg[]  	"\t\t\t  traces\n"
 #endif
 #endif /* CONFIG_STACK_TRACER */
-#ifdef CONFIG_KPROBE_EVENT
+#ifdef CONFIG_KPROBE_EVENTS
 	"  kprobe_events\t\t- Add/remove/show the kernel dynamic events\n"
 	"\t\t\t  Write into this file to define/undefine new trace events.\n"
 #endif
-#ifdef CONFIG_UPROBE_EVENT
+#ifdef CONFIG_UPROBE_EVENTS
 	"  uprobe_events\t\t- Add/remove/show the userspace dynamic events\n"
 	"\t\t\t  Write into this file to define/undefine new trace events.\n"
 #endif
-#if defined(CONFIG_KPROBE_EVENT) || defined(CONFIG_UPROBE_EVENT)
+#if defined(CONFIG_KPROBE_EVENTS) || defined(CONFIG_UPROBE_EVENTS)
 	"\t  accepts: event-definitions (one definition per line)\n"
 	"\t   Format: p|r[:[<group>/]<event>] <place> [<args>]\n"
 	"\t           -:[<group>/]<event>\n"
-#ifdef CONFIG_KPROBE_EVENT
+#ifdef CONFIG_KPROBE_EVENTS
 	"\t    place: [<module>:]<symbol>[+<offset>]|<memaddr>\n"
 #endif
-#ifdef CONFIG_UPROBE_EVENT
+#ifdef CONFIG_UPROBE_EVENTS
 	"\t    place: <path>:<offset>\n"
 #endif
 	"\t     args: <name>=FEtcharg[:type]\n"
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 0c0ae54..903273c 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -248,7 +248,7 @@ ASSIGN_FETCH_FUNC(file_offset, ftype),			\
 #define FETCH_TYPE_STRING	0
 #define FETCH_TYPE_STRSIZE	1
=20
-#ifdef CONFIG_KPROBE_EVENT
+#ifdef CONFIG_KPROBE_EVENTS
 struct symbol_cache;
 unsigned long update_symbol_cache(struct symbol_cache *sc);
 void free_symbol_cache(struct symbol_cache *sc);
@@ -278,7 +278,7 @@ alloc_symbol_cache(const char *sym, long offset)
 {
 	return NULL;
 }
-#endif /* CONFIG_KPROBE_EVENT */
+#endif /* CONFIG_KPROBE_EVENTS */
=20
 struct probe_arg {
 	struct fetch_param	fetch;
--=20
2.9.3

