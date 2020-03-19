From: Masahiro Yamada <masahiroy@kernel.org>
Date: Thu, 19 Mar 2020 07:20:17 +0000
Subject: Re: [PATCH v2 1/2] sparc,x86: vdso: remove meaningless undefining CONFIG_OPTIMIZE_INLINING
Message-Id: <CAK7LNARHBfp=gkVO9q3pC9o_w9PgNW=5AP95s1MR1tHLJV=0fg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200220110807.32534-1-masahiroy@kernel.org>
In-Reply-To: <20200220110807.32534-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, X86 ML <x86@kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>, sparclinux <sparclinux@vger.kernel.org>, Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, "David S. Miller" <davem@davemloft.net>, "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi Andrew,

Ping.
Could you pick up this series?


Thanks.


On Thu, Feb 20, 2020 at 8:08 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> The code, #undef CONFIG_OPTIMIZE_INLINING, is not working as expected
> because <linux/compiler_types.h> is parsed before vclock_gettime.c
> since 28128c61e08e ("kconfig.h: Include compiler types to avoid missed
> struct attributes").
>
> Since then, <linux/compiler_types.h> is included really early by
> using the '-include' option. So, you cannot negate the decision of
> <linux/compiler_types.h> in this way.
>
> You can confirm it by checking the pre-processed code, like this:
>
>   $ make arch/x86/entry/vdso/vdso32/vclock_gettime.i
>
> There is no difference with/without CONFIG_CC_OPTIMIZE_FOR_SIZE.
>
> It is about two years since 28128c61e08e. Nobody has reported a
> problem (or, nobody has even noticed the fact that this code is not
> working).
>
> It is ugly and unreliable to attempt to undefine a CONFIG option from
> C files, and anyway the inlining heuristic is up to the compiler.
>
> Just remove the broken code.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> ---
>
> Changes in v2:
>   - fix a type
>   - add Acked-by
>
>  arch/sparc/vdso/vdso32/vclock_gettime.c     | 4 ----
>  arch/x86/entry/vdso/vdso32/vclock_gettime.c | 4 ----
>  2 files changed, 8 deletions(-)
>
> diff --git a/arch/sparc/vdso/vdso32/vclock_gettime.c b/arch/sparc/vdso/vdso32/vclock_gettime.c
> index 026abb3b826c..d7f99e6745ea 100644
> --- a/arch/sparc/vdso/vdso32/vclock_gettime.c
> +++ b/arch/sparc/vdso/vdso32/vclock_gettime.c
> @@ -4,10 +4,6 @@
>
>  #define        BUILD_VDSO32
>
> -#ifndef        CONFIG_CC_OPTIMIZE_FOR_SIZE
> -#undef CONFIG_OPTIMIZE_INLINING
> -#endif
> -
>  #ifdef CONFIG_SPARC64
>
>  /*
> diff --git a/arch/x86/entry/vdso/vdso32/vclock_gettime.c b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
> index 9242b28418d5..3c26488db94d 100644
> --- a/arch/x86/entry/vdso/vdso32/vclock_gettime.c
> +++ b/arch/x86/entry/vdso/vdso32/vclock_gettime.c
> @@ -1,10 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #define BUILD_VDSO32
>
> -#ifndef CONFIG_CC_OPTIMIZE_FOR_SIZE
> -#undef CONFIG_OPTIMIZE_INLINING
> -#endif
> -
>  #ifdef CONFIG_X86_64
>
>  /*
> --
> 2.17.1
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20200220110807.32534-1-masahiroy%40kernel.org.



-- 
Best Regards
Masahiro Yamada
