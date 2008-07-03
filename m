From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 03 Jul 2008 13:45:10 +0000
Subject: Re: [GIT PULL] unify sparc header files
Message-Id: <20080703134510.GA29090@uranus.ravnborg.org>
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

Hmmm, I have a crosstool build sparc64 toolchain.
And I did do a defconfig build for each patch applied for both
sparc and spac64. But despite this something is obviously bad.
I will look at it later this week as time permits.

> 
> In file included from include/asm-sparc/page.h:6,
>                  from include/asm/page.h:1,
>                  from arch/sparc64/kernel/vmlinux.lds.S:3:
> include/asm-sparc/page_32.h:24:25: error: asm/btfixup.h: No such file or directory
> 
> When we run vmlinux.lds.S through CPP, it undefines things like
> "sparc" with the '-Usparc -Usparc64' options that get passed in.
> So the ifdef tests in asm-sparc/page.h do not work.
> 
> Is it expected that this will only build with your kbuild bits
> pulled in too?
Nope - it is independent of that.

	Sam
