From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Date: Wed, 28 Jun 2017 17:03:04 +0000
Subject: Re: Access to older 64-bit sparcs for developers
Message-Id: <b889d378-ebc3-1fd6-6fff-b86e25a9797e@physik.fu-berlin.de>
List-Id: <sparclinux.vger.kernel.org>
References: <alpine.LRH.2.20.1706271559250.28262@math.ut.ee>
In-Reply-To: <alpine.LRH.2.20.1706271559250.28262@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On 06/28/2017 06:32 PM, chase rayfield wrote:
> Testing on old hardware is important... because there are differences
> and stuff breaks. I still haven't figured out how to get an X server
> going on my Ultra45 for instance... perhaps fbdev but that is
> decidedly bleh. It's happily running Gentoo and my Homepage etc in the
> meantime...

There is currently no native display driver for these old framebuffers
as far as I know but I am happy to be corrected.

> I can provide access to just about any 32bit hardware except
> TurboSparc (working on that ;-) ), an Ultra 1E, 10, U45 and T2000, for
> anyone wanting to dork around with that as well.... on a 100/10 link.

UltraSparcs are 64 bits, not 32 bits. 32 bit SPARC is currently out of
scope as most people focus on UltraSparcs. No idea what the current
state of affairs is though. Have you tried a recent kernel on the
TurboSparc?

> I don't have a fancy setup to power cycle them at the moment though I
> can easily wire up serial consoles. I could stick a Radeon RX560 in
> the U45 if someone wants to try getting mesa + X11 acceleration
> working on Sparc64 on that specific hardware at least.

Having access to a serial console is always essential as networking
might not always work. Having remote power cycle control is even
better, although the T2000 does that through ALOM.

Adrian

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
