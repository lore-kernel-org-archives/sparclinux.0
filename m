From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 27 Dec 2017 19:54:58 +0000
Subject: Re: [PATCH v6 1/8] arch: enable relative relocations for arm64, power, x86, s390 and x86
Message-Id: <CA+55aFyJg=-PfrVV1kw_bqKKd9Uk+q2FS4pqPp-og_DDbhhaFw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-2-ard.biesheuvel@linaro.org>
In-Reply-To: <20171227085033.22389-2-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Dec 27, 2017 at 12:50 AM, Ard Biesheuvel
<ard.biesheuvel@linaro.org> wrote:
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 7da3e5c366a0..49ae5b43fe2b 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -156,7 +156,7 @@ SECTIONS
>                 CON_INITCALL
>                 SECURITY_INITCALL
>                 INIT_RAM_FS
> -               *(.init.rodata.* .init.bss)     /* from the EFI stub */
> +               *(.init.rodata.* .init.bss .init.discard.*)     /* EFI stub */
>         }
>         .exit.data : {
>                 ARM_EXIT_KEEP(EXIT_DATA)

Weren't you supposed to explain this part in the commit message?

It isn't obvious why this is mixed up with the Kconfig changes, and
somebody already asked about it. The commit message only talks about
the Kconfig changes, and then suddenly there's that odd vmlinux.lds.S
change in there...

              Linus
