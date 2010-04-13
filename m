From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 06:42:47 +0000
Subject: [PATCH 4/7] sparc64: Remove profiling from some low-level bits.
Message-Id: <20100412.234247.144366825.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


These include the timer implementation, perf events support, and the
performance counter register (pcr) programming layer.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/Makefile |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index c631614..1b35ed6 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -13,6 +13,14 @@ extra-y     += init_task.o
 CPPFLAGS_vmlinux.lds := -Usparc -m$(BITS)
 extra-y              += vmlinux.lds
 
+ifdef CONFIG_FUNCTION_TRACER
+# Do not profile debug and lowlevel utilities
+CFLAGS_REMOVE_ftrace.o := -pg
+CFLAGS_REMOVE_time_$(BITS).o := -pg
+CFLAGS_REMOVE_perf_event.o := -pg
+CFLAGS_REMOVE_pcr.o := -pg
+endif
+
 obj-$(CONFIG_SPARC32)   += entry.o wof.o wuf.o
 obj-$(CONFIG_SPARC32)   += etrap_32.o
 obj-$(CONFIG_SPARC32)   += rtrap_32.o
@@ -85,7 +93,6 @@ obj-$(CONFIG_KGDB)        += kgdb_$(BITS).o
 
 
 obj-$(CONFIG_DYNAMIC_FTRACE) += ftrace.o
-CFLAGS_REMOVE_ftrace.o := -pg
 
 obj-$(CONFIG_EARLYFB) += btext.o
 obj-$(CONFIG_STACKTRACE)     += stacktrace.o
-- 
1.7.0.4

