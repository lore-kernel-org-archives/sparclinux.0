From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 25 Sep 2009 21:45:55 +0000
Subject: Re: [patch 1/1] sparc32: convert to asm-generic/hardirq.h
Message-Id: <20090925214555.GA3529@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200909181959.n8IJx3qh005792@imap1.linux-foundation.org>
In-Reply-To: <200909181959.n8IJx3qh005792@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Sep 25, 2009 at 02:36:23PM -0700, Andrew Morton wrote:
> On Fri, 25 Sep 2009 23:26:50 +0200
> Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > On Fri, Sep 25, 2009 at 02:18:25PM -0700, David Miller wrote:
> > > From: Andrew Morton <akpm@linux-foundation.org>
> > > Date: Fri, 25 Sep 2009 14:15:38 -0700
> > > 
> > > > hm, I tried to fix this but my sparc32 cross-compiler broke.
> > > > 
> > > > ARCH=sparc:
> > > > 
> > > > scripts/mod/empty.c:1: error: -m64 is not supported by this configuration
> > > > scripts/mod/empty.c:1: error: -mlong-double-64 not allowed with -m64
> > > > scripts/mod/empty.c:1: error: -mcmodel= is not supported on 32 bit systems
> > >  ...
> > > > How'd that -m64 get in there?
> > > 
> > > That's really odd.
> > > 
> > > Sam, any idea?
> > 
> > It happens if you try to build sparc with a sparc64 config.
> > 
> 
> setenv ARCH sparc
> make mrproper
> make allmodconfig
> make init/main.o
> 
> scripts/mod/empty.c:1: error: -m64 is not supported by this configuration
> scripts/mod/empty.c:1: error: -mlong-double-64 not allowed with -m64
> scripts/mod/empty.c:1: error: -mcmodel= is not supported on 32 bit systems
> 
> akpm:/usr/src/25> grep SPARC .config 
> CONFIG_SPARC=y
> # CONFIG_SPARC32 is not set
> CONFIG_SPARC64=y
> CONFIG_SPARC64_SMP=y
> CONFIG_SPARC64_PAGE_SIZE_8KB=y
> # CONFIG_SPARC64_PAGE_SIZE_64KB is not set
> CONFIG_SPARC64_PCI=y
> CONFIG_INPUT_SPARCSPKR=m
> CONFIG_SND_SPARC=y
> # Misc Linux/SPARC drivers
> 
> wtf?  How'd sparc64 get set?

One of the open issues after merging sparc and sparc64.
I have never got around to find a proper solution so
we adjust the config based on the ARCH= setting.
So allmodconfig + allyesconfig will always be sparc64.
And allnoconfig will always be sparc.

Davem has rightfully complained about this before.

	Sam
