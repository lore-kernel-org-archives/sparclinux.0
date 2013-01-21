From: Jan Kiszka <jan.kiszka@siemens.com>
Date: Mon, 21 Jan 2013 17:06:19 +0000
Subject: [PATCH v4 12/13] scripts/gdb: Add internal helper and convenience function for per-cpu lookup
Message-Id: <e913509a1d1aa0e28cd118fb3fdd4dd277f8592b.1358787929.git.jan.kiszka@siemens.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1358787929.git.jan.kiszka@siemens.com>
In-Reply-To: <cover.1358787929.git.jan.kiszka@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Cc: Jason Wessel <jason.wessel@windriver.com>, kgdb-bugreport@lists.sourceforge.net, Andi Kleen <andi@firstfloor.org>, Tom Tromey <tromey@redhat.com>, Ben Widawsky <ben@bwidawsk.net>, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

This function allows to obtain a per-cpu variable, either of the current
or an explicitly specified CPU.

Note: sparc64 version is untested.

CC: "David S. Miller" <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
---
 scripts/gdb/percpu.py      |   61 ++++++++++++++++++++++++++++++++++++++++++++
 scripts/gdb/vmlinux-gdb.py |    1 +
 2 files changed, 62 insertions(+), 0 deletions(-)
 create mode 100644 scripts/gdb/percpu.py

diff --git a/scripts/gdb/percpu.py b/scripts/gdb/percpu.py
new file mode 100644
index 0000000..e2556919
--- /dev/null
+++ b/scripts/gdb/percpu.py
@@ -0,0 +1,61 @@
+#
+# gdb helper commands and functions for Linux kernel debugging
+#
+#  per-cpu tools
+#
+# Copyright (c) Siemens AG, 2011, 2012
+#
+# Authors:
+#  Jan Kiszka <jan.kiszka@siemens.com>
+#
+# This work is licensed under the terms of the GNU GPL version 2.
+#
+
+import gdb
+
+from utils import *
+from task import *
+
+MAX_CPUS = 4096
+
+def get_current_cpu():
+	if get_gdbserver_type() = GDBSERVER_QEMU:
+		return gdb.selected_thread().num - 1
+	elif get_gdbserver_type() = GDBSERVER_KGDB:
+		tid = gdb.selected_thread().ptid[2]
+		if tid > (0x100000000 - MAX_CPUS - 2):
+			return 0x100000000 - tid - 2
+		else:
+			return get_thread_info(get_task_by_pid(tid))['cpu']
+	else:
+		raise gdb.GdbError("Sorry, obtaining the current CPU is "
+				   "not yet supported with this gdb server.")
+
+def per_cpu(var_name, cpu):
+	var = gdb.parse_and_eval("&" + var_name)
+	if cpu = -1:
+		cpu = get_current_cpu()
+	if is_target_arch("sparc:v9"):
+		offset = gdb.parse_and_eval("trap_block[" + str(cpu) +
+					    "].__per_cpu_base")
+	else:
+		offset = gdb.parse_and_eval("__per_cpu_offset[" + str(cpu) +
+					    "]")
+	pointer = var.cast(get_long_type()) + offset
+	return pointer.cast(var.type).dereference()
+
+
+class PerCpu(gdb.Function):
+	__doc__ = "Return per-cpu variable.\n" \
+		  "\n" \
+		  "$lx_per_cpu(\"VAR\"[, CPU]): Return the per-cpu variable called VAR for the\n" \
+		  "given CPU number. If CPU is omitted, the CPU of the current context is used.\n" \
+		  "Note that VAR has to be quoted as string."
+
+	def __init__(self):
+		super(PerCpu, self).__init__("lx_per_cpu")
+
+	def invoke(self, var_name, cpu = -1):
+		return per_cpu(var_name.string(), cpu)
+
+PerCpu()
diff --git a/scripts/gdb/vmlinux-gdb.py b/scripts/gdb/vmlinux-gdb.py
index e78b353..6606247 100644
--- a/scripts/gdb/vmlinux-gdb.py
+++ b/scripts/gdb/vmlinux-gdb.py
@@ -25,3 +25,4 @@ else:
 	import symbols
 	import dmesg
 	import task
+	import percpu
-- 
1.7.3.4

