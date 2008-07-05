From: Sam Ravnborg <sam@ravnborg.org>
Date: Sat, 05 Jul 2008 20:55:10 +0000
Subject: Re: [GIT PULL] unify sparc header files
Message-Id: <20080705205510.GA14032@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080628220235.GA3169@uranus.ravnborg.org>
In-Reply-To: <20080628220235.GA3169@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> 
> So this looks correct except that we include the wrong header file.
> So the test:
> #if defined(__sparc__) && defined(__arch64__)
> 
> is the bad one.
....
> 
> We can fix the -Usparc64 for the vmlinux.lds file if the right check is:
> #if defined(__sparc__) && defined(sparc64)

I think this is the right way to go so I have locally
committed the following patch.
I will adjust the other 25 patches and then drop
you another mail.
It may take a few days as I'm busy with other stuff.

	Sam

commit 642a206ead6b3dc47a3152c428241d542c079461
Author: Sam Ravnborg <sam@ravnborg.org>
Date:   Sat Jul 5 22:47:22 2008 +0200

    sparc: allow use of sparc64 in header files
    
    Move the undefine of sparc64 down into the .lds file
    thus allowing use of the following conditional in
    header files:
    
    :#ifdef sparc64
    :  here goes 64 bit stuff
    :#else
    :  here goes 32 bit stuff
    :#endif
    
    We will use the above when unifying sparc and sparc64.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/arch/sparc64/Makefile b/arch/sparc64/Makefile
index 4b8f2b0..3e897c5 100644
--- a/arch/sparc64/Makefile
+++ b/arch/sparc64/Makefile
@@ -9,8 +9,6 @@
 
 CHECKFLAGS	+= -D__sparc__ -D__sparc_v9__ -m64
 
-CPPFLAGS_vmlinux.lds += -Usparc
-
 LDFLAGS		:= -m elf64_sparc
 
 KBUILD_CFLAGS += -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow \
diff --git a/arch/sparc64/kernel/Makefile b/arch/sparc64/kernel/Makefile
index ec4f5eb..f9273c8 100644
--- a/arch/sparc64/kernel/Makefile
+++ b/arch/sparc64/kernel/Makefile
@@ -5,6 +5,9 @@
 EXTRA_AFLAGS := -ansi
 EXTRA_CFLAGS := -Werror
 
+# Override default CPPFLAGS to avoid undef of sparc64
+CPPFLAGS_vmlinux.lds += -P -C
+
 extra-y		:= head.o init_task.o vmlinux.lds
 
 obj-y		:= process.o setup.o cpu.o idprom.o \
diff --git a/arch/sparc64/kernel/vmlinux.lds.S b/arch/sparc64/kernel/vmlinux.lds.S
index 01f8096..907282f 100644
--- a/arch/sparc64/kernel/vmlinux.lds.S
+++ b/arch/sparc64/kernel/vmlinux.lds.S
@@ -3,6 +3,9 @@
 #include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
 
+/* We use sparc symbol below so override the gcc define of sparc */
+#undef sparc
+
 OUTPUT_FORMAT("elf64-sparc", "elf64-sparc", "elf64-sparc")
 OUTPUT_ARCH(sparc:v9a)
 ENTRY(_start)
