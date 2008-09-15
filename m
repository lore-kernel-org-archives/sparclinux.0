From: David Miller <davem@davemloft.net>
Date: Mon, 15 Sep 2008 00:06:12 +0000
Subject: Re: psycho_irq_build: Wacky INO [3c]
Message-Id: <20080914.170612.264770106.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0809101731591.28457@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@ut.ee>
Date: Mon, 15 Sep 2008 00:38:27 +0300 (EEST)

> > Something is wrong with some debugging feature.
> > 
> > Please turn off CONFIG_STACK_DEBUG and let's see if that makes
> > the problem go away.
> 
> Turned of that and two more debugging options (sysrq check and something 
> else) and it started booting up to the same oops that I already 
> reported.

Thanks for the info.  It may be until after kernel summit before
I can look into this.

It may be that if you revert the arch/sparc64/kernel/pci_psycho.c
patch that added the IRQF_SHARED flag to the request_irq() calls,
the system will boot albeit with those warnings in the log.

You could help diagnose this by testing out that theory.

Thanks.
