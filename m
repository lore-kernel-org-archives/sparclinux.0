From: Daniel Vetter <daniel@ffwll.ch>
Date: Fri, 27 Nov 2020 15:14:37 +0000
Subject: Re: [PATCH v2] fbdev: aty: SPARC64 requires FB_ATY_CT
Message-Id: <20201127151437.GH401619@phenom.ffwll.local>
List-Id: <sparclinux.vger.kernel.org>
References: <20201127031752.10371-1-rdunlap@infradead.org>
 <CAMuHMdWup4D9A-giF9xDEhva8PPH4Yhg2NHYx3+0q_=Uoi+iRA@mail.gmail.com>
In-Reply-To: <CAMuHMdWup4D9A-giF9xDEhva8PPH4Yhg2NHYx3+0q_=Uoi+iRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Randy Dunlap <rdunlap@infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>, Tomi Valkeinen <tomi.valkeinen@ti.com>, sparclinux <sparclinux@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

On Fri, Nov 27, 2020 at 10:15:49AM +0100, Geert Uytterhoeven wrote:
> On Fri, Nov 27, 2020 at 4:18 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> > It looks like SPARC64 requires FB_ATY_CT to build without errors,
> > so have FB_ATY select FB_ATY_CT if both SPARC64 and PCI are enabled
> > instead of using "default y if SPARC64 && PCI", which is not strong
> > enough to prevent build errors.
> >
> > As it currently is, FB_ATY_CT can be disabled, resulting in build
> > errors:
> >
> > ERROR: modpost: "aty_postdividers" [drivers/video/fbdev/aty/atyfb.ko] undefined!
> > ERROR: modpost: "aty_ld_pll_ct" [drivers/video/fbdev/aty/atyfb.ko] undefined!
> >
> > Fixes: f7018c213502 ("video: move fbdev to drivers/video/fbdev")
> > Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied to drm-misc-next, thanks for the patch&review.
-Daniel

> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
