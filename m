From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 25 May 2007 18:47:33 +0000
Subject: [GIT PATCHES for -rc] fix alignment error in sparc64 linker script
Message-Id: <20070525184733.GA9513@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Linus.

Davem asked me to look at the sparc64 linker script.
It used a hardcoded alignment value of 8192 where the correct
size is PAGE_SIZE (which may be 8192).

I have made both a minimal fix (see below) and
a version where the linker script becomes as readable as linker scripts can be.

== Fix that includes cleanup of vmlinux.lds for sparc64

The fix touches asm-generic/vmlinux.lds.h but will not
impact other architectures.

The patches can be pulled from:
git pull git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild-fix.git

Patches has been sent to peer review at lkml + sparclinux.
David asked me to mark them "Signed-off-by" but 
my understanding are that Signed-off-by: document the path of a patch
so they are marked "Acked-by:".

Here is shortlog + diffstat.

Sam Ravnborg (5):
      sparc64: ident vmlinux.lds.S
      asm-generic: add RO_DATA which take alignment parameter
      sparc64: use PAGE_SIZE in vmlinux.lds
      asm-generic: add INITRAMFS to vmlinux.lds.h
      sparc64: use INITRAMFS in vmlinux.lds.h

 arch/sparc64/kernel/vmlinux.lds.S |  241 +++++++++++++++++++++----------------
 include/asm-generic/vmlinux.lds.h |   22 +++-
 2 files changed, 159 insertions(+), 104 deletions(-)

== The minimal fix

The minimal fix would be to just replace use of 8192 with PAGE_SIZE.
This is indeed a much smaller patch.
If you prefer the smaller patch considering the -rc progress I
have pushed that out in the branch 'minimal'.
In this case please pull from the branch minimal:
git pull git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild-fix.git minimal

diffstat and diff for the minimal fix below.

	Sam

 arch/sparc64/kernel/vmlinux.lds.S |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/sparc64/kernel/vmlinux.lds.S b/arch/sparc64/kernel/vmlinux.lds.S
index fb648de..7fdabed 100644
--- a/arch/sparc64/kernel/vmlinux.lds.S
+++ b/arch/sparc64/kernel/vmlinux.lds.S
@@ -1,5 +1,6 @@
 /* ld script to make UltraLinux kernel */
 
+#include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
 
 OUTPUT_FORMAT("elf64-sparc", "elf64-sparc", "elf64-sparc")
@@ -44,7 +45,7 @@ SECTIONS
   __ex_table : { *(__ex_table) }
   __stop___ex_table = .;
 
-  . = ALIGN(8192);
+  . = ALIGN(PAGE_SIZE);
   __init_begin = .;
   .init.text : { 
 	_sinittext = .;
@@ -83,17 +84,17 @@ SECTIONS
   __sun4v_2insn_patch_end = .;
 
 #ifdef CONFIG_BLK_DEV_INITRD
-  . = ALIGN(8192); 
+  . = ALIGN(PAGE_SIZE);
   __initramfs_start = .;
   .init.ramfs : { *(.init.ramfs) }
   __initramfs_end = .;
 #endif
 
-  . = ALIGN(8192);
+  . = ALIGN(PAGE_SIZE);
   __per_cpu_start = .;
   .data.percpu  : { *(.data.percpu) }
   __per_cpu_end = .;
-  . = ALIGN(8192);
+  . = ALIGN(PAGE_SIZE);
   __init_end = .;
   __bss_start = .;
   .sbss      : { *(.sbss) *(.scommon) }
