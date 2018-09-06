From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 06 Sep 2018 15:28:24 +0000
Subject: Re: [PATCH 1/4] sparc: Move __IGNORE* entries to non uapi header
Message-Id: <CAK8P3a1JCnSPi+D+CozhqL0dS9WwXtONDHp4=Kg5kCHrpdYwrw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1536036087-15260-1-git-send-email-firoz.khan@linaro.org> <1536036087-15260-2-git-send-email-firoz.khan@linaro.org>
In-Reply-To: <1536036087-15260-2-git-send-email-firoz.khan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Firoz Khan <firoz.khan@linaro.org>
Cc: David Miller <davem@davemloft.net>, sparclinux <sparclinux@vger.kernel.org>, gregkh <gregkh@linuxfoundation.org>, Philippe Ombredanne <pombredanne@nexb.com>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, y2038 Mailman List <y2038@lists.linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arch <linux-arch@vger.kernel.org>, Deepa Dinamani <deepa.kernel@gmail.com>, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

On Tue, Sep 4, 2018 at 6:42 AM Firoz Khan <firoz.khan@linaro.org> wrote:

> +++ b/arch/sparc/include/uapi/asm/unistd.h
> @@ -15,12 +15,6 @@
>  #ifndef _UAPI_SPARC_UNISTD_H
>  #define _UAPI_SPARC_UNISTD_H
>
> -#ifndef __32bit_syscall_numbers__
> -#ifndef __arch64__
> -#define __32bit_syscall_numbers__
> -#endif
> -#endif

This is certainly required in the uapi header as of this patch,
without it all the numbers are wrong when you include the
file from user space.

I suppose it can be removed later once the header is replaced
with the two generated versions,

> -/* Bitmask values returned from kern_features system call.  */
> -#define KERN_FEATURE_MIXED_MODE_STACK  0x00000001

I'm fairly sure this also needs to remain in the uapi/asm/unistd.h header
as a start, so that user space can call the sys_kern_features() system
call and interpret its result when only the first patch is applied.

> -#ifdef __32bit_syscall_numbers__
> -/* Sparc 32-bit only has the "setresuid32", "getresuid32" variants,
> - * it never had the plain ones and there is no value to adding those
> - * old versions into the syscall table.
> - */
> -#define __IGNORE_setresuid
> -#define __IGNORE_getresuid
> -#define __IGNORE_setresgid
> -#define __IGNORE_getresgid
> -#endif
> -
> -/* Sparc doesn't have protection keys. */
> -#define __IGNORE_pkey_mprotect
> -#define __IGNORE_pkey_alloc
> -#define __IGNORE_pkey_free
> -

This part is fine.

      Arnd
