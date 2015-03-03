From: Ingo Molnar <mingo@kernel.org>
Date: Tue, 03 Mar 2015 08:30:02 +0000
Subject: Re: [PATCH v2] seccomp: switch to using asm-generic for seccomp.h
Message-Id: <20150303083002.GA1207@gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150302231254.GA4857@www.outflux.net>
In-Reply-To: <20150302231254.GA4857@www.outflux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org


* Kees Cook <keescook@chromium.org> wrote:

> Most architectures don't need to do anything special for the strict
> seccomp syscall entries. Remove the redundant headers and reduce the
> others.

>  19 files changed, 27 insertions(+), 137 deletions(-)

Lovely cleanup factor.

Just to make sure, are you sure the 32-bit details are identical 
across architectures?

For example some architectures did this:

> --- a/arch/microblaze/include/asm/seccomp.h
> +++ /dev/null
> @@ -1,16 +0,0 @@
> -#ifndef _ASM_MICROBLAZE_SECCOMP_H
> -#define _ASM_MICROBLAZE_SECCOMP_H
> -
> -#include <linux/unistd.h>
> -
> -#define __NR_seccomp_read		__NR_read
> -#define __NR_seccomp_write		__NR_write
> -#define __NR_seccomp_exit		__NR_exit
> -#define __NR_seccomp_sigreturn		__NR_sigreturn
> -
> -#define __NR_seccomp_read_32		__NR_read
> -#define __NR_seccomp_write_32		__NR_write
> -#define __NR_seccomp_exit_32		__NR_exit
> -#define __NR_seccomp_sigreturn_32	__NR_sigreturn

others did this:

> diff --git a/arch/x86/include/asm/seccomp_64.h b/arch/x86/include/asm/seccomp_64.h
> deleted file mode 100644
> index 84ec1bd161a5..000000000000
> --- a/arch/x86/include/asm/seccomp_64.h
> +++ /dev/null
> @@ -1,17 +0,0 @@
> -#ifndef _ASM_X86_SECCOMP_64_H
> -#define _ASM_X86_SECCOMP_64_H
> -
> -#include <linux/unistd.h>
> -#include <asm/ia32_unistd.h>
> -
> -#define __NR_seccomp_read __NR_read
> -#define __NR_seccomp_write __NR_write
> -#define __NR_seccomp_exit __NR_exit
> -#define __NR_seccomp_sigreturn __NR_rt_sigreturn
> -
> -#define __NR_seccomp_read_32 __NR_ia32_read
> -#define __NR_seccomp_write_32 __NR_ia32_write
> -#define __NR_seccomp_exit_32 __NR_ia32_exit
> -#define __NR_seccomp_sigreturn_32 __NR_ia32_sigreturn
> -
> -#endif /* _ASM_X86_SECCOMP_64_H */

While in yet another case you kept the syscall mappings:

> --- a/arch/x86/include/asm/seccomp.h
> +++ b/arch/x86/include/asm/seccomp.h
> @@ -1,5 +1,20 @@
> +#ifndef _ASM_X86_SECCOMP_H
> +#define _ASM_X86_SECCOMP_H
> +
> +#include <asm/unistd.h>
> +
> +#ifdef CONFIG_COMPAT
> +#include <asm/ia32_unistd.h>
> +#define __NR_seccomp_read_32		__NR_ia32_read
> +#define __NR_seccomp_write_32		__NR_ia32_write
> +#define __NR_seccomp_exit_32		__NR_ia32_exit
> +#define __NR_seccomp_sigreturn_32	__NR_ia32_sigreturn
> +#endif
> +
>  #ifdef CONFIG_X86_32
> -# include <asm/seccomp_32.h>
> -#else
> -# include <asm/seccomp_64.h>
> +#define __NR_seccomp_sigreturn		__NR_sigreturn
>  #endif
> +
> +#include <asm-generic/seccomp.h>
> +
> +#endif /* _ASM_X86_SECCOMP_H */

It might all be correct, but it's not obvious to me.

Thanks,

	Ingo
