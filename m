From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 13 Jan 2011 12:25:05 +0000
Subject: Re: sparc boot failure due to perf init
Message-Id: <20110113122505.GA27522@merkur.ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1294431832.2016.457.camel@laptop> <1294432055.2016.458.camel@laptop> <20110107203119.GA30408@merkur.ravnborg.org> <20110109.153745.35032992.davem@davemloft.net> <1294916129.19601.88.camel@laptop>
In-Reply-To: <1294916129.19601.88.camel@laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Peter Zijlstra <peterz@infradead.org>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org

> >  }
> >  
> > -arch_initcall(pcr_arch_init);
> > +early_initcall(pcr_arch_init);
> 
> 
> I just realized, doesn't this make bootability depend on link order?
Yes.

> Since both the pmu init and its dependencies are now early_initcall()
> how do we guarantee pcr_arch_init() and cpu_type_probe() are in fact
> called _before_ init_hw_perf_events()?

Today this is achieved by perf_event.o being located last
in the Makefile in arch/sparc/kernel/

It deserves a comment..

	Sam
