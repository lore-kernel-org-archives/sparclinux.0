From: Ingo Molnar <mingo@elte.hu>
Date: Tue, 06 Jan 2009 12:57:04 +0000
Subject: Re: irqnr fallout in gpiolib on sparc32
Message-Id: <20090106125704.GC20407@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105133819.GE6014@elte.hu> <20090105134832.GA14460@uranus.ravnborg.org> <20090105135508.GB4190@elte.hu> <20090105.123734.137888898.davem@davemloft.net>
In-Reply-To: <20090105.123734.137888898.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sam@ravnborg.org, kosaki.motohiro@jp.fujitsu.com, yinghai@kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, tglx@linutronix.de


* David Miller <davem@davemloft.net> wrote:

> From: Ingo Molnar <mingo@elte.hu>
> Date: Mon, 5 Jan 2009 14:55:08 +0100
> 
> > * Sam Ravnborg <sam@ravnborg.org> wrote:
> > 
> > > Dave has mentioned this but we are not working actively on it yet.
> > 
> > would be cool to do it - i think sparc32 is one of the last major 
> > physical architectures to not be on genirq -
> 
> m68k remains to be converted over to genirq as well

yeah - but m68k has been a holdout from pretty much every optional core 
kernel facility that has been introduced in the past 5-10 years. So if 
sparc32 converts to genirq we have a stronger case for saying:

   "Convert, else ..."

[ where the three dots stands for something not nice. ]

Sparc32 on the other hand had a clean IRQ layer long before x86 found its 
desire for a clean genirq layer - so genirq is a nuisance for Sparc32 at 
best and it deserves none of the not nice actions. What i am hoping for is 
that perhaps the Sparc unification changed that equation.

	Ingo
