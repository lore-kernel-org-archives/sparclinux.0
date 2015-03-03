From: Kees Cook <keescook@chromium.org>
Date: Tue, 03 Mar 2015 17:56:02 +0000
Subject: Re: [PATCH v2] seccomp: switch to using asm-generic for seccomp.h
Message-Id: <CAGXu5jKs4_c2jcOzTA2tVQThToVfMUO31GF5+6CXtwA+KKj5_Q@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20150302231254.GA4857@www.outflux.net>
 <20150303083002.GA1207@gmail.com>
In-Reply-To: <20150303083002.GA1207@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Mar 3, 2015 at 12:30 AM, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Kees Cook <keescook@chromium.org> wrote:
>
>> Most architectures don't need to do anything special for the strict
>> seccomp syscall entries. Remove the redundant headers and reduce the
>> others.
>
>>  19 files changed, 27 insertions(+), 137 deletions(-)
>
> Lovely cleanup factor.
>
> Just to make sure, are you sure the 32-bit details are identical
> across architectures?

I did "gcc -E -dM" style output comparisons on the architectures I had
compilers for, and the buildbot hasn't complained on any of the others
(though see the bottom of this email).

>
> For example some architectures did this:
>
>> --- a/arch/microblaze/include/asm/seccomp.h
>> +++ /dev/null
>> @@ -1,16 +0,0 @@
>> -#ifndef _ASM_MICROBLAZE_SECCOMP_H
>> -#define _ASM_MICROBLAZE_SECCOMP_H
>> -
>> -#include <linux/unistd.h>
>> -
>> -#define __NR_seccomp_read            __NR_read
>> -#define __NR_seccomp_write           __NR_write
>> -#define __NR_seccomp_exit            __NR_exit
>> -#define __NR_seccomp_sigreturn               __NR_sigreturn
>> -
>> -#define __NR_seccomp_read_32         __NR_read
>> -#define __NR_seccomp_write_32                __NR_write
>> -#define __NR_seccomp_exit_32         __NR_exit
>> -#define __NR_seccomp_sigreturn_32    __NR_sigreturn

The asm-generic uses the same syscall numbers from both 64 and 32,
which matches most architectures, and those are the ones that had
their seccomp.h entirely eliminated.

> others did this:
>
>> diff --git a/arch/x86/include/asm/seccomp_64.h b/arch/x86/include/asm/seccomp_64.h
>> deleted file mode 100644
>> index 84ec1bd161a5..000000000000
>> --- a/arch/x86/include/asm/seccomp_64.h
>> +++ /dev/null
>> @@ -1,17 +0,0 @@
>> -#ifndef _ASM_X86_SECCOMP_64_H
>> -#define _ASM_X86_SECCOMP_64_H
>> -
>> -#include <linux/unistd.h>
>> -#include <asm/ia32_unistd.h>
>> -
>> -#define __NR_seccomp_read __NR_read
>> -#define __NR_seccomp_write __NR_write
>> -#define __NR_seccomp_exit __NR_exit
>> -#define __NR_seccomp_sigreturn __NR_rt_sigreturn
>> -
>> -#define __NR_seccomp_read_32 __NR_ia32_read
>> -#define __NR_seccomp_write_32 __NR_ia32_write
>> -#define __NR_seccomp_exit_32 __NR_ia32_exit
>> -#define __NR_seccomp_sigreturn_32 __NR_ia32_sigreturn
>> -
>> -#endif /* _ASM_X86_SECCOMP_64_H */

Well, this was x86's split config that was consolidated into the file below:

>
> While in yet another case you kept the syscall mappings:
>
>> --- a/arch/x86/include/asm/seccomp.h
>> +++ b/arch/x86/include/asm/seccomp.h
>> @@ -1,5 +1,20 @@
>> +#ifndef _ASM_X86_SECCOMP_H
>> +#define _ASM_X86_SECCOMP_H
>> +
>> +#include <asm/unistd.h>
>> +
>> +#ifdef CONFIG_COMPAT
>> +#include <asm/ia32_unistd.h>
>> +#define __NR_seccomp_read_32         __NR_ia32_read
>> +#define __NR_seccomp_write_32                __NR_ia32_write
>> +#define __NR_seccomp_exit_32         __NR_ia32_exit
>> +#define __NR_seccomp_sigreturn_32    __NR_ia32_sigreturn
>> +#endif
>> +
>>  #ifdef CONFIG_X86_32
>> -# include <asm/seccomp_32.h>
>> -#else
>> -# include <asm/seccomp_64.h>
>> +#define __NR_seccomp_sigreturn               __NR_sigreturn
>>  #endif
>> +
>> +#include <asm-generic/seccomp.h>
>> +
>> +#endif /* _ASM_X86_SECCOMP_H */
>
> It might all be correct, but it's not obvious to me.

The x86 change was the most complex as it removed a seccomp_32. and
seccomp_64.h file and merged into a single asm/seccomp.h to provide
overrides for the _32 #defines.

However, in looking at it now... I see some flip/flopping of
__NR_sigreturn and __NR_rt_sigreturn between some of the
architectures. Let me study that and send a v3. I think there are some
accidental changes on microblaze and powerpc.

-Kees

-- 
Kees Cook
Chrome OS Security
