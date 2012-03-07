From: Julian Calaby <julian.calaby@gmail.com>
Date: Wed, 07 Mar 2012 00:52:03 +0000
Subject: Re: [PATCH 2/3] Kbuild: Implement CONFIG_UIMAGE_KERNEL_NOLOAD
Message-Id: <CAGRGNgWHXrQgVobz+54sFBzj=bTHCKwg+H4_CY5JoGtmETw2yA@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org> <1331080238-1524-2-git-send-email-swarren@wwwdotorg.org>
In-Reply-To: <1331080238-1524-2-git-send-email-swarren@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Michal Marek <mmarek@suse.cz>, Russell King <linux@arm.linux.org.uk>, nico@fluxnic.net, Haavard Skinnemoen <hskinnemoen@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Mike Frysinger <vapier@gentoo.org>, Michal Simek <monstr@monstr.eu>, Paul Mundt <lethal@linux-sh.org>, "David S. Miller" <davem@davemloft.net>, Guan Xuetao <gxt@mprc.pku.edu.cn>, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, linux-arm-kernel@lists.infradead.org, uclinux-dist-devel@blackfin.uclinux.org, microblaze-uclinux@itee.uq.edu.au, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org

Hi Stephen,

On Wed, Mar 7, 2012 at 11:30, Stephen Warren <swarren@wwwdotorg.org> wrote:
> This allows the user to use U-Boot's mkimage's -T kernel_noload option
> if their arch Kconfig allows it, and they desire.
>
> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> ---
> diff --git a/init/Kconfig b/init/Kconfig
> index 6cfd71d..2035562 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -203,6 +203,21 @@ config KERNEL_LZO
>
> =A0endchoice
>
> +config ALLOW_UIMAGE_KERNEL_NOLOAD
> + =A0 =A0 =A0 bool
> +
> +config UIMAGE_KERNEL_NOLOAD
> + =A0 =A0 =A0 bool "Use mkimage's -T kernel_noload instead of -T kernel"
> + =A0 =A0 =A0 depends on ALLOW_UIMAGE_KERNEL_NOLOAD
> + =A0 =A0 =A0 help
> + =A0 =A0 =A0 =A0 uImage files of type "kernel" embed an absolute load an=
d entry point
> + =A0 =A0 =A0 =A0 address. If the uImage is loaded to a different address=
, then the
> + =A0 =A0 =A0 =A0 image must be copied the uImage file to the specified l=
oad address.

You seem to have an excess "the uImage file" in here.

> + =A0 =A0 =A0 =A0 This copy is a waste of time if the uImage is in fact c=
ompletely
> + =A0 =A0 =A0 =A0 relocatable. If your kernel and bootloader support it, =
you can build
> + =A0 =A0 =A0 =A0 a "kernel_noload" uImage rather than a "kernel" uImage,=
 which
> + =A0 =A0 =A0 =A0 prevents any such copying. If unsure say N.
> +
> =A0config DEFAULT_HOSTNAME
> =A0 =A0 =A0 =A0string "Default hostname"
> =A0 =A0 =A0 =A0default "(none)"

Thanks,

--=20
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
.Plan: http://sites.google.com/site/juliancalaby/
