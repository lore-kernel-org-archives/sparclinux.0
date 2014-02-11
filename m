From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 11 Feb 2014 17:35:49 +0000
Subject: Re: Build regressions/improvements in v3.14-rc2
Message-Id: <CAMuHMdWVx3CCgUo0eWNwmghBvwhmmJYjyC0a1XVebO+kfg3DMQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1392140035-31263-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1392140035-31263-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linux-sh list <linux-sh@vger.kernel.org>, sparclinux <sparclinux@vger.kernel.org>

On Tue, Feb 11, 2014 at 6:33 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.14-rc2[1]  to v3.14-rc1[3], the summaries are:
>   - build errors: +3/-2

  + /scratch/kisskb/src/drivers/gpu/drm/drm_gem_cma_helper.c: error:
implicit declaration of function 'dma_alloc_writecombine'
[-Werror=implicit-function-declaration]:  => 91:2
  + /scratch/kisskb/src/drivers/gpu/drm/drm_gem_cma_helper.c: error:
implicit declaration of function 'dma_free_writecombine'
[-Werror=implicit-function-declaration]:  => 176:3

sh4/sh-randconfig

  + error: jump_label.c: undefined reference to
`arch_jump_label_transform':  => .text+0x85dbc)

sparc64/sparc-allmodconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/7167/ (119 out of 119 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/7145/ (119 out of 119 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
