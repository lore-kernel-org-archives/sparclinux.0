From: David Miller <davem@davemloft.net>
Date: Wed, 04 Mar 2009 00:37:13 +0000
Subject: Re: "leds: Add openfirmware platform device support" breaks sparc
Message-Id: <20090303.163713.131742043.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090303160906.9b30b376.akpm@linux-foundation.org>
	<20090303192932.31705cf7@lappy.seanm.ca>
In-Reply-To: <20090303192932.31705cf7@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: smaclennan@pikatech.com
Cc: sparclinux@vger.kernel.org, linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, tpiepho@freescale.com, rpurdie@linux.intel.com

From: Sean MacLennan <smaclennan@pikatech.com>
Date: Tue, 3 Mar 2009 19:29:32 -0500

> It has been..... uhhhh carry the two... longer than I want to admit
> since I worked on a sparc. Would GPIO based LEDS make sense on a sparc
> platform? Is sparc used much in the embedded world?
> 
> If yes, the of_register_platform_driver is just a nice wrapper. It
> would be trivial to either change it to work on sparc, or add the
> wrapper to the sparc includes.

We generally create the platform devices by hand for LED
devices on sparc64.

I'd CONFIG_POWERPC depend this thing for now.
