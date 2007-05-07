From: David Miller <davem@davemloft.net>
Date: Mon, 07 May 2007 20:54:51 +0000
Subject: Re: XVR-500 support in XVR-2500 driver?
Message-Id: <20070507.135451.28787802.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705072317540.4832@math>
In-Reply-To: <Pine.SOC.4.64.0705072317540.4832@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 7 May 2007 23:21:44 +0300 (EEST)

> The newly merged XVR-500 and XVR-2500 drivers both seem to have
> PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x7a2) (XVR-500) support in pci device 
> table. Is this correct?
> 
> Just curiously reading new drivers,

Thanks for catching this.

Originally I handled both chips in one driver, then I split
them up, that's why it was there.  I'll fix that up :)
