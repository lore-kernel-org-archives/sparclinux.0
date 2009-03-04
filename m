From: Sean MacLennan <smaclennan@pikatech.com>
Date: Wed, 04 Mar 2009 00:29:32 +0000
Subject: Re: "leds: Add openfirmware platform device support" breaks sparc
Message-Id: <20090303192932.31705cf7@lappy.seanm.ca>
List-Id: <sparclinux.vger.kernel.org>
References: <20090303160906.9b30b376.akpm@linux-foundation.org>
In-Reply-To: <20090303160906.9b30b376.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org, Trent Piepho <tpiepho@freescale.com>, Richard Purdie <rpurdie@linux.intel.com>

On Tue, 3 Mar 2009 16:09:06 -0800
"Andrew Morton" <akpm@linux-foundation.org> wrote:

> afacit that interface is powerpc-only.

Yes it is. You might want a CONFIG_PPC with that.

It has been..... uhhhh carry the two... longer than I want to admit
since I worked on a sparc. Would GPIO based LEDS make sense on a sparc
platform? Is sparc used much in the embedded world?

If yes, the of_register_platform_driver is just a nice wrapper. It
would be trivial to either change it to work on sparc, or add the
wrapper to the sparc includes.

Cheers,
   Sean
