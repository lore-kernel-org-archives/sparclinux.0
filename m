From: David Miller <davem@davemloft.net>
Date: Sun, 21 Sep 2008 23:33:15 +0000
Subject: Re: [PATCH]: Fix disappearing PCI devices
Message-Id: <20080921.163315.125565921.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Sun, 21 Sep 2008 22:06:58 +0300 (EEST)

> > Anyways, this patch below should fix the bug.  Let me know if it works.
> 
> Unfortunately it does not work. Here is "of_debug=3 debug" dmesg:

Ok, but at least we're one step closer:

> [  136.564462] /pci@a,2000/pci@2/SUNW,qfe@810100,0 reg[0] -> 1d502800000
 ...
> [  136.565875] /pci@a,2000/pci@2/SUNW,qfe@810900,0 reg[0] -> 1d504800000
 ...
> [  136.567282] /pci@a,2000/pci@2/SUNW,qfe@811100,0 reg[0] -> 1d506800000
 ...
> [  136.568687] /pci@a,2000/pci@2/SUNW,qfe@811900,0 reg[0] -> 1d508800000

as the registers have proper values now. :-)

I'll try to figure up why this stuff doesn't get probed still, thanks!
