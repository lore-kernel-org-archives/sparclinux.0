From: David Miller <davem@davemloft.net>
Date: Thu, 03 Jul 2008 20:15:20 +0000
Subject: Re: [GIT PULL] unify sparc header files
Message-Id: <20080703.131520.23085647.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080628220235.GA3169@uranus.ravnborg.org>
In-Reply-To: <20080628220235.GA3169@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 3 Jul 2008 23:02:07 +0300

> On Thu, Jul 03, 2008 at 01:12:53AM -0700, David Miller wrote:
> > From: David Miller <davem@davemloft.net>
> > Date: Thu, 03 Jul 2008 00:50:52 -0700 (PDT)
> > 
> > In file included from include/asm-sparc/page.h:6,
> >                  from include/asm/page.h:1,
> >                  from arch/sparc64/kernel/vmlinux.lds.S:3:
> > include/asm-sparc/page_32.h:24:25: error: asm/btfixup.h: No such file or directory
> > 
> > When we run vmlinux.lds.S through CPP, it undefines things like
> > "sparc" with the '-Usparc -Usparc64' options that get passed in.
> > So the ifdef tests in asm-sparc/page.h do not work.
> >...
> 
> It also builds for me (gcc 4.3.1) since -Usparc is not -U__sparc__
> (if I add the latter I get your build error).
> 
> Did gcc's behavior change in this area?

Strange, I'll look more closely at this.
