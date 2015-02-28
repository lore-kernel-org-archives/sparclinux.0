From: Kees Cook <keescook@chromium.org>
Date: Sat, 28 Feb 2015 02:01:11 +0000
Subject: Re: [PATCH] seccomp: switch to using asm-generic for seccomp.h
Message-Id: <CAGXu5jLgbzzYQkeLmpgSGu7w7DKKTHpFE=F2_a=ayjkU6atBQQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150228005228.GA23638@www.outflux.net>
 <20150228123656.538301ef@canb.auug.org.au>
In-Reply-To: <20150228123656.538301ef@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Feb 27, 2015 at 5:36 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Kees,
>
> On Fri, 27 Feb 2015 16:52:29 -0800 Kees Cook <keescook@chromium.org> wrote:
>>
>> diff --git a/arch/arm/include/asm/seccomp.h b/arch/arm/include/asm/seccomp.h
>> index 52b156b341f5..66ca6a30bf5c 100644
>> --- a/arch/arm/include/asm/seccomp.h
>> +++ b/arch/arm/include/asm/seccomp.h
>> @@ -1,11 +1 @@
>> -#ifndef _ASM_ARM_SECCOMP_H
>> -#define _ASM_ARM_SECCOMP_H
>> -
>> -#include <linux/unistd.h>
>> -
>> -#define __NR_seccomp_read __NR_read
>> -#define __NR_seccomp_write __NR_write
>> -#define __NR_seccomp_exit __NR_exit
>> -#define __NR_seccomp_sigreturn __NR_rt_sigreturn
>> -
>> -#endif /* _ASM_ARM_SECCOMP_H */
>> +#include <asm-generic/seccomp.h>
>
> I think that these cases (where you replace the file by a stub that
> just include <asm-generic/seccomp.h>) can be replaced by removing the
> file completely and adding
>
> generic-y = seccomp.h
>
> to <ARCH>/include/asm/Kbuild

Ah-ha! I thought total removal was possible, but I lacked the Kbuild
piece. There are a lot of arch/ headers that are just the one line.
Maybe I should send a another patch to clean up those?

-Kees

-- 
Kees Cook
Chrome OS Security
