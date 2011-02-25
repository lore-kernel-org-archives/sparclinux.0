From: Dennis Gilmore <dennis@ausil.us>
Date: Fri, 25 Feb 2011 23:57:15 +0000
Subject: [PATCH] Don't build any of the sparc arch bits with -Werror
Message-Id: <1298678235-29164-1-git-send-email-dennis@ausil.us>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Signed-off-by: Dennis Gilmore <dgilmore@redhat.com>
---
 arch/sparc/kernel/Makefile |    1 -
 arch/sparc/lib/Makefile    |    1 -
 arch/sparc/mm/Makefile     |    1 -
 arch/sparc/prom/Makefile   |    1 -
 4 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 599398f..e38a367 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -3,7 +3,6 @@
 #
 
 asflags-y := -ansi
-ccflags-y := -Werror
 
 extra-y     := head_$(BITS).o
 extra-y     += init_task.o
diff --git a/arch/sparc/lib/Makefile b/arch/sparc/lib/Makefile
index 846d1c4..c2ed034 100644
--- a/arch/sparc/lib/Makefile
+++ b/arch/sparc/lib/Makefile
@@ -2,7 +2,6 @@
 #
 
 asflags-y := -ansi -DST_DIV0=0x02
-ccflags-y := -Werror
 
 lib-$(CONFIG_SPARC32) += mul.o rem.o sdiv.o udiv.o umul.o urem.o ashrdi3.o
 lib-$(CONFIG_SPARC32) += memcpy.o memset.o
diff --git a/arch/sparc/mm/Makefile b/arch/sparc/mm/Makefile
index 79836a7..3945501 100644
--- a/arch/sparc/mm/Makefile
+++ b/arch/sparc/mm/Makefile
@@ -2,7 +2,6 @@
 #
 
 asflags-y := -ansi
-ccflags-y := -Werror
 
 obj-$(CONFIG_SPARC64)   += ultra.o tlb.o tsb.o
 obj-y                   += fault_$(BITS).o
diff --git a/arch/sparc/prom/Makefile b/arch/sparc/prom/Makefile
index 8287bbe..52e4e77 100644
--- a/arch/sparc/prom/Makefile
+++ b/arch/sparc/prom/Makefile
@@ -2,7 +2,6 @@
 # Linux.
 #
 asflags := -ansi
-ccflags := -Werror
 
 lib-y                 := bootstr_$(BITS).o
 lib-y                 += init_$(BITS).o
-- 
1.6.6.1

