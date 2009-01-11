From: Ingo Molnar <mingo@elte.hu>
Date: Sun, 11 Jan 2009 12:13:15 +0000
Subject: Re: cpumask change causes sparc build bustage
Message-Id: <20090111121315.GE27796@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20090111.003103.39502700.davem@davemloft.net> <20090111205008.db0a410e.sfr@canb.auug.org.au> <20090111.040640.188129980.davem@davemloft.net>
In-Reply-To: <20090111.040640.188129980.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sfr@canb.auug.org.au, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, travis@sgi.com, Rusty Russell <rusty@rustcorp.com.au>


* David Miller <davem@davemloft.net> wrote:

> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Sun, 11 Jan 2009 20:50:08 +1100
> 
> > On Sun, 11 Jan 2009 00:31:03 -0800 (PST) David Miller <davem@davemloft.net> wrote:
> > >
> > > I'm surprised linux-next builds didn't catch this.
> > 
> > So am I.  http://kisskb.ellerman.id.au/kisskb/compiler/5/ shows my latest
> > builds of both linux-next and Linus' tree are OK for defconfig and
> > allnoconfig (allmodconfig fails for a different reason).
> > 
> > What is different about the failing config (compiler)?  Are there other
> > configs it would be sensible to build test?
> 
> Maybe you don't have NUMA enabled in the test build configs.
> I hit it during an allmodconfig.
> 
> Anyways this fixes it, someone please apply:
> 
> sparc64: Fix cpumask related build failure.
> 
> Signed-off-by: David S. Miller <davem@davemloft.net>

applied it to tip/core/urgent and will send it to Linus later today. 
Thanks David!

	Ingo
