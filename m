From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 09 Dec 2004 05:24:29 +0000
Subject: Re: mmap breakage
Message-Id: <20041208212429.72329374.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.61.0412032354010.1963@bobcat>
In-Reply-To: <Pine.LNX.4.61.0412032354010.1963@bobcat>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, 7 Dec 2004 10:38:02 -0500 (EST)
Jurij Smakov <jurij@wooyd.org> wrote:

> No, this bug has been triggered during autobuilding of at least two 
> different Debian packages, kmd [0] and fet [1]. kmd is a graphical 
> debugger for ARM boards, and fet is some sort of personal organizer.
> 
> When ldd is run on the binaries late in the building stage to extract
> the information about the dynamic libraries and generate the correct 
> dependencies, it (among other things) invokes the command:
> 
> /lib/ld-linux.so.2 --verify ./a.out
> 
> which fails with SIGILL, if one is unlucky.

I understand, and as others pointed it this problem is due to
the ELF_ET_DYN_BASE setting in the kernel used for 32-bit binaries.

This triggered a memory, and now I sort of recall why I choose
this value.  It had something to do with emacs and how it would
dump itself.

Let's turn on the "way back machine" and look into the vger CVS
logs for the answer, and indeed we end up finding this:

CVSROOT:        /vger/u4/cvs
Module name:    linux
Changes by:     davem@vger.rutgers.edu  98/09/14 05:11:15

Modified files:
        arch/sparc64/kernel: binfmt_elf32.c
        include/asm-sparc: elf.h

Log message:
        Tweak ELF_ET_DYN_BASE so that emacs can be run
        properly with the intepreter as the command line.
        Note, this comment above these defines is wrong I believe.
        The brk of ld.so is what is used for sys_brk calls, not that
        of the later mapped main executable.  The reason emacs would
        barf is that it wants the top 4 bits of malloc obtained
        addresses to be zero so it can store lisp type information
        there.

And this explains the value we are using.

When we run /lib/ld-linux.so.2 from the command line as
the executable, the end of this mapping choosen is where
the BRK area of the program begins.

If the addresses used for the BRK area have any of the top bits
set, this makes emacs explode due to how it encodes type
information in the upper bits of pointers.  So at the time
I was debugging a new build of glibc by doing something like:

/path/to/glibc/build-sparc-linux/ld-linux.so.2 ./emacs

and it wouldn't work, which led to the change above.

Before I researched all of this, I was about to just plainly
set ELF_ET_DYN_BASE back to TASK_UNMAPPED_AREA.  That would
fix the given test case we're discussing, but it would also
break emacs per the discussion above.

The situation is pretty dire.  Our 32-bit address space on
different cpus looks like this:

1) sun4c,sun4

   Two virtual segments, one from 0x0 to 0x20000000 and
   another from 0xe0000000 to 0xf0000000.

   We set TASK_UNMAPPED_BASE to 0xe0000000 for this chip.

2) sun4m/sun4d

   One whole virtual segment from 0x0 to 0xf0000000.

   We set TASK_UNMAPPED_BASE to 0x50000000 for this chip.

3) 32-bit binary running on sparc64

   One whole virtual segment from 0x0 to 0xffffffff.

   We set TASK_UNMAPPED_BASE to 0x70000000 for this chip.

The biggest problematic case is sun4c, we simply don't have
much address space to work with.  Because of emacs wanting
the top 4 bits to be clear, we are basically limited to
some place between 0x0 and 0x10000000.

Let me think about this some more.
