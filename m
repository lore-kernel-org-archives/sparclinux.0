From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 02 Jan 2018 23:55:05 +0000
Subject: Re: [PATCH v7 02/10] module: allow symbol exports to be disabled
Message-Id: <CAKv+Gu9x+DeOdMn1CuEDNHtLSi1_cFpx7ZyxMYVGht0qBastmw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <20180102200549.22984-1-ard.biesheuvel@linaro.org>
 <20180102200549.22984-3-ard.biesheuvel@linaro.org>
 <nycvar.YSQ.7.76.1801021841410.8567@knanqh.ubzr>
In-Reply-To: <nycvar.YSQ.7.76.1801021841410.8567@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On 2 January 2018 at 23:47, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Tue, 2 Jan 2018, Ard Biesheuvel wrote:
>
>> To allow existing C code to be incorporated into the decompressor or
>> the UEFI stub, introduce a CPP macro that turns all EXPORT_SYMBOL_xxx
>> declarations into nops, and #define it in places where such exports
>> are undesirable. Note that this gets rid of a rather dodgy redefine
>> of linux/export.h's header guard.
> [...]
>
>> --- a/include/linux/export.h
>> +++ b/include/linux/export.h
>> @@ -83,6 +83,15 @@ extern struct module __this_module;
>>   */
>>  #define __EXPORT_SYMBOL(sym, sec)    == __KSYM_##sym =>>
>> +#elif defined(__DISABLE_EXPORTS)
>> +
>> +/*
>> + * Allow symbol exports to be disabled completely so that C code may
>> + * be reused in other execution contexts such as the UEFI stub or the
>> + * decompressor.
>> + */
>> +#define __EXPORT_SYMBOL(sym, sec)
>> +
>
> I think you should rather put this first thing in the #if sequence so to
> override the defined(__KSYM_DEPS__) case too.  No need to create build
> dependencies for module symbols that you're going to stub out
> afterwards anyway.
>

I wasn't sure, so thanks for clearing that up.
