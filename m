From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 26 Nov 2020 08:29:43 +0000
Subject: Re: [PATCH] fbdev: aty: SPARC64 requires FB_ATY_CT
Message-Id: <CAMuHMdVpcLc9enskSBJobmHXy3GU5ULdt78ArAr522VXRmty5w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20201126003957.19604-1-rdunlap@infradead.org>
In-Reply-To: <20201126003957.19604-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, sparclinux <sparclinux@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

Hi Randy,

On Thu, Nov 26, 2020 at 1:40 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> It looks like SPARC64 requires FB_ATY_CT to build without errors,
> so adjust the Kconfig entry of FB_ATY_CT so that it is always 'y'
> for SPARC64 && PCI by disabling the prompt for SPARC64 && PCI.
>
> As it currently is, FB_ATY_CT can be disabled, resulting in build
> errors:
>
> ERROR: modpost: "aty_postdividers" [drivers/video/fbdev/aty/atyfb.ko] undefined!
> ERROR: modpost: "aty_ld_pll_ct" [drivers/video/fbdev/aty/atyfb.ko] undefined!
>
> Fixes: f7018c213502 ("video: move fbdev to drivers/video/fbdev")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Thanks for your patch!

> --- linux-next-20201124.orig/drivers/video/fbdev/Kconfig
> +++ linux-next-20201124/drivers/video/fbdev/Kconfig
> @@ -1277,7 +1277,7 @@ config FB_ATY
>           module will be called atyfb.
>
>  config FB_ATY_CT
> -       bool "Mach64 CT/VT/GT/LT (incl. 3D RAGE) support"
> +       bool "Mach64 CT/VT/GT/LT (incl. 3D RAGE) support" if !(SPARC64 && PCI)
>         depends on PCI && FB_ATY
>         default y if SPARC64 && PCI
>         help

What about letting FB_ATY select FB_ATY_CT if SPARC64 && PCI, and
dropping the "default y"-line, instead?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
