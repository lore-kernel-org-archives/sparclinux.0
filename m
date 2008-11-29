From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 29 Nov 2008 22:05:48 +0000
Subject: [PATCH 04/10] sparc: refactor Makefile
Message-Id: <1227996354-11478-4-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The btfixup step needs knowledge of all the .o files,
but there is no need to pass them in independent variables.
Simplify it to use only two variables.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Makefile      |   18 +++++-------------
 arch/sparc/boot/Makefile |    4 ++--
 2 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index c5f3d6f..04ea968 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -27,7 +27,6 @@ CPPFLAGS_vmlinux.lds += -m32
 LDFLAGS_vmlinux = -r
 
 head-y := arch/sparc/kernel/head.o arch/sparc/kernel/init_task.o
-HEAD_Y := $(head-y)
 
 core-y += arch/sparc/kernel/ arch/sparc/mm/ arch/sparc/math-emu/
 libs-y += arch/sparc/prom/ arch/sparc/lib/
@@ -35,23 +34,16 @@ libs-y += arch/sparc/prom/ arch/sparc/lib/
 drivers-$(CONFIG_OPROFILE)	+= arch/sparc/oprofile/
 
 # Export what is needed by arch/sparc/boot/Makefile
-# Renaming is done to avoid confusing pattern matching rules in 2.5.45 (multy-)
-INIT_Y		:= $(patsubst %/, %/built-in.o, $(init-y))
-CORE_Y		:= $(core-y)
-CORE_Y		+= kernel/ mm/ fs/ ipc/ security/ crypto/ block/
-CORE_Y		:= $(patsubst %/, %/built-in.o, $(CORE_Y))
-DRIVERS_Y	:= $(patsubst %/, %/built-in.o, $(drivers-y))
-NET_Y		:= $(patsubst %/, %/built-in.o, $(net-y))
-LIBS_Y1		:= $(patsubst %/, %/lib.a, $(libs-y))
-LIBS_Y2		:= $(patsubst %/, %/built-in.o, $(libs-y))
-LIBS_Y		:= $(LIBS_Y1) $(LIBS_Y2)
+export VMLINUX_INIT VMLINUX_MAIN
+VMLINUX_INIT := $(head-y) $(init-y)
+VMLINUX_MAIN := $(core-y) kernel/ mm/ fs/ ipc/ security/ crypto/ block/
+VMLINUX_MAIN += $(patsubst %/, %/lib.a, $(libs-y)) $(libs-y)
+VMLINUX_MAIN += $(drivers-y) $(net-y)
 
 ifdef CONFIG_KALLSYMS
 kallsyms.o := .tmp_kallsyms2.o
 endif
 
-export INIT_Y CORE_Y DRIVERS_Y NET_Y LIBS_Y HEAD_Y kallsyms.o
-
 # Default target
 all: zImage
 
diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index 3e77a9f..4fd5620 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -37,8 +37,8 @@ define rule_image
 	echo 'cmd_$@ := $(cmd_image)' > $(@D)/.$(@F).cmd
 endef
 
-BTOBJS := $(HEAD_Y) $(INIT_Y)
-BTLIBS := $(CORE_Y) $(LIBS_Y) $(DRIVERS_Y) $(NET_Y)
+BTOBJS := $(patsubst %/, %/built-in.o, $(VMLINUX_INIT))
+BTLIBS := $(patsubst %/, %/built-in.o, $(VMLINUX_MAIN))
 LDFLAGS_image := -T arch/sparc/kernel/vmlinux.lds $(BTOBJS) \
                   --start-group $(BTLIBS) --end-group \
                   $(kallsyms.o) $(obj)/btfix.o
-- 
1.5.6.GIT

