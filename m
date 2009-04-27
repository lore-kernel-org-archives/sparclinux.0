From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 27 Apr 2009 22:20:51 +0000
Subject: Re: "leds: Add openfirmware platform device support" breaks sparc
Message-Id: <20090427152051.5067e888.akpm@linux-foundation.org>
List-Id: <sparclinux.vger.kernel.org>
References: <20090303160906.9b30b376.akpm@linux-foundation.org>
	<20090303192932.31705cf7@lappy.seanm.ca>
	<20090303.163713.131742043.davem@davemloft.net>
In-Reply-To: <20090303.163713.131742043.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, rpurdie@linux.intel.com, tpiepho@freescale.com, smaclennan@pikatech.com

On Tue, 03 Mar 2009 16:37:13 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: Sean MacLennan <smaclennan@pikatech.com>
> Date: Tue, 3 Mar 2009 19:29:32 -0500
> 
> > It has been..... uhhhh carry the two... longer than I want to admit
> > since I worked on a sparc. Would GPIO based LEDS make sense on a sparc
> > platform? Is sparc used much in the embedded world?
> > 
> > If yes, the of_register_platform_driver is just a nice wrapper. It
> > would be trivial to either change it to work on sparc, or add the
> > wrapper to the sparc includes.
> 
> We generally create the platform devices by hand for LED
> devices on sparc64.
> 
> I'd CONFIG_POWERPC depend this thing for now.

Nobody has done this, so current mainline's sparc64 allmodconfig remains
busted.


This?

--- a/drivers/leds/Kconfig~a
+++ a/drivers/leds/Kconfig
@@ -139,6 +139,7 @@ config LEDS_GPIO_PLATFORM
 config LEDS_GPIO_OF
 	bool "OpenFirmware platform device bindings for GPIO LEDs"
 	depends on LEDS_GPIO && OF_DEVICE
+	depends on POWERPC
 	default y
 	help
 	  Let the leds-gpio driver drive LEDs which have been defined as
_

