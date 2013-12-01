From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 01 Dec 2013 09:50:16 +0000
Subject: Re: Build regressions/improvements in v3.13-rc2
Message-Id: <CAMuHMdV1hoUnYixPghCAy-LuTaB9JU-BFfBPH06gxhLRAqfp8Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1385891092-13266-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1385891092-13266-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: sparclinux <sparclinux@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>

On Sun, Dec 1, 2013 at 10:44 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v3.13-rc2[1] to v3.13-rc1[3], the summaries are:
>   - build errors: +8/-8
>   - build warnings: +147/-97

  + /scratch/kisskb/src/drivers/crypto/caam/jr.c: error: implicit
declaration of function 'of_iomap'
[-Werror=implicit-function-declaration]:  => 468:2

powerpc/mpc85xx_defconfig

  + /scratch/kisskb/src/arch/powerpc/kernel/swsusp_booke.S: Error:
invalid sprg number:  => 161, 85, 165, 91, 167, 163, 87, 89

powerpc-randconfig

  + /scratch/kisskb/src/drivers/tty/ehv_bytechan.c: error: type
defaults to 'int' in declaration of 'console_initcall'
[-Werror=implicit-int]:  => 363:1

powerpc-allmodconfig

  + /scratch/kisskb/src/arch/sparc/kernel/kgdb_64.c: error: implicit
declaration of function 'exception_enter'
[-Werror=implicit-function-declaration]:  => 162:7
  + /scratch/kisskb/src/arch/sparc/kernel/kgdb_64.c: error: implicit
declaration of function 'exception_exit'
[-Werror=implicit-function-declaration]:  => 176:2

sparc64-allmodconfig

  + error: drivers/built-in.o: undefined reference to
`i2c_register_driver':  => .init.literal+0xd88)
  + error: sram.c: undefined reference to `devm_regmap_init_i2c':  =>
.text+0x590dc)

sparc-allmodconfig
xtensa-allmodconfig

  + /scratch/kisskb/src/drivers/gpu/drm/drm_gem_cma_helper.c: error:
implicit declaration of function 'dma_alloc_writecombine'
[-Werror=implicit-function-declaration]:  => 91:2
  + /scratch/kisskb/src/drivers/gpu/drm/drm_gem_cma_helper.c: error:
implicit declaration of function 'dma_free_writecombine'
[-Werror=implicit-function-declaration]:  => 176:3

sh-randconfig

> [1] http://kisskb.ellerman.id.au/kisskb/head/6939/ (119 out of 120 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/head/6919/ (119 out of 120 configs)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
