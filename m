From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 22 Oct 2007 09:17:33 +0000
Subject: [PATCH] sparc64: small Makefile cleanups
Message-Id: <20071022091733.GA11932@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

A few trivial Makefile cleanups
- dependencipes in head.o was all wrong - deleted
- CMODEL_CFLAG was not used anywhere
- NEW_GCC was then not used outside sparc64/Makefe - do not export it
- FIXME seems not appropriate - all other put oprofile in drivers-y too
- No reason to do -I. (and it still builds)

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
build tested only
Stumbled over these when looking for other things.

	Sam

diff --git a/arch/sparc64/Makefile b/arch/sparc64/Makefile
index 6c92a42..01159cb 100644
--- a/arch/sparc64/Makefile
+++ b/arch/sparc64/Makefile
@@ -18,8 +18,6 @@ NEW_GCC := $(call cc-option-yn, -m64 -mcmodel=medlow)
 NEW_GAS := $(shell if $(LD) -V 2>&1 | grep 'elf64_sparc' > /dev/null; then echo y; else echo n; fi)
 UNDECLARED_REGS := $(shell if $(CC) -c -x assembler /dev/null -Wa,--help | grep undeclared-regs > /dev/null; then echo y; else echo n; fi; )
 
-export NEW_GCC
-
 ifneq ($(NEW_GAS),y)
 AS		= sparc64-linux-as
 LD		= sparc64-linux-ld
@@ -58,8 +56,6 @@ core-y				+= arch/sparc64/kernel/ arch/sparc64/mm/
 core-$(CONFIG_SOLARIS_EMUL)	+= arch/sparc64/solaris/
 core-y				+= arch/sparc64/math-emu/
 libs-y				+= arch/sparc64/prom/ arch/sparc64/lib/
-
-# FIXME: is drivers- right?
 drivers-$(CONFIG_OPROFILE)	+= arch/sparc64/oprofile/
 
 boot := arch/sparc64/boot
diff --git a/arch/sparc64/kernel/Makefile b/arch/sparc64/kernel/Makefile
index 112c46e..ef50d21 100644
--- a/arch/sparc64/kernel/Makefile
+++ b/arch/sparc64/kernel/Makefile
@@ -39,12 +39,3 @@ else
     obj-y += sys_sunos32.o sunos_ioctl32.o
   endif
 endif
-
-ifneq ($(NEW_GCC),y)
-  CMODEL_CFLAG := -mmedlow
-else
-  CMODEL_CFLAG := -m64 -mcmodel=medlow
-endif
-
-head.o: head.S ttable.S itlb_miss.S dtlb_miss.S ktlb.S tsb.S \
-	etrap.S rtrap.S winfixup.S entry.S
diff --git a/arch/sparc64/math-emu/Makefile b/arch/sparc64/math-emu/Makefile
index a0b06fd..cc5cb9b 100644
--- a/arch/sparc64/math-emu/Makefile
+++ b/arch/sparc64/math-emu/Makefile
@@ -4,4 +4,4 @@
 
 obj-y    := math.o
 
-EXTRA_CFLAGS = -I. -Iinclude/math-emu -w
+EXTRA_CFLAGS = -Iinclude/math-emu -w
