From: David Miller <davem@davemloft.net>
Date: Mon, 05 Jan 2009 20:37:34 +0000
Subject: Re: irqnr fallout in gpiolib on sparc32
Message-Id: <20090105.123734.137888898.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090105133819.GE6014@elte.hu>
	<20090105134832.GA14460@uranus.ravnborg.org>
	<20090105135508.GB4190@elte.hu>
In-Reply-To: <20090105135508.GB4190@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@elte.hu
Cc: sam@ravnborg.org, kosaki.motohiro@jp.fujitsu.com, yinghai@kernel.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, tglx@linutronix.de

From: Ingo Molnar <mingo@elte.hu>
Date: Mon, 5 Jan 2009 14:55:08 +0100

> * Sam Ravnborg <sam@ravnborg.org> wrote:
> 
> > Dave has mentioned this but we are not working actively on it yet.
> 
> would be cool to do it - i think sparc32 is one of the last major physical 
> architectures to not be on genirq -

m68k remains to be converted over to genirq as well
