From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Aug 2020 08:27:32 +0000
Subject: Re: Build regressions/improvements in v5.9-rc2
Message-Id: <CAMuHMdUZgx51cFuJdeKo57pmRX+NB+OBxsCv1sg46=MLxouN7w@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200825081909.2797-1-geert@linux-m68k.org>
In-Reply-To: <20200825081909.2797-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: sparclinux <sparclinux@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, DRI Development <dri-devel@lists.freedesktop.org>

On Tue, Aug 25, 2020 at 10:23 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.9-rc2[1] to v5.9-rc1[3], the summaries are:
>   - build errors: +12/-0

  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:
error: implicit declaration of function 'disable_kernel_vsx'
[-Werror=implicit-function-declaration]:  => 676:2
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:
error: implicit declaration of function 'enable_kernel_vsx'
[-Werror=implicit-function-declaration]:  => 640:2

powerpc-gcc4.9/ppc64_book3e_allmodconfig

  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit:
R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5040),
(.head.text+0x5100)
  + error: arch/sparc/kernel/head_32.o: relocation truncated to fit:
R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text
section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)
  + error: arch/sparc/kernel/process_32.o: relocation truncated to
fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x4), (.fixup+0xc)
  + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit:
R_SPARC_WDISP22 against `.text':  => (.fixup+0x28), (.fixup+0x1c),
(.fixup+0x34), (.fixup+0x10), (.fixup+0x4)

sparc64/sparc-allmodconfig

  + error: modpost: "devm_ioremap"
[drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
  + error: modpost: "devm_ioremap_resource"
[drivers/net/ethernet/xilinx/xilinx_emac.ko] undefined!:  => N/A
  + error: modpost: "devm_of_iomap"
[drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource"
[drivers/iio/adc/adi-axi-adc.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource"
[drivers/ptp/ptp_ines.ko] undefined!:  => N/A
  + error: modpost: "devm_platform_ioremap_resource_byname"
[drivers/net/ethernet/xilinx/ll_temac.ko] undefined!:  => N/A

um-x86_64/um-all{mod,yes}config

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d012a7190fc1fd72ed48911e77ca97ba4521bccd/ (all 192 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/9123e3a74ec7b934a4a099e98af6a61c2f80bbf5/ (all 192 configs)
Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
