From: Adrian Bunk <bunk@kernel.org>
Date: Fri, 06 Jun 2008 11:05:23 +0000
Subject: Re: [RFC] unify exported sparc header files?
Message-Id: <20080606110523.GA472@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
References: <20080601072044.GA16220@uranus.ravnborg.org>
In-Reply-To: <20080601072044.GA16220@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, Jun 05, 2008 at 11:48:59AM -0700, David Miller wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> Date: Sun, 1 Jun 2008 09:20:45 +0200
> 
> > For all sparc32 specific files:
> >  - nothing
> > 
> > For all the sparc64 specific files:
> >  - copy file to asm-sparc
> >  - wrap the copied file in
> >    #if defined(__sparc_v9__) || defined(CONFIG_SPARC64)
> >       ... file content ...
> >    #endif
> >  - straight include from asm-sparc64 of the asm-sparc file
> > - Or I could just drop the wrapping?
> > 
> > For the non-unified files:
> > - Add content to asm-sparc file and wrap it into:
> >    #if defined(__sparc_v9__) || defined(CONFIG_SPARC64)
> > 	... sparc64 file content
> >    #else
> > 	... sparc32 file content
> >    #endif
> 
> This sounds fine to me.

Sorry that I missed this in the original email.

Can we use the same #if test we use for userspace also in kernelspace?

I'm asking since Sam's proposal would result in more CONFIG_ leakage to 
userspace headers.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

