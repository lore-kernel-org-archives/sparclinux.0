From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 07 Mar 2012 18:10:19 +0000
Subject: Re: [PATCH 2/3] Kbuild: Implement CONFIG_UIMAGE_KERNEL_NOLOAD
Message-Id: <4F57A48B.1060100@wwwdotorg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>	 <1331080238-1524-2-git-send-email-swarren@wwwdotorg.org> <1331103163.2048.33.camel@epip-laptop>
In-Reply-To: <1331103163.2048.33.camel@epip-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gxt@mprc.pku.edu.cn
Cc: Michal Marek <mmarek@suse.cz>, Russell King <linux@arm.linux.org.uk>, nico@fluxnic.net, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Michal Simek <monstr@monstr.eu>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org, microblaze-uclinux@itee.uq.edu.au, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org

On 03/06/2012 11:52 PM, Guan Xuetao wrote:
> On Tue, 2012-03-06 at 17:30 -0700, Stephen Warren wrote:
>> This allows the user to use U-Boot's mkimage's -T kernel_noload option
>> if their arch Kconfig allows it, and they desire.
...
> Hi, Stephen,
> It seems that UIMAGE_ARCH and UIMAGE_LOADADDR can't be modified from
> arch-Makefiles.

Oh dear, you're right. I suck at testing:-( I've fixed this locally.

For reference, Makefile.lib is included after the Makefile in the
relevant source directory, whereas my patch assumed the other way
around. So, rather than setting defaults in Makefile.lib and having
foo/Makefile override them, I should set the non-defaults in
foo/Makefile, and have Makefile.lib provide default values for variables
that aren't already set. Testing indicates this solves the problem!
