From: David Miller <davem@davemloft.net>
Date: Tue, 10 Feb 2009 23:25:26 +0000
Subject: Re: [PATCH] fix Quattro HME irq registration on proble failures
Message-Id: <20090210.152526.211569623.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0902080008100.7639@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0902080008100.7639@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Tue, 10 Feb 2009 22:12:09 +0200 (EET)

> > The patch has been tested on Sun E3500 with SBus and PCI single HME 
> > cards and one PCI Quattro HME card in a situation where any PCI card 
> > failed init when the SBus routines tried to init them by mistake.
> 
> Also tested on E450 with PCI HME and PCI Quad HME.
> 
> Dave, any opinions?

I'm just real busy, I'll look over your patch soon.
