From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 25 Sep 2009 21:26:50 +0000
Subject: Re: [patch 1/1] sparc32: convert to asm-generic/hardirq.h
Message-Id: <20090925212650.GA3513@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <200909181959.n8IJx3qh005792@imap1.linux-foundation.org>
In-Reply-To: <200909181959.n8IJx3qh005792@imap1.linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Fri, Sep 25, 2009 at 02:18:25PM -0700, David Miller wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> Date: Fri, 25 Sep 2009 14:15:38 -0700
> 
> > hm, I tried to fix this but my sparc32 cross-compiler broke.
> > 
> > ARCH=sparc:
> > 
> > scripts/mod/empty.c:1: error: -m64 is not supported by this configuration
> > scripts/mod/empty.c:1: error: -mlong-double-64 not allowed with -m64
> > scripts/mod/empty.c:1: error: -mcmodel= is not supported on 32 bit systems
>  ...
> > How'd that -m64 get in there?
> 
> That's really odd.
> 
> Sam, any idea?

It happens if you try to build sparc with a sparc64 config.

	Sam
