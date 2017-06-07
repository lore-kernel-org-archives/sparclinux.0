From: Babu Moger <babu.moger@oracle.com>
Date: Wed, 07 Jun 2017 23:07:20 +0000
Subject: Re: CPU_BIG_ENDIAN in generic code (was: Re: [PATCH v3 3/7] arch/sparc: Define config parameter CPU_
Message-Id: <28d6c874-4653-b15d-39b7-57a032abc9c6@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAMuHMdVjh+1TR19mUUQYHSazHnBHa4uxn7KyHUO+jAh7WDxy5Q@mail.gmail.com>
 <87a85v7to2.fsf@concordia.ellerman.id.au>
 <CAMuHMdU1kne4tKRfyx0hr1LXh_c75bYMs0b=vncHqrhB69jqYg@mail.gmail.com>
 <877f0z6oig.fsf@concordia.ellerman.id.au>
In-Reply-To: <877f0z6oig.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Ellerman <mpe@ellerman.id.au>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>


On 5/29/2017 9:56 PM, Michael Ellerman wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>
>> Hi Michael,
>>
>> On Mon, May 29, 2017 at 2:07 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>>> On Tue, May 23, 2017 at 11:45 PM, Babu Moger <babu.moger@oracle.com> wrote:
>>>>> Found this problem while enabling queued rwlock on SPARC.
>>>>> The parameter CONFIG_CPU_BIG_ENDIAN is used to clear the
>>>>> specific byte in qrwlock structure. Without this parameter,
>>>>> we clear the wrong byte. Here is the code.
>>>>>
>>>>> static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
>>>>>   {
>>>>>          return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
>>>>>   }
>>>>>
>>>>> Define CPU_BIG_ENDIAN for SPARC to fix it.
>>>>> --- a/arch/sparc/Kconfig
>>>>> +++ b/arch/sparc/Kconfig
>>>>> @@ -92,6 +92,10 @@ config ARCH_DEFCONFIG
>>>>>   config ARCH_PROC_KCORE_TEXT
>>>>>          def_bool y
>>>>>
>>>>> +config CPU_BIG_ENDIAN
>>>>> +       bool
>>>>> +       default y if SPARC
>>>> Nice catch!
>>>>
>>>> Traditionally, CPU_BIG_ENDIAN and CPU_LITTLE_ENDIAN were defined only on
>>>> architectures that may support both.  And it was checked in platform code
>>>> and drivers only.
>>>> Hence the symbol is lacking from most architectures. Heck, even
>>>> architectures that support both may default to one endiannes, and declare
>>>> only the symbol for the other endianness:
>>> I guess there's a reason we can't use __BIG_ENDIAN__ / __LITTLE_ENDIAN__ ?
>> I (C/asm) code we can, in Kconfig we cannot.
>>
>> So far we tried always doing that, but a few checks for the semi-existing
>> Kconfig symbol crept in in generic code. Those could be replaced by the __*__
>> variants, but consistently having the Kconfig symbols would be useful anyway
>> (e.g. to avoid building the broken-on-big-endian ISDN drivers).
> Ah OK, the original mail was citing C code, but yeah I guess it would be
> handy in Makefiles etc.

Thanks for all the responses.  I see couple of options here.

1. Fix the c code in include/asm-generic/qrwlock.h using ifdef 
__BIG_ENDIAN__
     This will fix the issue for us.

2. Define CPU_BIG_ENDIAN for all the missing fixed endian architectures. 
Because the problem is only for fixed big endian archs.

I prefer the option 1.  What do you guys think ?

> cheers

