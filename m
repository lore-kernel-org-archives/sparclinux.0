From: Al Viro <viro@ftp.linux.org.uk>
Date: Sun, 22 Jul 2007 06:35:11 +0000
Subject: Re: [RFC] Kconfig fun with sparc32/sparc64 rtc drivers
Message-Id: <20070722063511.GR21668@ftp.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <20070722054356.GO21668@ftp.linux.org.uk> <20070721.225413.23605608.davem@davemloft.net> <20070722061924.GP21668@ftp.linux.org.uk> <20070721.232207.26531557.davem@davemloft.net> <20070722063149.GQ21668@ftp.linux.org.uk>
In-Reply-To: <20070722063149.GQ21668@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, sam@ravnborg.org

On Sun, Jul 22, 2007 at 07:31:49AM +0100, Al Viro wrote:
> On Sat, Jul 21, 2007 at 11:22:07PM -0700, David Miller wrote:
> > From: Al Viro <viro@ftp.linux.org.uk>
> > Date: Sun, 22 Jul 2007 07:19:24 +0100
> > 
> > > We probably ought to make drivers/sbus/char/rtc.c sparc32-only,
> > > then - AFAICS it simply won't be able to register misc device and that
> > > will be it.  ACK?
> > 
> > ACK.
> > 
> > > > 2) all the __sparc_v9__ crap is removed from drivers/char/rtc.c
> > > > 3) all the __sparc__ crap is changed to CONFIG_SPARC32 in same
> > > > 4) CONFIG_RTC is not longer allows on sparc64, only sparc32 with PCI
> > > 
> > > Umm...  OK, that takes care of sparc64 side of things, which is probably
> > > all we realistically care about.  Except that it still leaves broken sparc32
> > > defconfig - we have RTC=m, SUN_MOSTEK_RTC=m and kbuild won't deal with it...
> > 
> > That definitely needs to be fixed and I'm willing to entertain
> > any suggestion on how to deal with it.
> 
> Crude and simple way would be to add
> 
> config JS_RTC
> 	tristate "JavaStation RTC"
> 	depends on SPARC32 && PCI
> 	<copy help from RTC with s/will be called rtc/will be called js-rtc>
> 
> in drivers/char/Kconfig, slap plain and simple !SPARC in RTC dependencies
> and put
> js-rtc-y = rtc.o
> obj-$(JS_RTC) += js-rtc.o
> in drivers/char/Makefile
> 
> Objections?

Oh, and s/CONFIG_RTC/CONFIG_JS_RTC/ in arch/sparc/defconfig, of course.
