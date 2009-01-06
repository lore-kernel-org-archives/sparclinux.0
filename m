From: David Miller <davem@davemloft.net>
Date: Tue, 06 Jan 2009 16:29:13 +0000
Subject: Re: irqnr fallout in gpiolib on sparc32
Message-Id: <20090106.082913.97432854.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105135508.GB4190@elte.hu>
	<20090105.123734.137888898.davem@davemloft.net>
	<20090106125704.GC20407@elte.hu>
In-Reply-To: <20090106125704.GC20407@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@elte.hu
Cc: sam@ravnborg.org, kosaki.motohiro@jp.fujitsu.com, yinghai@kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, tglx@linutronix.de

From: Ingo Molnar <mingo@elte.hu>
Date: Tue, 6 Jan 2009 13:57:04 +0100

> Sparc32 on the other hand had a clean IRQ layer long before x86 found its 
> desire for a clean genirq layer - so genirq is a nuisance for Sparc32 at 
> best and it deserves none of the not nice actions. What i am hoping for is 
> that perhaps the Sparc unification changed that equation.

Not really, the unificiation didn't change much in this area.  That
doesn't change the fact that I do intend to genirq'ify sparc32 some
time soon. :-)
