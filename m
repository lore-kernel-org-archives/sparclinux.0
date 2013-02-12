From: Sam Ravnborg <sam@ravnborg.org>
Date: Tue, 12 Feb 2013 17:35:06 +0000
Subject: Re: linux-next: build failure after merge of the final tree (acpi tree related)
Message-Id: <20130212173505.GA2155@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20130211183409.7519b73ca320baeac5ec886f@canb.auug.org.au> <51197D8B.6010407@kernel.org>
In-Reply-To: <51197D8B.6010407@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Len Brown <lenb@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Len Brown <len.brown@intel.com>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > ---
> >  arch/sparc/include/asm/processor.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/arch/sparc/include/asm/processor.h b/arch/sparc/include/asm/processor.h
> > index 34baa35..622cfa5 100644
> > --- a/arch/sparc/include/asm/processor.h
> > +++ b/arch/sparc/include/asm/processor.h
> > @@ -7,6 +7,8 @@
> >  #endif
> >  
> >  #define nop() 		__asm__ __volatile__ ("nop")
> > +#ifndef __ASSEMBLY__
> >  extern void (*sparc_idle)(void);
> > +#endif
> >  
> >  #endif
> > 
> 
> Thank you Stephen!
> 
> The last time I compiled a sparc kernel was in 1993:-)
> 
> I've added your fix and Dave's Ack to this patch,
> and updated it in my next branch.

Hi Len.

Can you please move the definition of sparc_idle to processor_32.h
It is sparc32 specific - and then we do not need the __ASSEMBLY__ guards
as the sparc32 variant are not used from assembler.

Do you btw. have any hints how I can convert to the cpu_idle thing you hinted?

	Sam
