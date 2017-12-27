From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Wed, 27 Dec 2017 20:11:19 +0000
Subject: Re: [PATCH v6 2/8] module: use relative references for __ksymtab entries
Message-Id: <CAKv+Gu-2NUzsakN2rcM_5fqD0ubr+6ZXSc+5sjZZPbU3wj_Xsg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20171227085033.22389-1-ard.biesheuvel@linaro.org>
 <20171227085033.22389-3-ard.biesheuvel@linaro.org>
 <CA+55aFxqJqJq_7VUzBVTppgXFPc-8Ou55iLsZjp3fr6B2gRyTQ@mail.gmail.com>
In-Reply-To: <CA+55aFxqJqJq_7VUzBVTppgXFPc-8Ou55iLsZjp3fr6B2gRyTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 27 December 2017 at 20:07, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Dec 27, 2017 at 12:50 AM, Ard Biesheuvel
> <ard.biesheuvel@linaro.org> wrote:
>> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
>> index 52e611ab9a6c..fe752d365334 100644
>> --- a/include/linux/compiler.h
>> +++ b/include/linux/compiler.h
>> @@ -327,4 +327,15 @@ static __always_inline void __write_once_size(volatile void *p, void *res, int s
>>         compiletime_assert(__native_word(t),                            \
>>                 "Need native word sized stores/loads for atomicity.")
>>
>> +/*
>> + * Force the compiler to emit 'sym' as a symbol, so that we can reference
>> + * it from inline assembler. Necessary in case 'sym' could be inlined
>> + * otherwise, or eliminated entirely due to lack of references that are
>> + * visibile to the compiler.
>> + */
>> +#define __ADDRESSABLE(sym) \
>> +       static void *__attribute__((section(".discard.text"), used))    \
>> +               __PASTE(__discard_##sym, __LINE__)(void)                \
>> +                       { return (void *)&sym; }                        \
>> +
>>  #endif /* __LINUX_COMPILER_H */
>
> Isn't this logically the point where you should add the arm64
> vmlinux.lds.S change, and explain how ".discard.text" turns into
> ".init.discard.text" for some odd arm64 reason?
>

I tried to keep the generic patches generic, so perhaps I should just
put the arm64 vmlinux.lds.S change in a patch on its own?
