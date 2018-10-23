From: David Miller <davem@davemloft.net>
Date: Tue, 23 Oct 2018 02:19:37 +0000
Subject: [PATCH 5/8] sparc: Improve VDSO CFLAGS.
Message-Id: <20181022.191937.1740608972564144823.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


Do not set any special register usage options, use the default which
is exactly what we should use for userspace code.

Make sure we remove the gcc plugin options from the 64-bit build.
The 32-bit cflags got it right already.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/vdso/Makefile | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 7ea03dd2bd62..3b0d287311c2 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -54,14 +54,14 @@ $(obj)/vdso-image-%.c: $(obj)/vdso%.so.dbg $(obj)/vdso%.so $(obj)/vdso2c FORCE
 # Don't omit frame pointers for ease of userspace debugging, but do
 # optimize sibling calls.
 #
-CFL := $(PROFILING) -mcmodel=medlow -fPIC -O2 -fasynchronous-unwind-tables \
-       -m64 -ffixed-g2 -ffixed-g3 -fcall-used-g4 -fcall-used-g5 -ffixed-g6 \
-       -ffixed-g7 $(filter -g%,$(KBUILD_CFLAGS)) \
-       $(call cc-option, -fno-stack-protector) -fno-omit-frame-pointer \
-       -foptimize-sibling-calls \
+CFL := $(PROFILING) -mcmodel=medlow -fPIC -O2 -fasynchronous-unwind-tables -m64 \
+       $(filter -g%,$(KBUILD_CFLAGS)) $(call cc-option, -fno-stack-protector) \
+       -fno-omit-frame-pointer -foptimize-sibling-calls \
        -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 
-$(vobjs): KBUILD_CFLAGS += $(CFL)
+SPARC_REG_CFLAGS = -ffixed-g4 -ffixed-g5 -fcall-used-g5 -fcall-used-g7
+
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(SPARC_REG_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -92,7 +92,8 @@ KBUILD_CFLAGS_32 := $(filter-out -m64,$(KBUILD_CFLAGS))
 KBUILD_CFLAGS_32 := $(filter-out -mcmodel=medlow,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
-KBUILD_CFLAGS_32 += -m32 -msoft-float -fpic -mno-app-regs -ffixed-g7
+KBUILD_CFLAGS_32 := $(filter-out $(SPARC_REG_CFLAGS),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 += -m32 -msoft-float -fpic
 KBUILD_CFLAGS_32 += $(call cc-option, -fno-stack-protector)
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
 KBUILD_CFLAGS_32 += -fno-omit-frame-pointer
-- 
2.19.1.328.g5a0cc8aca
