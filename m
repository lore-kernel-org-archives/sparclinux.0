From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 04 Jul 2008 21:10:20 +0000
Subject: Re: [GIT PULL] unify sparc header files
Message-Id: <20080704211020.GA19412@uranus.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20080628220235.GA3169@uranus.ravnborg.org>
In-Reply-To: <20080628220235.GA3169@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jul 03, 2008 at 01:12:53AM -0700, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Thu, 03 Jul 2008 00:50:52 -0700 (PDT)
> 
> > From: Sam Ravnborg <sam@ravnborg.org>
> > Date: Sun, 29 Jun 2008 00:02:35 +0200
> > 
> > > The patches can be pulled here:
> > > 
> > >    ssh://master.kernel.org/pub/scm/linux/kernel/git/sam/sparc.git master
> > > 
> > > Note that the commit: 878e7a6e498bec55f10a163197c41554fb078416
> > > ("sparc: remove CONFIG_SUN4") is not included.
> > > I did not include it as this was independent of my work
> > > and I did not like to Sign-off something I really had not looked at.
> > > So please apply this commit by other means.
> > 
> > Ok, I've pulled all of this into my sparc-next-2.6 tree.
> 
> Unfortunately, this explodes.  I wonder what your build
> environment was when testing this with on sparc64, because
> I can't see how this could possibly work.
> 
> In file included from include/asm-sparc/page.h:6,
>                  from include/asm/page.h:1,
>                  from arch/sparc64/kernel/vmlinux.lds.S:3:
> include/asm-sparc/page_32.h:24:25: error: asm/btfixup.h: No such file or directory
> 

Trying to analyse the above a bit more.

vmlinux.lds.S:3
#include <asm/page.h>

include/asm/page.h:1
#include <asm-sparc/page.h>

include/asm-sparc/page.h:6
#include <asm-sparc/page_32.h>

So this looks correct except that we include the wrong header file.
So the test:
#if defined(__sparc__) && defined(__arch64__)

is the bad one.

Can you try to check the output of:
touch foo.h; gcc -dM foo.h

It should produce a list of all defines used by the preprocessor.
I will expect that __arch64__ is in between as this is the bug I presume.

If __arch64__ is not defined do you then have any good idea how to do this
check without involving any CONFIG_ options as this shall work reliable also
in user space.

We can fix the -Usparc64 for the vmlinux.lds file if the right check is:
#if defined(__sparc__) && defined(sparc64)

Another suspisicion I have is that you use a self-build gcc that supports
both 32 and 64 bit and that gcc fails to define __arch64__ in the
sparc64 case despite being passed '-m64'.
But this is just a suspision and I have noting to back it up.

	Sam
