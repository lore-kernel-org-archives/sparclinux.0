From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Wed, 07 Mar 2012 18:36:33 +0000
Subject: Re: [PATCH 2/3] Kbuild: Implement CONFIG_UIMAGE_KERNEL_NOLOAD
Message-Id: <20120307183633.GB27213@game.jcrosoft.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
 <1331080238-1524-2-git-send-email-swarren@wwwdotorg.org>
 <20120307180815.GA27213@game.jcrosoft.org>
 <4F57AB92.6060907@wwwdotorg.org>
In-Reply-To: <4F57AB92.6060907@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Michal Marek <mmarek@suse.cz>, linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Mike Frysinger <vapier@gentoo.org>, nico@fluxnic.net, linux-sh@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org, sparclinux@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Haavard Skinnemoen <hskinnemoen@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>

On 11:40 Wed 07 Mar     , Stephen Warren wrote:
> On 03/07/2012 11:08 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 17:30 Tue 06 Mar     , Stephen Warren wrote:
> >> This allows the user to use U-Boot's mkimage's -T kernel_noload option
> >> if their arch Kconfig allows it, and they desire.
> >>
> >> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> >> ---
> >> The next patch enables this new CONFIG_ALLOW_ option for ARM. I assume
> >> that some other architectures will also be able to enable it, but I'm
> >> not familiar enough with any to know which.
> > I'm going to repeat. I don't think any impromevent here.
> > 
> > with no specific kernel load address the uImage for is useless/
> 
> No, the whole point of this type of kernel image is that it doesn't need
> a specific load address; the kernel zImage can run from anywhere in RAM
> (provided AUTO_ZRELADDR is enabled, subject to some slight
> restrictions), and hence the uImage doesn't need to be loaded to or
> moved to any particular location.
> 
> The scripts that U-Boot runs determine where the image gets loaded into
> memory.
so instead of spending time on the uImage add simply the support the zImage to
U-Boot as this AUTO_ZRELADDR have 0 advantage compare to the zImage

> 
> > And this no the job of the kernel to build a boot loader specific boot image
> > format.
> 
> Not everyone agrees with this.
so if a new boot loader apear or a new format the kernel will have to support
it. No
> 
> > And the uImage format here is called the legacy format where now U-Boot
> > support a new format based on DT format.
> > 
> > Will you plan to add it too?
> 
> No. The last time I heard anyone talk about that, it sounded like the
> adoption was basically zero, so it seems pointless. Personally, I find
> creating that kind of image more complex, and don't see any benefits in
> that format either.
> 
> > no sorry I don't think it's the right way to go.
> > 
> > On X86 we boot zImage simply. The new uImage option to do not specify the load
> > address add nothing more than just boot a zImage for kernel point of view.
> 
> U-Boot does not currently have the ability to boot zImage on ARM.
so add it and drop the uImage format
> 
> > Further more on server the vendor will use grub mostly (even on ARM) and will
> > expect to boot a zImage.
> 
> But that is irrelevant for the people who are using U-Boot not grub.
execpt the zIamge is the common boot format for all the server and PC and
other boot loader

Best Regards,
J.
