From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 03 Aug 2020 09:57:51 +0000
Subject: Re: Build regressions/improvements in v5.8
Message-Id: <CAMuHMdW=tzsK=bsQHQmFAUF041XZ8-msfgNZPpKQurxq1dsjGg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200803095048.20102-1-geert@linux-m68k.org>
In-Reply-To: <20200803095048.20102-1-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: sparclinux <sparclinux@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>

On Mon, Aug 3, 2020 at 11:53 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> JFYI, when comparing v5.8[1] to v5.8-rc7[3], the summaries are:
>   - build errors: +2/-3

  + /kisskb/src/arch/powerpc/include/asm/mmu.h: error: unknown type
name 'next_tlbcam_idx':  => 139:22

v5.8/powerpc-gcc4.9/corenet64_smp_defconfig
v5.8/powerpc-gcc4.9/ppc64_book3e_allmodconfig
v5.8/powerpc-gcc4.9/ppc64e_defconfig
v5.8/powerpc-gcc9/ppc64_book3e_allmodconfig
(fix available)

  + /kisskb/src/arch/sparc/include/asm/trap_block.h: error: 'NR_CPUS'
undeclared here (not in a function):  => 54:39

v5.8/sparc64/sparc64-allmodconfig
v5.8/sparc64/sparc64-defconfig

> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bcf876870b95592b52519ed4aafcf9d95999bc9c/ (192 out of 194 configs)
> [3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/92ed301919932f777713b9172e525674157e983d/ (192 out of 194 configs)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
