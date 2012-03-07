From: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Date: Wed, 07 Mar 2012 09:00:17 +0000
Subject: Re: [PATCH 1/3] Kbuild: centralize MKIMAGE and cmd_uimage definitions
Message-Id: <20120307090017.GB17076@samfundet.no>
List-Id: <sparclinux.vger.kernel.org>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Michal Marek <mmarek@suse.cz>, Russell King <linux@arm.linux.org.uk>, nico@fluxnic.net, Haavard Skinnemoen <hskinnemoen@gmail.com>, Mike Frysinger <vapier@gentoo.org>, Michal Simek <monstr@monstr.eu>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org, microblaze-uclinux@itee.uq.edu.au, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org

Around Tue 06 Mar 2012 17:30:36 -0700 or thereabout, Stephen Warren wrote:
> All ARCHs have the same definition of MKIMAGE. Move it to Makefile.lib
> to avoid duplication.
> 
> All ARCHs have similar definitions of cmd_uimage. Place a sufficiently
> parameterized version in Makefile.lib to avoid duplication.
> 
> The centralized cmd_uimage definition will allow the future introduction
> of a centralized Kconfig option to make cmd_uimage use -T kernel_noload
> rather than -T kernel.
> 
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> NOTE: I have not tested this patch in any way at all for architectures
> other than ARM.
> 
>  arch/arm/boot/Makefile          |   23 +++++++++--------------
>  arch/avr32/boot/images/Makefile |    9 +++------

For the AVR32 related changes

Acked-by: Hans-Christian Egtvedt <egtvedt@samfundet.no>

-- 
Best regards, Hans-Christian Egtvedt
