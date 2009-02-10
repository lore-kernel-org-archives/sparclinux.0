From: Meelis Roos <mroos@linux.ee>
Date: Tue, 10 Feb 2009 20:12:09 +0000
Subject: Re: [PATCH] fix Quattro HME irq registration on proble failures
Message-Id: <Pine.SOC.4.64.0902102211090.10340@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0902080008100.7639@math.ut.ee>
In-Reply-To: <Pine.SOC.4.64.0902080008100.7639@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

> The patch has been tested on Sun E3500 with SBus and PCI single HME 
> cards and one PCI Quattro HME card in a situation where any PCI card 
> failed init when the SBus routines tried to init them by mistake.

Also tested on E450 with PCI HME and PCI Quad HME.

Dave, any opinions?

-- 
Meelis Roos (mroos@linux.ee)
