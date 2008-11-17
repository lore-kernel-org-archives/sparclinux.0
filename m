From: David Miller <davem@davemloft.net>
Date: Mon, 17 Nov 2008 04:02:46 +0000
Subject: Re: [PATCH] sparc,sparc64: unify Kconfig
Message-Id: <20081116.200246.158974855.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1226825821-10125-1-git-send-email-sam@ravnborg.org>
In-Reply-To: <1226825821-10125-1-git-send-email-sam@ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Josip Rodin <joy@entuzijast.net>
Date: Sun, 16 Nov 2008 23:25:57 +0100

> On Sun, Nov 16, 2008 at 09:56:57AM +0100, Sam Ravnborg wrote:
> > --- a/arch/sparc/Kconfig
> > +++ b/arch/sparc/Kconfig
> >  
> >  config NR_CPUS
> > -	int "Maximum number of CPUs (2-32)"
> > -	range 2 32
> > +	int "Maximum number of CPUs"
> > +	range 2 32 if SPARC32
> > +	range 2 1024 if SPARC64
> >  	depends on SMP
> > -	default "32"
> > +	default "2" if SPARC32
> > +	default "64" if SPARC64
> 
> Did you really intend to decrease the sparc32 default to 2 during the merge?
> Just wondering...

I undid this change when applying Sam's patch.
