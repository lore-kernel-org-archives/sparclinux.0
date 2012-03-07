From: Stephen Warren <swarren@wwwdotorg.org>
Date: Wed, 07 Mar 2012 18:29:14 +0000
Subject: Re: [PATCH 1/3] Kbuild: centralize MKIMAGE and cmd_uimage definitions
Message-Id: <4F57A8FA.8080208@wwwdotorg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org> <CA+5PVA7PCow=Z7TpPtQYp3ye6uKFSp3XsdH75Pe9BRu9Vyy21g@mail.gmail.com>
In-Reply-To: <CA+5PVA7PCow=Z7TpPtQYp3ye6uKFSp3XsdH75Pe9BRu9Vyy21g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Josh Boyer <jwboyer@gmail.com>
Cc: Michal Marek <mmarek@suse.cz>, linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Mike Frysinger <vapier@gentoo.org>, nico@fluxnic.net, linux-sh@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au, linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, uclinux-dist-devel@blackfin.uclinux.org, sparclinux@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Haavard Skinnemoen <hskinnemoen@gmail.com>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>

On 03/07/2012 07:15 AM, Josh Boyer wrote:
> On Tue, Mar 6, 2012 at 7:30 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> All ARCHs have the same definition of MKIMAGE. Move it to Makefile.lib
>> to avoid duplication.
>>
>> All ARCHs have similar definitions of cmd_uimage. Place a sufficiently
>> parameterized version in Makefile.lib to avoid duplication.
>>
>> The centralized cmd_uimage definition will allow the future introduction
>> of a centralized Kconfig option to make cmd_uimage use -T kernel_noload
>> rather than -T kernel.
...
> Is there a reason you skipped powerpc?

grepping the powerpc makefiles showed no hits on MKIMAGE, mkimage or
cmd_uimage.

Looking a little harder now, this is all inside the shell script
arch/powerpc/boot/wrapper. I'm not really sure quite how to unify that
shell script with the makefile use of mkimage. Do you have any ideas?
