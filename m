From: William Lee Irwin III <wli@holomorphy.com>
Date: Wed, 11 Aug 2004 16:54:59 +0000
Subject: Re: architectures with their own "config PCMCIA"
Message-Id: <20040811165459.GR11200@holomorphy.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20040807170122.GM17708@fs.tum.de>
In-Reply-To: <20040807170122.GM17708@fs.tum.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Adrian Bunk <bunk@fs.tum.de>
Cc: davem@redhat.com, geert@linux-m68k.org, schwidefsky@de.ibm.com, linux390@de.ibm.com, sparclinux@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org

On Sat, Aug 07, 2004 at 07:01:22PM +0200, Adrian Bunk wrote:
> The following architetures have their own "config PCMCIA" instead of 
> including drivers/pcmcia/Kconfig (in 2.6.8-rc3-mm1):
> - m68k
> - s390
> - sparc
> - sparc64
> Is there any good reason for this, or would a patch to change these 
> architectures to include drivers/pcmcia/Kconfig be OK?

I'd like to switch things over to drivers/Kconfig and/or
drivers/pcmcia/Kconfig. If the drivers are bust I'll just sweep them
when someone complains about the build being bust. One could
proactively find these with make allmodconfig and/or allyesconfig, but
I suspect that may be too large a set of drivers to digest all at once.
Or maybe not -- akpm does scale, after all.


-- wli
