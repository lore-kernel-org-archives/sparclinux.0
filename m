From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 07 Jul 2008 20:54:31 +0000
Subject: Re: [GIT PULL] unify sparc header files
Message-Id: <20080707205431.GA23647@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080628220235.GA3169@uranus.ravnborg.org>
In-Reply-To: <20080628220235.GA3169@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Jul 07, 2008 at 12:54:40AM -0700, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Mon, 7 Jul 2008 09:46:00 +0200
> 
> > # disable pointer signed / unsigned warnings in gcc 4.0
> > KBUILD_CFLAGS += $(call cc-option,-Wno-pointer-sign,)
> > 
> > When we do the above check we use KBUILD_CFLAGS direct
> > and does not include KBUILD_CPPFLAGS - thus missing -m64.
> > 
> > So I think that your bi-arch sparc gcc only accepts
> > -Wno-pointer-sign if -m64 is specified and that this
> > option is missing with current patchset.
> > At least that is my best explanation so far.
> 
> Yep, that the source of the problem.
> 
> What is happening is that the other sparc64 KBUILD_CFLAGS (such as
> -mcmodel=medlow, etc.) are only legal during a 64-bit compile.  When
> compiling 32-bit those options are not allowed.

So I once again updated the patchset - they can be pulled here:

    ssh://master.kernel.org/pub/scm/linux/kernel/git/sam/sparc2.git master

The only change is the replacement of the patch adding -m64.
The new commit is appended.
Diffstat and shortlog omitted - they did not change except for appended patch.


I have checked that:
1) We pass -m64 to gcc when building vmlinux.lds
2) that a defconfig builds here
3) that we continue to pass -m64 to gcc


	Sam

commit bab6038071f446e2e6d57eb83028b21959276e84
Author: Sam Ravnborg <sam@ravnborg.org>
Date:   Mon Jul 7 22:30:35 2008 +0200

    sparc: add -m64 when building vmlinux.lds
    
    David Miller noticed that the build of vmlinux.lds
    failed to use the -m64 specifier.
    This caused the build to break with a bi-arch gcc with
    unified headers.
    
    Add the -m64 option to CPPFLAGS_vmlinux.lds so we
    have the correct defines available when building
    vmliux.lds.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

diff --git a/arch/sparc64/Makefile b/arch/sparc64/Makefile
index 4b8f2b0..b785a39 100644
--- a/arch/sparc64/Makefile
+++ b/arch/sparc64/Makefile
@@ -9,7 +9,9 @@
 
 CHECKFLAGS	+= -D__sparc__ -D__sparc_v9__ -m64
 
-CPPFLAGS_vmlinux.lds += -Usparc
+# Undefine sparc when processing vmlinux.lds - it is used
+# And teach CPP we are doing 64 bit builds (for this case)
+CPPFLAGS_vmlinux.lds += -m64 -Usparc
 
 LDFLAGS		:= -m elf64_sparc
 
