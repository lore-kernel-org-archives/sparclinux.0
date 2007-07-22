From: David Miller <davem@davemloft.net>
Date: Sun, 22 Jul 2007 06:39:49 +0000
Subject: Re: [RFC] Kconfig fun with sparc32/sparc64 rtc drivers
Message-Id: <20070721.233949.35357470.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20070721.232207.26531557.davem@davemloft.net>
	<20070722063149.GQ21668@ftp.linux.org.uk>
	<20070722063511.GR21668@ftp.linux.org.uk>
In-Reply-To: <20070722063511.GR21668@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: viro@ftp.linux.org.uk
Cc: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, sam@ravnborg.org

From: Al Viro <viro@ftp.linux.org.uk>
Date: Sun, 22 Jul 2007 07:35:11 +0100

> > Crude and simple way would be to add
> > 
> > config JS_RTC
> > 	tristate "JavaStation RTC"
> > 	depends on SPARC32 && PCI
> > 	<copy help from RTC with s/will be called rtc/will be called js-rtc>
> > 
> > in drivers/char/Kconfig, slap plain and simple !SPARC in RTC dependencies
> > and put
> > js-rtc-y = rtc.o
> > obj-$(JS_RTC) += js-rtc.o
> > in drivers/char/Makefile
> > 
> > Objections?
> 
> Oh, and s/CONFIG_RTC/CONFIG_JS_RTC/ in arch/sparc/defconfig, of course.

No objections.
