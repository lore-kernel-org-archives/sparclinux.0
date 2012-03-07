From: Nicolas Pitre <nico@fluxnic.net>
Date: Wed, 07 Mar 2012 21:03:04 +0000
Subject: Re: [PATCH 2/3] Kbuild: Implement CONFIG_UIMAGE_KERNEL_NOLOAD
Message-Id: <alpine.LFD.2.02.1203071537130.24151@xanadu.home>
List-Id: <sparclinux.vger.kernel.org>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
 <1331080238-1524-2-git-send-email-swarren@wwwdotorg.org>
 <20120307180815.GA27213@game.jcrosoft.org> <4F57AB92.6060907@wwwdotorg.org>
 <20120307183633.GB27213@game.jcrosoft.org> <4F57C4C6.2070602@wwwdotorg.org>
In-Reply-To: <4F57C4C6.2070602@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>, Michal Marek <mmarek@suse.cz>, linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Mike Frysinger <vapier@gentoo.org>, linux-sh@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org, sparclinux@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Haavard Skinnemoen <hskinnemoen@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>

On Wed, 7 Mar 2012, Stephen Warren wrote:

> On 03/07/2012 11:36 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 11:40 Wed 07 Mar     , Stephen Warren wrote:
> >> On 03/07/2012 11:08 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >>> On 17:30 Tue 06 Mar     , Stephen Warren wrote:
> >>>> This allows the user to use U-Boot's mkimage's -T kernel_noload option
> >>>> if their arch Kconfig allows it, and they desire.
> >>>>
> >>>> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> >>>> ---
> >>>> The next patch enables this new CONFIG_ALLOW_ option for ARM. I assume
> >>>> that some other architectures will also be able to enable it, but I'm
> >>>> not familiar enough with any to know which.
> >>> I'm going to repeat. I don't think any impromevent here.
> >>>
> >>> with no specific kernel load address the uImage for is useless/
> >>
> >> No, the whole point of this type of kernel image is that it doesn't need
> >> a specific load address; the kernel zImage can run from anywhere in RAM
> >> (provided AUTO_ZRELADDR is enabled, subject to some slight
> >> restrictions), and hence the uImage doesn't need to be loaded to or
> >> moved to any particular location.
> >>
> >> The scripts that U-Boot runs determine where the image gets loaded into
> >> memory.
> >
> > so instead of spending time on the uImage add simply the support the zImage to
> > U-Boot as this AUTO_ZRELADDR have 0 advantage compare to the zImage
> 
> Thinking more about this, I guess the reliance on AUTO_ZRELADDR is wrong
> here; Russell, Nico, is the ARM decompressor fully position-independent
> irrespective of the AUTO_ZRELADDR setting.

Absolutely.

> That setting just determines where the decompressor writes its output, 
> not what address the decompressor can run at, right?

Right.

> So, this KERNEL_NOLOAD feature could be
> enabled in all cases on ARM, not only when AUTO_ZRELADDR is enabled.

Except when CONFIG_ZBOOT_ROM is selected (if the uImage format 
allows it), or when the u-Boot environment doesn't know where to load 
the uImage.

FWIW, I really hate this confusing usage of "noload" imposed on us by
we know who.  I thought better than contesting his definition though.

But yes, AUTO_ZRELADDR has no effect on the location where the zImage 
should be _loaded_, except for the 128MB restriction.

> As such to address Jean-Christophe's most recent comment above, this
> patch isn't about adding support for AUTO_ZRELADDR, but for U-Boot's
> kernel_noload feature, so comparisons should be drawn between
> kernel_noload uImages and zImage, not between AUTO_ZRELADDR and zImage.
> 
> In other words:
> 
> We already have and need ZRELADDR no matter what, for reasons unrelated
> to U-Boot/uImage.

Well, I do have a patch series getting rid of ZRELADDR entirely, and 
AUTO_ZRELADDR would then become implicit, unless CONFIG_PHYS_OFFSET is 
defined.


Nicolas
