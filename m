From: Nick Desaulniers <ndesaulniers@google.com>
Date: Thu, 12 Mar 2020 01:50:37 +0000
Subject: Re: [PATCH v2 1/2] sparc: revive __HAVE_ARCH_STRLEN for 32bit sparc
Message-Id: <CAKwvOdncHn9deGkP_VoOyk7Yhs6YbEeX=DwrMKX-u8RqoVKkcg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20200311223725.27662-1-masahiroy@kernel.org>
In-Reply-To: <20200311223725.27662-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, sparclinux@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, clang-built-linux <clang-built-linux@googlegroups.com>, Al Viro <viro@zeniv.linux.org.uk>, Ilie Halip <ilie.halip@gmail.com>, Nathan Chancellor <natechancellor@gmail.com>, LKML <linux-kernel@vger.kernel.org>

On Wed, Mar 11, 2020 at 3:37 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> Prior to commit 70a6fcf3283a ("[sparc] unify 32bit and 64bit string.h"),
> __HAVE_ARCH_STRLEN was defined in both of string_32.h and string_64.h
>
> It did not unify __HAVE_ARCH_STRLEN, but deleted it from string_32.h
>
> This issue was reported by the kbuild test robot in the trial of
> forcible linking of $(lib-y) to vmlinux.
>
> Fixes: 70a6fcf3283a ("[sparc] unify 32bit and 64bit string.h")

Nice find with the above commit.  Thanks for the patch.  Without it,
looks like 32b sparc is using strlen from lib/string.c.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> Reported-by: kbuild test robot <lkp@intel.com>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v2:
>   - Insert a new patch to avoid sparc32 build error
>
>  arch/sparc/include/asm/string.h    | 4 ++++
>  arch/sparc/include/asm/string_64.h | 4 ----
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/sparc/include/asm/string.h b/arch/sparc/include/asm/string.h
> index 3d9cd082716b..001a17baf2d5 100644
> --- a/arch/sparc/include/asm/string.h
> +++ b/arch/sparc/include/asm/string.h
> @@ -37,6 +37,10 @@ void *memmove(void *, const void *, __kernel_size_t);
>  #define __HAVE_ARCH_MEMCMP
>  int memcmp(const void *,const void *,__kernel_size_t);
>
> +/* Now the str*() stuff... */
> +#define __HAVE_ARCH_STRLEN
> +__kernel_size_t strlen(const char *);
> +
>  #define __HAVE_ARCH_STRNCMP
>  int strncmp(const char *, const char *, __kernel_size_t);
>
> diff --git a/arch/sparc/include/asm/string_64.h b/arch/sparc/include/asm/string_64.h
> index ee9ba67321bd..d5c563058a5b 100644
> --- a/arch/sparc/include/asm/string_64.h
> +++ b/arch/sparc/include/asm/string_64.h
> @@ -12,8 +12,4 @@
>
>  #include <asm/asi.h>
>
> -/* Now the str*() stuff... */
> -#define __HAVE_ARCH_STRLEN
> -__kernel_size_t strlen(const char *);
> -
>  #endif /* !(__SPARC64_STRING_H__) */
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
