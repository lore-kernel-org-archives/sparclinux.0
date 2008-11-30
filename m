From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 30 Nov 2008 20:15:28 +0000
Subject: [PATCH 1/5] sparc: prepare lib/ for unification
Message-Id: <1228076132-18036-1-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Identical named files renamed to <name>_32.S
Refactored Makefile to prepare for unification.

Linking order was altered slightly - but this is a lib.a file so
it should not matter.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/lib/Makefile                            |   35 ++++++++++++-------
 arch/sparc/lib/{atomic.S => atomic_32.S}           |    0
 arch/sparc/lib/{checksum.S => checksum_32.S}       |    0
 arch/sparc/lib/{memcmp.S => memcmp_32.S}           |    0
 arch/sparc/lib/{memscan.S => memscan_32.S}         |    0
 arch/sparc/lib/{rwsem.S => rwsem_32.S}             |    0
 arch/sparc/lib/{strlen.S => strlen_32.S}           |    0
 arch/sparc/lib/{strlen_user.S => strlen_user_32.S} |    0
 arch/sparc/lib/{strncmp.S => strncmp_32.S}         |    0
 ...{strncpy_from_user.S => strncpy_from_user_32.S} |    0
 10 files changed, 22 insertions(+), 13 deletions(-)
 rewrite arch/sparc/lib/Makefile (89%)
 rename arch/sparc/lib/{atomic.S => atomic_32.S} (100%)
 rename arch/sparc/lib/{checksum.S => checksum_32.S} (100%)
 rename arch/sparc/lib/{memcmp.S => memcmp_32.S} (100%)
 rename arch/sparc/lib/{memscan.S => memscan_32.S} (100%)
 rename arch/sparc/lib/{rwsem.S => rwsem_32.S} (100%)
 rename arch/sparc/lib/{strlen.S => strlen_32.S} (100%)
 rename arch/sparc/lib/{strlen_user.S => strlen_user_32.S} (100%)
 rename arch/sparc/lib/{strncmp.S => strncmp_32.S} (100%)
 rename arch/sparc/lib/{strncpy_from_user.S => strncpy_from_user_32.S} (100%)

diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
dissimilarity index 89%
index 6e303e1..f265054 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -1,13 +1,22 @@
-# Makefile for Sparc library files..
-#
-
-EXTRA_AFLAGS := -ansi -DST_DIV0=0x02
-
-lib-y := mul.o rem.o sdiv.o udiv.o umul.o urem.o ashrdi3.o memcpy.o memset.o \
-         strlen.o checksum.o blockops.o memscan.o memcmp.o strncmp.o \
-	 strncpy_from_user.o divdi3.o udivdi3.o strlen_user.o \
-	 copy_user.o locks.o atomic.o \
-	 lshrdi3.o ashldi3.o rwsem.o muldi3.o bitext.o \
-	 cmpdi2.o
-
-obj-y += iomap.o atomic32.o
+# Makefile for Sparc library files..
+#
+
+asflags-y := -ansi -DST_DIV0=0x02
+ccflags-y := -Werror
+
+lib-$(CONFIG_SPARC32) += mul.o rem.o sdiv.o udiv.o umul.o urem.o ashrdi3.o
+lib-$(CONFIG_SPARC32) += memcpy.o memset.o
+lib-y                 += strlen_$(BITS).o
+lib-y                 += checksum_$(BITS).o
+lib-$(CONFIG_SPARC32) += blockops.o
+lib-y                 += memscan_$(BITS).o memcmp_$(BITS).o strncmp_$(BITS).o
+lib-y                 += strncpy_from_user_$(BITS).o strlen_user_$(BITS).o
+lib-$(CONFIG_SPARC32) += divdi3.o udivdi3.o
+lib-$(CONFIG_SPARC32) += copy_user.o locks.o
+lib-y                 += atomic_$(BITS).o
+lib-$(CONFIG_SPARC32) += lshrdi3.o ashldi3.o
+lib-y                 += rwsem_$(BITS).o
+lib-$(CONFIG_SPARC32) += muldi3.o bitext.o cmpdi2.o
+
+obj-y                 += iomap.o
+obj-$(CONFIG_SPARC32) += atomic32.o
diff --git a/arch/sparc/lib/atomic.S b/arch/sparc/lib/atomic_32.S
similarity index 100%
rename from arch/sparc/lib/atomic.S
rename to arch/sparc/lib/atomic_32.S
diff --git a/arch/sparc/lib/checksum.S b/arch/sparc/lib/checksum_32.S
similarity index 100%
rename from arch/sparc/lib/checksum.S
rename to arch/sparc/lib/checksum_32.S
diff --git a/arch/sparc/lib/memcmp.S b/arch/sparc/lib/memcmp_32.S
similarity index 100%
rename from arch/sparc/lib/memcmp.S
rename to arch/sparc/lib/memcmp_32.S
diff --git a/arch/sparc/lib/memscan.S b/arch/sparc/lib/memscan_32.S
similarity index 100%
rename from arch/sparc/lib/memscan.S
rename to arch/sparc/lib/memscan_32.S
diff --git a/arch/sparc/lib/rwsem.S b/arch/sparc/lib/rwsem_32.S
similarity index 100%
rename from arch/sparc/lib/rwsem.S
rename to arch/sparc/lib/rwsem_32.S
diff --git a/arch/sparc/lib/strlen.S b/arch/sparc/lib/strlen_32.S
similarity index 100%
rename from arch/sparc/lib/strlen.S
rename to arch/sparc/lib/strlen_32.S
diff --git a/arch/sparc/lib/strlen_user.S b/arch/sparc/lib/strlen_user_32.S
similarity index 100%
rename from arch/sparc/lib/strlen_user.S
rename to arch/sparc/lib/strlen_user_32.S
diff --git a/arch/sparc/lib/strncmp.S b/arch/sparc/lib/strncmp_32.S
similarity index 100%
rename from arch/sparc/lib/strncmp.S
rename to arch/sparc/lib/strncmp_32.S
diff --git a/arch/sparc/lib/strncpy_from_user.S b/arch/sparc/lib/strncpy_from_user_32.S
similarity index 100%
rename from arch/sparc/lib/strncpy_from_user.S
rename to arch/sparc/lib/strncpy_from_user_32.S
-- 
1.5.6.GIT

