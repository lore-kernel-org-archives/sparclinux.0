From: Josh Boyer <jwboyer@gmail.com>
Date: Wed, 07 Mar 2012 14:15:59 +0000
Subject: Re: [PATCH 1/3] Kbuild: centralize MKIMAGE and cmd_uimage definitions
Message-Id: <CA+5PVA7PCow=Z7TpPtQYp3ye6uKFSp3XsdH75Pe9BRu9Vyy21g@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Michal Marek <mmarek@suse.cz>, Russell King <linux@arm.linux.org.uk>, nico@fluxnic.net, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Michal Simek <monstr@monstr.eu>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org, microblaze-uclinux@itee.uq.edu.au, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org

On Tue, Mar 6, 2012 at 7:30 PM, Stephen Warren <swarren@wwwdotorg.org> wrot=
e:
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
> =A0arch/arm/boot/Makefile =A0 =A0 =A0 =A0 =A0| =A0 23 +++++++++----------=
----
> =A0arch/avr32/boot/images/Makefile | =A0 =A09 +++------
> =A0arch/blackfin/boot/Makefile =A0 =A0 | =A0 19 ++++++++-----------
> =A0arch/microblaze/boot/Makefile =A0 | =A0 10 +++-------
> =A0arch/sh/boot/Makefile =A0 =A0 =A0 =A0 =A0 | =A0 =A08 ++------
> =A0arch/sparc/boot/Makefile =A0 =A0 =A0 =A0| =A0 =A09 +++------
> =A0arch/unicore32/boot/Makefile =A0 =A0| =A0 12 ++----------
> =A0scripts/Makefile.lib =A0 =A0 =A0 =A0 =A0 =A0| =A0 24 +++++++++++++++++=
+++++++
> =A08 files changed, 54 insertions(+), 60 deletions(-)

Is there a reason you skipped powerpc?

josh
