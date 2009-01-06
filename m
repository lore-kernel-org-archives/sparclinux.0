From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 06 Jan 2009 21:06:24 +0000
Subject: Re: [PATCH] sparc: refactor code in fault_32.c
Message-Id: <20090106210624.GB29514@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090106205209.GA24034@uranus.ravnborg.org>
In-Reply-To: <20090106205209.GA24034@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Tue, Jan 06, 2009 at 12:52:49PM -0800, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Tue, 6 Jan 2009 21:52:09 +0100
> 
> > The sparc allmodconfig build broke due to enabling of the
> > branch_tracer that does some very clever things with
> > all if conditions. This caused my gcc 3.4.5 to be so confused that
> > it emitted a warning:
> > 
> > arch/sparc/mm/fault_32.c: In function `do_sparc_fault':
> > arch/sparc/mm/fault_32.c:176: warning: 'fixup' might be used uninitialized in this function
> > 
> > And with -Werror this broke the build.
> > 
> > Refactor code so it:
> > 1) becomes more readable
> > 2) no longer emit a warning with the branch_tracer enabled
> > 
> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> 
> Applied, thanks Sam.

It looks like this was the only one needed to build
sparc32 vmlinux with allmodconfig.
Still building but all sparc specific bits are built.

So outstanding issues now are:

1) How to fix "warning" in unaligned_64.c (get_user() || get_user())
2) Fix build of sparc32 vmlinux with the new stripping patches

I will try to give 2) a shot tomorrow - too late here now.

	Sam
