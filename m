From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 17 Jun 2014 15:23:08 +0000
Subject: Re: Build regressions/improvements in v3.16-rc1
Message-Id: <CAMuHMdU2DTt0va67uSKqhhqbVORuY+xEs3uGZ21sKjahE_MSXg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1403018163-25307-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1403018163-25307-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-sh list <linux-sh@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, sparclinux <sparclinux@vger.kernel.org>

On Tue, Jun 17, 2014 at 5:16 PM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> 85 regressions:
>   + /scratch/kisskb/src/arch/mips/net/bpf_jit.c: error: 'BPF_S_ALU_ADD_K' undeclared (first use in this function):  => 930:8
    [....]
>   + /scratch/kisskb/src/arch/mips/net/bpf_jit.c: error: 'BPF_S_STX' undeclared (first use in this function):  => 925:8

mips-allmodconfig (being fixed)

>   + /scratch/kisskb/src/arch/powerpc/kernel/cacheinfo.c: error: 'size_kb' may be used uninitialized in this function [-Werror=uninitialized]:  => 525:2
>   + /scratch/kisskb/src/drivers/tty/serial/nwpserial.c: error: implicit declaration of function 'udelay' [-Werror=implicit-function-declaration]:  => 53:3
>   + error: No rule to make target drivers/scsi/aic7xxx/aicasm/*.[chyl]:  => N/A

powerpc-randconfig

>   + /scratch/kisskb/src/arch/sh/kernel/smp.c: error: implicit declaration of function 'cpu_context' [-Werror=implicit-function-declaration]:  => 368:5
>   + /scratch/kisskb/src/arch/sh/kernel/smp.c: error: lvalue required as left operand of assignment:  => 405:24, 368:24, 448:32
>   + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error: 'cached_to_uncached' undeclared (first use in this function):  => 99:17
>   + /scratch/kisskb/src/arch/sh/mm/cache-sh4.c: error: implicit declaration of function 'cpu_context' [-Werror=implicit-function-declaration]:  => 192:2

sh-randconfig

>   + /scratch/kisskb/src/drivers/of/platform.c: error: 'struct pdev_archdata' has no member named 'dma_mask':  => 170:16

microblaze/mmu_defconfig (being fixed)

>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_add' [-Werror=implicit-function-declaration]:  => 176:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_add_negative' [-Werror=implicit-function-declaration]:  => 211:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_add_return' [-Werror=implicit-function-declaration]:  => 218:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_dec' [-Werror=implicit-function-declaration]:  => 169:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_dec_and_test' [-Werror=implicit-function-declaration]:  => 197:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_dec_return' [-Werror=implicit-function-declaration]:  => 239:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_inc' [-Werror=implicit-function-declaration]:  => 162:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_inc_and_test' [-Werror=implicit-function-declaration]:  => 204:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_inc_return' [-Werror=implicit-function-declaration]:  => 232:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_set' [-Werror=implicit-function-declaration]:  => 155:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_sub' [-Werror=implicit-function-declaration]:  => 183:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_sub_and_test' [-Werror=implicit-function-declaration]:  => 190:2
>   + /scratch/kisskb/src/include/asm-generic/atomic-long.h: error: implicit declaration of function 'atomic_sub_return' [-Werror=implicit-function-declaration]:  => 225:2
>   + /scratch/kisskb/src/include/linux/atomic.h: error: implicit declaration of function '__atomic_add_unless' [-Werror=implicit-function-declaration]:  => 53:2
>   + /scratch/kisskb/src/include/linux/atomic.h: error: implicit declaration of function 'atomic_cmpxchg' [-Werror=implicit-function-declaration]:  => 89:3
>   + /scratch/kisskb/src/include/linux/atomic.h: error: implicit declaration of function 'atomic_read' [-Werror=implicit-function-declaration]:  => 136:2

sparc-allmodconfig

>   + /scratch/kisskb/src/sound/soc/fsl/fsl_dma.c: error: invalid use of undefined type 'struct ccsr_ssi':  => 926:34, 927:34

powerpc/mpc85xx_defconfig

>   + error: filter.c: undefined reference to `__fpscr_values':  => .text+0x3166c), .text+0x32000), .text+0x31860), .text+0x31d8c), .text+0x324b0)

sh4/se7206_defconfig
sh4/rsk7203_defconfig (toolchain issue)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
