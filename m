From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 29 Nov 2008 22:05:49 +0000
Subject: [PATCH 05/10] sparc: drop kallsyms bits
Message-Id: <1227996354-11478-5-git-send-email-sam@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The variable kallsyms.o are not exported so boot/Makefile
never sees it. So drop it to avoid being fooled to think
it actually works.

In Makefile a second pass over kallsyms was forced but this
was not justified and is not needed - drop it.

We can add back a working solution if kallsyms support is needed
in the btfixed up kernel.

For now it is better to just drop the stuff as it do not do as
originally intended.

Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/sparc/Makefile      |    4 ----
 arch/sparc/boot/Makefile |    2 +-
 2 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 04ea968..b8d1c5b 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -40,10 +40,6 @@ VMLINUX_MAIN := $(core-y) kernel/ mm/ fs/ ipc/ security/ crypto/ block/
 VMLINUX_MAIN += $(patsubst %/, %/lib.a, $(libs-y)) $(libs-y)
 VMLINUX_MAIN += $(drivers-y) $(net-y)
 
-ifdef CONFIG_KALLSYMS
-kallsyms.o := .tmp_kallsyms2.o
-endif
-
 # Default target
 all: zImage
 
diff --git a/arch/sparc/boot/Makefile b/arch/sparc/boot/Makefile
index 4fd5620..014e3d1 100644
--- a/arch/sparc/boot/Makefile
+++ b/arch/sparc/boot/Makefile
@@ -41,7 +41,7 @@ BTOBJS := $(patsubst %/, %/built-in.o, $(VMLINUX_INIT))
 BTLIBS := $(patsubst %/, %/built-in.o, $(VMLINUX_MAIN))
 LDFLAGS_image := -T arch/sparc/kernel/vmlinux.lds $(BTOBJS) \
                   --start-group $(BTLIBS) --end-group \
-                  $(kallsyms.o) $(obj)/btfix.o
+                  $(obj)/btfix.o
 
 # Link the final image including btfixup'ed symbols.
 # This is a replacement for the link done in the top-level Makefile.
-- 
1.5.6.GIT

