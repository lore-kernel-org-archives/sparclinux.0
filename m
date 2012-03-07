From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Wed, 07 Mar 2012 21:28:05 +0000
Subject: Re: [PATCH 2/3] Kbuild: Implement CONFIG_UIMAGE_KERNEL_NOLOAD
Message-Id: <20120307212805.GE18787@n2100.arm.linux.org.uk>
List-Id: <sparclinux.vger.kernel.org>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org> <1331080238-1524-2-git-send-email-swarren@wwwdotorg.org> <20120307180815.GA27213@game.jcrosoft.org> <4F57AB92.6060907@wwwdotorg.org> <20120307183633.GB27213@game.jcrosoft.org> <4F57C4C6.2070602@wwwdotorg.org>
In-Reply-To: <4F57C4C6.2070602@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Michal Marek <mmarek@suse.cz>, linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Mike Frysinger <vapier@gentoo.org>, nico@fluxnic.net, linux-sh@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org, sparclinux@vger.kernel.org, Haavard Skinnemoen <hskinnemoen@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>

On Wed, Mar 07, 2012 at 01:27:50PM -0700, Stephen Warren wrote:
> Thinking more about this, I guess the reliance on AUTO_ZRELADDR is wrong
> here; Russell, Nico, is the ARM decompressor fully position-independent
> irrespective of the AUTO_ZRELADDR setting.

The standard decompressor is fully relocatable into any part of the system
which contains sufficient _RAM_ to contain the size of the zImage plus 64k
malloc space (that's including the BSS for the zImage.)

AUTO_ZRELADDR controls how the _decompressed_ kernel is placed, whether
it is placed at a fixed address controlled by the zreladdr-y symbol
in arch/arm/mach-*/Makefile.boot, or whether it is controlled by where
the zImage is placed - iow, (phys address & 0xf8000000) + TEXT_OFFSET.

> That setting just determines
> where the decompressor writes its output, not what address the
> decompressor can run at, right? So, this KERNEL_NOLOAD feature could be
> enabled in all cases on ARM, not only when AUTO_ZRELADDR is enabled.

I'm not entirely sure about that - there's at least the uboot on some
of the ARM devel platforms which relocates things like the ATAG list if
it's loading a uImage at 0x60008000 vs 0x00008000 (and we want it to be
at the 0x60008000 address so it can see 1GB of memory rather than just
256MB via the low mapping.)

So in some cases we do need control over where the uImage (or zImage)
is loaded by the boot loader.

> In other words:
> 
> We already have and need ZRELADDR no matter what, for reasons unrelated
> to U-Boot/uImage.

That's a tad icky... because a !AUTO_ZRELADDR kernel has no need for a
load address provided it ends up in RAM.  So, uboot enforcing a specific
load address more of an inconvenience rather than a problem.

However, for AUTO_ZRELADDR, the zImage does have to be placed in the
same 128M aligned block of RAM which you want the start of it to be
called PHYS_OFFSET.  So in that sense, an AUTO_ZRELADDR kernel is
more critical with its placement than a !AUTO_ZRELADDR kernel.
