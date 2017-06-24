From: Russell King - ARM Linux <linux@armlinux.org.uk>
Date: Sat, 24 Jun 2017 09:14:07 +0000
Subject: Re: [PATCH] pci:  Add and use PCI_GENERIC_SETUP Kconfig entry
Message-Id: <20170624091406.GZ4902@n2100.armlinux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20170623214538.25967-1-palmer@dabbelt.com>
 <20170623220104.GE31455@jhogan-linux.le.imgtec.org>
In-Reply-To: <20170623220104.GE31455@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Jun 23, 2017 at 11:01:04PM +0100, James Hogan wrote:
> On Fri, Jun 23, 2017 at 02:45:38PM -0700, Palmer Dabbelt wrote:
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 4c1a35f15838..86872246951c 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -96,6 +96,7 @@ config ARM
> >  	select PERF_USE_VMALLOC
> >  	select RTC_LIB
> >  	select SYS_SUPPORTS_APM_EMULATION
> > +	select PCI_GENERIC_SETUP
> >  	# Above selects are sorted alphabetically; please add new ones
> >  	# according to that.  Thanks.
> 
> This comment seems to suggest PCI_GENERIC_SETUP should be added a few
> lines up to preserve the alphabetical sorting.

Indeed it should.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
