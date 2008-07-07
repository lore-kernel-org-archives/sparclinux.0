From: Sam Ravnborg <sam@ravnborg.org>
Date: Mon, 07 Jul 2008 07:46:00 +0000
Subject: Re: [GIT PULL] unify sparc header files
Message-Id: <20080707074600.GA14300@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080628220235.GA3169@uranus.ravnborg.org>
In-Reply-To: <20080628220235.GA3169@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Sun, Jul 06, 2008 at 06:18:22PM -0700, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 6 Jul 2008 22:06:37 +0200
> 
> > I have now added the appended commit and the full series
> > can be pulled from:
> > 
> >    ssh://master.kernel.org/pub/scm/linux/kernel/git/sam/sparc2.git master
> > 
> > I have tested that sparc64 continue to build and that we indeed
> > add the -m64 option to gcc when we build vmlinux.lds
> > iLet me know if this series is better.
> 
> Something is still messed up, the whole build now complains about
> things like:
> 
> init/initramfs.c: In function 'flush_window':
> init/initramfs.c:433: warning: pointer targets in passing argument 1 of 'flush_buffer' differ in signedness
> init/initramfs.c: In function 'unpack_to_rootfs':
> init/initramfs.c:474: warning: pointer targets in assignment differ in signedness
> 
> So things are still busted with bi-arch compilers.
> 
> It seems that adding "-m64" to the kbuild CPPFLAGS does not propagate
> "-m64" to the kbuild CFLAGS.  So your "fix" changeset idea to remove
> "-m64" from the kbuild CFLAGS does not aparently work.
I actually checked it.
> 
> Please build a bi-arch compiler that defaults to -m32 ;-) Or at least,
> look at the command line with some higher verbosity levels.  You know
> how to do that right? :-)))

I checked that and it is present so we need to look somewhere else.

In top-level Makefile we do:

include arch/sparc64/Makefile

....

# disable pointer signed / unsigned warnings in gcc 4.0
KBUILD_CFLAGS += $(call cc-option,-Wno-pointer-sign,)

When we do the above check we use KBUILD_CFLAGS direct
and does not include KBUILD_CPPFLAGS - thus missing -m64.

So I think that your bi-arch sparc gcc only accepts
-Wno-pointer-sign if -m64 is specified and that this
option is missing with current patchset.
At least that is my best explanation so far.

I will upload a new patchset tonight where I am less smart
in setting -m64.

Note: On my cross compiled 64 bit sparc gcc I do not
      have the -Wno-pointer-sign option so I cannot
      see if -m64 matters or not.

	Sam
