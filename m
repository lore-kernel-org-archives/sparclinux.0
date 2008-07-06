From: Sam Ravnborg <sam@ravnborg.org>
Date: Sun, 06 Jul 2008 20:06:37 +0000
Subject: Re: [GIT PULL] unify sparc header files
Message-Id: <20080706200636.GA29523@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080628220235.GA3169@uranus.ravnborg.org>
In-Reply-To: <20080628220235.GA3169@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> Of course, you want me to provide "cpp -m64..." not just "cpp" output.
> Because otherwise it will produce a list of 32-bit CPP predefines.  As
> you can see in the sparc64 Makefiles we add "-m64" to the CFLAGS.
> 
> Maybe that's the problem?  Normal CFLAGS are not being propagated to
> the CPP's CFLAGS.  And you guys don't see it because you are using
> cross compilers which default to 64-bit output.  That would explain
> everything.

That makes perfect sense. I should have deduced that myself
if I had just thought a bit longer about it.
In almost all uses of CPP we do not need -m64 but with
unified headers it is obviously needed.


I have now added the appended commit and the full series
can be pulled from:

   ssh://master.kernel.org/pub/scm/linux/kernel/git/sam/sparc2.git master

I have tested that sparc64 continue to build and that we indeed
add the -m64 option to gcc when we build vmlinux.lds
iLet me know if this series is better.

	Sam

Shortlog:

Sam Ravnborg (26):
      sparc: add -m64 when building vmlinux.lds
      sparc: copy exported sparc64 specific header files to asm-sparc
      sparc: Merge asm-sparc{,64}/ioctl.h
      sparc: Merge asm-sparc{,64}/ioctls.h
      sparc: Merge asm-sparc{,64}/param.h
      sparc: Merge asm-sparc{,64}/poll.h
      sparc: Merge asm-sparc{,64}/socket.h
      sparc: Merge asm-sparc{,64}/sockios.h
      sparc: Merge asm-sparc{,64}/fcntl.h
      sparc: Merge asm-sparc{,64}/msgbuf.h
      sparc: Merge asm-sparc{,64}/sembuf.h
      sparc: Merge asm-sparc{,64}/shmbuf.h
      sparc: Merge asm-sparc{,64}/mman.h
      sparc: copy asm-sparc64/fbio.h to asm-sparc
      sparc: Merge asm-sparc{,64}/fbio.h
      sparc: Merge asm-sparc{,64}/resource.h
      sparc: Merge asm-sparc{,64}/setup.h
      sparc: Merge asm-sparc{,64}/termbits.h
      sparc: Merge asm-sparc{,64}/termios.h
      sparc: Merge asm-sparc{,64}/types.h
      sparc: export openprom.h to userspace
      sparc: Merge asm-sparc{,64}/asi.h
      sparc: copy sparc64 specific files to asm-sparc
      sparc: when header files are equal use asm-sparc version
      sparc: merge header files with trivial differences
      sparc: join the remaining header files

Diffstat has not changed (except for the commit below - so omitted.

The commit to fix up -m64 usage:


commit 9fe10bc6fd5aafee2934e35614689e6e905228f7
Author: Sam Ravnborg <sam@ravnborg.org>
Date:   Sun Jul 6 21:41:51 2008 +0200

    sparc: add -m64 when building vmlinux.lds
    
    David Miller noticed that the build of vmlinux.lds
    failed to use the -m64 specifier.
    This caused the build to break with a bi-arch gcc with
    unified headers.
    
    Add the -m64 option to KBUILD_CPPFLAGS so all of
    CC, AS, CPP will use them.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/arch/sparc64/Makefile b/arch/sparc64/Makefile
index 4b8f2b0..0c135c7 100644
--- a/arch/sparc64/Makefile
+++ b/arch/sparc64/Makefile
@@ -9,15 +9,19 @@
 
 CHECKFLAGS	+= -D__sparc__ -D__sparc_v9__ -m64
 
+# We always build for 64 bit
+KBUILD_CPPFLAGS += -m64
+
+# Undefine sparc for vmlinux.lds as the linker uses this symbol
 CPPFLAGS_vmlinux.lds += -Usparc
 
 LDFLAGS		:= -m elf64_sparc
 
-KBUILD_CFLAGS += -m64 -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow \
+KBUILD_CFLAGS += -pipe -mno-fpu -mcpu=ultrasparc -mcmodel=medlow \
 	-ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare \
 	-Wa,--undeclared-regs
 KBUILD_CFLAGS += $(call cc-option,-mtune=ultrasparc3)
-KBUILD_AFLAGS += -m64 -mcpu=ultrasparc -Wa,--undeclared-regs
+KBUILD_AFLAGS += -mcpu=ultrasparc -Wa,--undeclared-regs
 
 ifeq ($(CONFIG_MCOUNT),y)
   KBUILD_CFLAGS += -pg
