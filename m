From: David Miller <davem@davemloft.net>
Date: Sat, 22 Apr 2017 03:16:58 +0000
Subject: [PATCH 1/2] sparc: Split BPF JIT into 32-bit and 64-bit.
Message-Id: <20170421.201658.403967091238148561.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org
Cc: netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net


This is in preparation for adding the 64-bit eBPF JIT.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/net/Makefile                              | 2 +-
 arch/sparc/net/{bpf_jit.h => bpf_jit_32.h}           | 0
 arch/sparc/net/{bpf_jit_asm.S => bpf_jit_asm_32.S}   | 2 +-
 arch/sparc/net/bpf_jit_asm_64.S                      | 1 +
 arch/sparc/net/{bpf_jit_comp.c => bpf_jit_comp_32.c} | 2 +-
 arch/sparc/net/bpf_jit_comp_64.c                     | 1 +
 6 files changed, 5 insertions(+), 3 deletions(-)
 rename arch/sparc/net/{bpf_jit.h => bpf_jit_32.h} (100%)
 rename arch/sparc/net/{bpf_jit_asm.S => bpf_jit_asm_32.S} (99%)
 create mode 100644 arch/sparc/net/bpf_jit_asm_64.S
 rename arch/sparc/net/{bpf_jit_comp.c => bpf_jit_comp_32.c} (99%)
 create mode 100644 arch/sparc/net/bpf_jit_comp_64.c

diff --git a/arch/sparc/net/Makefile b/arch/sparc/net/Makefile
index 1306a58..76fa8e9 100644
--- a/arch/sparc/net/Makefile
+++ b/arch/sparc/net/Makefile
@@ -1,4 +1,4 @@
 #
 # Arch-specific network modules
 #
-obj-$(CONFIG_BPF_JIT) += bpf_jit_asm.o bpf_jit_comp.o
+obj-$(CONFIG_BPF_JIT) += bpf_jit_asm_$(BITS).o bpf_jit_comp_$(BITS).o
diff --git a/arch/sparc/net/bpf_jit.h b/arch/sparc/net/bpf_jit_32.h
similarity index 100%
rename from arch/sparc/net/bpf_jit.h
rename to arch/sparc/net/bpf_jit_32.h
diff --git a/arch/sparc/net/bpf_jit_asm.S b/arch/sparc/net/bpf_jit_asm_32.S
similarity index 99%
rename from arch/sparc/net/bpf_jit_asm.S
rename to arch/sparc/net/bpf_jit_asm_32.S
index 8c83f4b..5632cdc 100644
--- a/arch/sparc/net/bpf_jit_asm.S
+++ b/arch/sparc/net/bpf_jit_asm_32.S
@@ -1,6 +1,6 @@
 #include <asm/ptrace.h>
 
-#include "bpf_jit.h"
+#include "bpf_jit_32.h"
 
 #ifdef CONFIG_SPARC64
 #define SAVE_SZ		176
diff --git a/arch/sparc/net/bpf_jit_asm_64.S b/arch/sparc/net/bpf_jit_asm_64.S
new file mode 100644
index 0000000..6fb023f
--- /dev/null
+++ b/arch/sparc/net/bpf_jit_asm_64.S
@@ -0,0 +1 @@
+#include "bpf_jit_asm_32.S"
diff --git a/arch/sparc/net/bpf_jit_comp.c b/arch/sparc/net/bpf_jit_comp_32.c
similarity index 99%
rename from arch/sparc/net/bpf_jit_comp.c
rename to arch/sparc/net/bpf_jit_comp_32.c
index a6d9204..83fc41d 100644
--- a/arch/sparc/net/bpf_jit_comp.c
+++ b/arch/sparc/net/bpf_jit_comp_32.c
@@ -8,7 +8,7 @@
 #include <asm/cacheflush.h>
 #include <asm/ptrace.h>
 
-#include "bpf_jit.h"
+#include "bpf_jit_32.h"
 
 int bpf_jit_enable __read_mostly;
 
diff --git a/arch/sparc/net/bpf_jit_comp_64.c b/arch/sparc/net/bpf_jit_comp_64.c
new file mode 100644
index 0000000..49b5f65
--- /dev/null
+++ b/arch/sparc/net/bpf_jit_comp_64.c
@@ -0,0 +1 @@
+#include "bpf_jit_comp_32.c"
-- 
2.1.2.532.g19b5d50

