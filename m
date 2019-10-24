From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Thu, 24 Oct 2019 14:44:23 +0000
Subject: Re: [PATCH 1/2] asm-generic: Make msi.h a mandatory include/asm header
Message-Id: <CAK7LNAQvZr48zXkyhii6E-wckYfakhh9gVD=DoBOt++TtPFEaw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <cover.1571911976.git.michal.simek@xilinx.com> <a021f232968cfffe3f2d838da47214c6bbdeeedb.1571911976.git.michal.simek@xilinx.com>
In-Reply-To: <a021f232968cfffe3f2d838da47214c6bbdeeedb.1571911976.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michal Simek <michal.simek@xilinx.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Michal Simek <monstr@monstr.eu>, git@xilinx.com, Palmer Dabbelt <palmer@sifive.com>, Christoph Hellwig <hch@infradead.org>, longman@redhat.com, Bjorn Helgaas <helgaas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Jackie Liu <liuyun01@kylinos.cn>, Wesley Terpstra <wesley@sifive.com>, Firoz Khan <firoz.khan@linaro.org>, sparclinux <sparclinux@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, linux-riscv@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, James Hogan <jhogan@kernel.org>, Vineet Gupta <vgupta@synopsys.com>, Greg Kroah-Hartman <gregkh@linuxfoun>

On Thu, Oct 24, 2019 at 7:13 PM Michal Simek <michal.simek@xilinx.com> wrote:
>
> msi.h is generic for all architectures expect of x86 which has own version.

Maybe a typo?  "except"


Anyway, the code looks good to me.

Reviewed-by: Masahiro Yamada <yamada.masahiro@socionext.com>


> Enabling MSI by including msi.h to architecture Kbuild is just additional
> step which doesn't need to be done.
> The patch was created based on request to enable MSI for Microblaze.
>
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Michal Simek <michal.simek@xilinx.com>
> ---
>
> https://lore.kernel.org/linux-riscv/20191008154604.GA7903@infradead.org/
> ---
>  arch/arc/include/asm/Kbuild     | 1 -
>  arch/arm/include/asm/Kbuild     | 1 -
>  arch/arm64/include/asm/Kbuild   | 1 -
>  arch/mips/include/asm/Kbuild    | 1 -
>  arch/powerpc/include/asm/Kbuild | 1 -
>  arch/riscv/include/asm/Kbuild   | 1 -
>  arch/sparc/include/asm/Kbuild   | 1 -
>  include/asm-generic/Kbuild      | 1 +
>  8 files changed, 1 insertion(+), 7 deletions(-)
>
> diff --git a/arch/arc/include/asm/Kbuild b/arch/arc/include/asm/Kbuild
> index 393d4f5e1450..1b505694691e 100644
> --- a/arch/arc/include/asm/Kbuild
> +++ b/arch/arc/include/asm/Kbuild
> @@ -17,7 +17,6 @@ generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
>  generic-y += mmiowb.h
> -generic-y += msi.h
>  generic-y += parport.h
>  generic-y += percpu.h
>  generic-y += preempt.h
> diff --git a/arch/arm/include/asm/Kbuild b/arch/arm/include/asm/Kbuild
> index 68ca86f85eb7..fa579b23b4df 100644
> --- a/arch/arm/include/asm/Kbuild
> +++ b/arch/arm/include/asm/Kbuild
> @@ -12,7 +12,6 @@ generic-y += local.h
>  generic-y += local64.h
>  generic-y += mm-arch-hooks.h
>  generic-y += mmiowb.h
> -generic-y += msi.h
>  generic-y += parport.h
>  generic-y += preempt.h
>  generic-y += seccomp.h
> diff --git a/arch/arm64/include/asm/Kbuild b/arch/arm64/include/asm/Kbuild
> index 98a5405c8558..bd23f87d6c55 100644
> --- a/arch/arm64/include/asm/Kbuild
> +++ b/arch/arm64/include/asm/Kbuild
> @@ -16,7 +16,6 @@ generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
>  generic-y += mmiowb.h
> -generic-y += msi.h
>  generic-y += qrwlock.h
>  generic-y += qspinlock.h
>  generic-y += serial.h
> diff --git a/arch/mips/include/asm/Kbuild b/arch/mips/include/asm/Kbuild
> index c8b595c60910..61b0fc2026e6 100644
> --- a/arch/mips/include/asm/Kbuild
> +++ b/arch/mips/include/asm/Kbuild
> @@ -13,7 +13,6 @@ generic-y += irq_work.h
>  generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
> -generic-y += msi.h
>  generic-y += parport.h
>  generic-y += percpu.h
>  generic-y += preempt.h
> diff --git a/arch/powerpc/include/asm/Kbuild b/arch/powerpc/include/asm/Kbuild
> index 64870c7be4a3..17726f2e46de 100644
> --- a/arch/powerpc/include/asm/Kbuild
> +++ b/arch/powerpc/include/asm/Kbuild
> @@ -10,4 +10,3 @@ generic-y += local64.h
>  generic-y += mcs_spinlock.h
>  generic-y += preempt.h
>  generic-y += vtime.h
> -generic-y += msi.h
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 16970f246860..1efaeddf1e4b 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -22,7 +22,6 @@ generic-y += kvm_para.h
>  generic-y += local.h
>  generic-y += local64.h
>  generic-y += mm-arch-hooks.h
> -generic-y += msi.h
>  generic-y += percpu.h
>  generic-y += preempt.h
>  generic-y += sections.h
> diff --git a/arch/sparc/include/asm/Kbuild b/arch/sparc/include/asm/Kbuild
> index b6212164847b..62de2eb2773d 100644
> --- a/arch/sparc/include/asm/Kbuild
> +++ b/arch/sparc/include/asm/Kbuild
> @@ -18,7 +18,6 @@ generic-y += mcs_spinlock.h
>  generic-y += mm-arch-hooks.h
>  generic-y += mmiowb.h
>  generic-y += module.h
> -generic-y += msi.h
>  generic-y += preempt.h
>  generic-y += serial.h
>  generic-y += trace_clock.h
> diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
> index adff14fcb8e4..ddfee1bd9dc1 100644
> --- a/include/asm-generic/Kbuild
> +++ b/include/asm-generic/Kbuild
> @@ -4,4 +4,5 @@
>  # (This file is not included when SRCARCH=um since UML borrows several
>  # asm headers from the host architecutre.)
>
> +mandatory-y += msi.h
>  mandatory-y += simd.h
> --
> 2.17.1
>


-- 
Best Regards
Masahiro Yamada
