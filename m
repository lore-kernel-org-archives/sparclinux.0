From: David Miller <davem@davemloft.net>
Date: Tue, 23 Oct 2018 02:19:44 +0000
Subject: [PATCH 7/8] sparc: Validate VDSO for undefined symbols.
Message-Id: <20181022.191944.893306180378542561.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


There should be no undefined symbols in the resulting VDSO image(s).

On sparc, fixed register usage can result in undefined symbols ending
up in the image.  To combat this, we do two things:

1) Define current_thread_info() specially when BUILD_DSO.

2) Ignore "#scratch" register undefined symbols in the output.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/include/asm/thread_info_64.h |  4 ++++
 arch/sparc/vdso/Makefile                |  3 ++-
 arch/sparc/vdso/checkundef.sh           | 10 ++++++++++
 3 files changed, 16 insertions(+), 1 deletion(-)
 create mode 100644 arch/sparc/vdso/checkundef.sh

diff --git a/arch/sparc/include/asm/thread_info_64.h b/arch/sparc/include/asm/thread_info_64.h
index 7fb676360928..20255471e653 100644
--- a/arch/sparc/include/asm/thread_info_64.h
+++ b/arch/sparc/include/asm/thread_info_64.h
@@ -121,8 +121,12 @@ struct thread_info {
 }
 
 /* how to get the thread information struct from C */
+#ifndef BUILD_VDSO
 register struct thread_info *current_thread_info_reg asm("g6");
 #define current_thread_info()	(current_thread_info_reg)
+#else
+extern struct thread_info *current_thread_info(void);
+#endif
 
 /* thread information allocation */
 #if PAGE_SHIFT = 13
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index a9e3a4f633a7..a6e18ca4cc18 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -111,7 +111,8 @@ $(obj)/vdso32.so.dbg: FORCE \
 quiet_cmd_vdso = VDSO    $@
       cmd_vdso = $(LD) -nostdlib -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
-		       -T $(filter %.lds,$^) $(filter %.o,$^)
+		       -T $(filter %.lds,$^) $(filter %.o,$^) && \
+		sh $(srctree)/$(src)/checkundef.sh '$(OBJDUMP)' '$@'
 
 VDSO_LDFLAGS = -shared $(call ld-option, --hash-style=both) \
 	$(call ld-option, --build-id) -Bsymbolic
diff --git a/arch/sparc/vdso/checkundef.sh b/arch/sparc/vdso/checkundef.sh
new file mode 100644
index 000000000000..2d85876ffc32
--- /dev/null
+++ b/arch/sparc/vdso/checkundef.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+objdump="$1"
+file="$2"
+$objdump -t "$file" | grep '*UUND*' | grep -v '#scratch' > /dev/null 2>&1
+if [ $? -eq 1 ]; then
+    exit 0
+else
+    echo "$file: undefined symbols found" >&2
+    exit 1
+fi
-- 
2.19.1.328.g5a0cc8aca
