From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 15 Jul 2019 12:14:27 +0000
Subject: Re: [PATCH] kbuild: add --hash-style= and --build-id unconditionally
Message-Id: <CAK7LNARGiW1BCf9-K1oWLWKvVNZU7rzsdeGKTuT-Q2yGApi7+A@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20190713040110.18210-1-yamada.masahiro@socionext.com>
In-Reply-To: <20190713040110.18210-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc: Michal Marek <michal.lkml@markovi.net>, Catalin Marinas <catalin.marinas@arm.com>, X86 ML <x86@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, sparclinux <sparclinux@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>

On Sat, Jul 13, 2019 at 1:01 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> As commit 1e0221374e30 ("mips: vdso: drop unnecessary cc-ldoption")
> explained, these flags are supported by the minimal required version
> of binutils.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---

Applied to linux-kbuild.


>
>  Makefile                          | 6 ++----
>  arch/arm/vdso/Makefile            | 3 +--
>  arch/arm64/kernel/vdso32/Makefile | 4 ++--
>  arch/sparc/vdso/Makefile          | 3 +--
>  arch/x86/entry/vdso/Makefile      | 5 ++---
>  5 files changed, 8 insertions(+), 13 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 2c5d00ba537e..969182105dbd 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -900,10 +900,8 @@ KBUILD_CPPFLAGS +=3D $(ARCH_CPPFLAGS) $(KCPPFLAGS)
>  KBUILD_AFLAGS   +=3D $(ARCH_AFLAGS)   $(KAFLAGS)
>  KBUILD_CFLAGS   +=3D $(ARCH_CFLAGS)   $(KCFLAGS)
>
> -# Use --build-id when available.
> -LDFLAGS_BUILD_ID :=3D $(call ld-option, --build-id)
> -KBUILD_LDFLAGS_MODULE +=3D $(LDFLAGS_BUILD_ID)
> -LDFLAGS_vmlinux +=3D $(LDFLAGS_BUILD_ID)
> +KBUILD_LDFLAGS_MODULE +=3D --build-id
> +LDFLAGS_vmlinux +=3D --build-id
>
>  ifeq ($(CONFIG_STRIP_ASM_SYMS),y)
>  LDFLAGS_vmlinux        +=3D $(call ld-option, -X,)
> diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
> index ca85df247775..87b7769214e0 100644
> --- a/arch/arm/vdso/Makefile
> +++ b/arch/arm/vdso/Makefile
> @@ -13,8 +13,7 @@ ccflags-y +=3D -DDISABLE_BRANCH_PROFILING
>  ldflags-$(CONFIG_CPU_ENDIAN_BE8) :=3D --be8
>  ldflags-y :=3D -Bsymbolic --no-undefined -soname=3Dlinux-vdso.so.1 \
>             -z max-page-size@96 -nostdlib -shared $(ldflags-y) \
> -           $(call ld-option, --hash-style=3Dsysv) \
> -           $(call ld-option, --build-id) \
> +           --hash-style=3Dsysv --build-id \
>             -T
>
>  obj-$(CONFIG_VDSO) +=3D vdso.o
> diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32=
/Makefile
> index 288c14d30b45..60a4c6239712 100644
> --- a/arch/arm64/kernel/vdso32/Makefile
> +++ b/arch/arm64/kernel/vdso32/Makefile
> @@ -96,8 +96,8 @@ VDSO_LDFLAGS :=3D $(VDSO_CPPFLAGS)
>  VDSO_LDFLAGS +=3D -Wl,-Bsymbolic -Wl,--no-undefined -Wl,-soname=3Dlinux-=
vdso.so.1
>  VDSO_LDFLAGS +=3D -Wl,-z,max-page-size@96 -Wl,-z,common-page-size@96
>  VDSO_LDFLAGS +=3D -nostdlib -shared -mfloat-abi=3Dsoft
> -VDSO_LDFLAGS +=3D $(call cc32-ldoption,-Wl$(comma)--hash-style=3Dsysv)
> -VDSO_LDFLAGS +=3D $(call cc32-ldoption,-Wl$(comma)--build-id)
> +VDSO_LDFLAGS +=3D -Wl,--hash-style=3Dsysv
> +VDSO_LDFLAGS +=3D -Wl,--build-id
>  VDSO_LDFLAGS +=3D $(call cc32-ldoption,-fuse-ld=BFd)
>
>
> diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
> index 5a9e4e1f9f81..324a23947585 100644
> --- a/arch/sparc/vdso/Makefile
> +++ b/arch/sparc/vdso/Makefile
> @@ -115,8 +115,7 @@ quiet_cmd_vdso =3D VDSO    $@
>                        -T $(filter %.lds,$^) $(filter %.o,$^) && \
>                 sh $(srctree)/$(src)/checkundef.sh '$(OBJDUMP)' '$@'
>
> -VDSO_LDFLAGS =3D -shared $(call ld-option, --hash-style=3Dboth) \
> -       $(call ld-option, --build-id) -Bsymbolic
> +VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id -Bsymbolic
>  GCOV_PROFILE :=3D n
>
>  #
> diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
> index 39106111be86..4c234a18638a 100644
> --- a/arch/x86/entry/vdso/Makefile
> +++ b/arch/x86/entry/vdso/Makefile
> @@ -179,9 +179,8 @@ quiet_cmd_vdso =3D VDSO    $@
>                        -T $(filter %.lds,$^) $(filter %.o,$^) && \
>                  sh $(srctree)/$(src)/checkundef.sh '$(NM)' '$@'
>
> -VDSO_LDFLAGS =3D -shared $(call ld-option, --hash-style=3Dboth) \
> -       $(call ld-option, --build-id) $(call ld-option, --eh-frame-hdr) \
> -       -Bsymbolic
> +VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id \
> +       $(call ld-option, --eh-frame-hdr) -Bsymbolic
>  GCOV_PROFILE :=3D n
>
>  #
> --
> 2.17.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



--=20
Best Regards
Masahiro Yamada
