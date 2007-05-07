From: "Tom \"spot\" Callaway" <tcallawa@redhat.com>
Date: Mon, 07 May 2007 21:23:41 +0000
Subject: Re: XVR-500 support in XVR-2500 driver?
Message-Id: <1178573021.3661.49.camel@localhost.localdomain>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.64.0705072317540.4832@math>
In-Reply-To: <Pine.SOC.4.64.0705072317540.4832@math>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, 2007-05-07 at 14:03 -0700, David Miller wrote:
> From: David Miller <davem@davemloft.net>
> Date: Mon, 07 May 2007 13:54:51 -0700 (PDT)
> 
> > From: Meelis Roos <mroos@linux.ee>
> > Date: Mon, 7 May 2007 23:21:44 +0300 (EEST)
> > 
> > > The newly merged XVR-500 and XVR-2500 drivers both seem to have
> > > PCI_DEVICE(PCI_VENDOR_ID_3DLABS, 0x7a2) (XVR-500) support in pci device 
> > > table. Is this correct?
> > > 
> > > Just curiously reading new drivers,
> > 
> > Thanks for catching this.
> > 
> > Originally I handled both chips in one driver, then I split
> > them up, that's why it was there.  I'll fix that up :)
> 
> Here is that fix I will push to Linus, thanks again.

Dave,

Thanks for these drivers, fills a much requested void!

Do you know if there is a matching xorg driver to go along with the
kernel implementation?

~spot

