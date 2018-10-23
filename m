From: David Miller <davem@davemloft.net>
Date: Tue, 23 Oct 2018 02:19:35 +0000
Subject: [PATCH 4/8] sparc: Set DISABLE_BRANCH_PROFILING in VDSO CFLAGS.
Message-Id: <20181022.191935.1886399460386063441.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Not in vclock_gettime.c itself.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/vdso/Makefile         | 3 ++-
 arch/sparc/vdso/vclock_gettime.c | 5 -----
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index dc85570d8839..7ea03dd2bd62 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -58,7 +58,8 @@ CFL := $(PROFILING) -mcmodel=medlow -fPIC -O2 -fasynchronous-unwind-tables \
        -m64 -ffixed-g2 -ffixed-g3 -fcall-used-g4 -fcall-used-g5 -ffixed-g6 \
        -ffixed-g7 $(filter -g%,$(KBUILD_CFLAGS)) \
        $(call cc-option, -fno-stack-protector) -fno-omit-frame-pointer \
-       -foptimize-sibling-calls -DBUILD_VDSO
+       -foptimize-sibling-calls \
+       -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 
 $(vobjs): KBUILD_CFLAGS += $(CFL)
 
diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettime.c
index 4e853d1582c7..7b5bf63fc0f5 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -12,11 +12,6 @@
  * Copyright (c) 2017 Oracle and/or its affiliates. All rights reserved.
  */
 
-/* Disable profiling for userspace code: */
-#ifndef	DISABLE_BRANCH_PROFILING
-#define	DISABLE_BRANCH_PROFILING
-#endif
-
 #include <linux/kernel.h>
 #include <linux/time.h>
 #include <linux/string.h>
-- 
2.19.1.328.g5a0cc8aca
