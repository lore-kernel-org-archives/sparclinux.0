From: Babu Moger <babu.moger@oracle.com>
Date: Wed, 24 May 2017 14:45:38 +0000
Subject: Re: CPU_BIG_ENDIAN in generic code (was: Re: [PATCH v3 3/7] arch/sparc: Define config parameter CPU_
Message-Id: <8ec12d9b-30da-6088-e340-93cc92245ed4@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAMuHMdVjh+1TR19mUUQYHSazHnBHa4uxn7KyHUO+jAh7WDxy5Q@mail.gmail.com>
 <CAK8P3a1XZGQk3b3q+JFJ+mLgw_upUdAtTM1VBjHZq5f2m-YdUg@mail.gmail.com>
In-Reply-To: <CAK8P3a1XZGQk3b3q+JFJ+mLgw_upUdAtTM1VBjHZq5f2m-YdUg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>
Cc: "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

Arnd,


On 5/24/2017 5:18 AM, Arnd Bergmann wrote:
> On Wed, May 24, 2017 at 11:59 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Tue, May 23, 2017 at 11:45 PM, Babu Moger <babu.moger@oracle.com> wrote:
>>> Found this problem while enabling queued rwlock on SPARC.
>>> The parameter CONFIG_CPU_BIG_ENDIAN is used to clear the
>>> specific byte in qrwlock structure. Without this parameter,
>>> we clear the wrong byte. Here is the code.
>>>
>>> static inline u8 *__qrwlock_write_byte(struct qrwlock *lock)
>>>   {
>>>          return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
>>>   }
>>>
>>> Define CPU_BIG_ENDIAN for SPARC to fix it.
>>> --- a/arch/sparc/Kconfig
>>> +++ b/arch/sparc/Kconfig
>>> @@ -92,6 +92,10 @@ config ARCH_DEFCONFIG
>>>   config ARCH_PROC_KCORE_TEXT
>>>          def_bool y
>>>
>>> +config CPU_BIG_ENDIAN
>>> +       bool
>>> +       default y if SPARC
>> Nice catch!
>>
>> Traditionally, CPU_BIG_ENDIAN and CPU_LITTLE_ENDIAN were defined only on
>> architectures that may support both.  And it was checked in platform code
>> and drivers only.
>> Hence the symbol is lacking from most architectures. Heck, even
>> architectures that support both may default to one endiannes, and declare
>> only the symbol for the other endianness:
>>
>> --- arch/alpha ---
>> --- arch/arc ---
>> arch/arc/Kconfig:config CPU_BIG_ENDIAN
>> --- arch/arm ---
>> arch/arm/mm/Kconfig:config CPU_BIG_ENDIAN
>> --- arch/arm64 ---
>> arch/arm64/Kconfig:config CPU_BIG_ENDIAN
>> --- arch/blackfin ---
>> --- arch/c6x ---
>> arch/c6x/Kconfig:config CPU_BIG_ENDIAN
>> --- arch/cris ---
>> --- arch/frv ---
>> --- arch/h8300 ---
>> --- arch/hexagon ---
>> --- arch/ia64 ---
>> --- arch/Kconfig ---
>> --- arch/m32r ---
>> arch/m32r/Kconfig:config CPU_LITTLE_ENDIAN
>> --- arch/m68k ---
>> --- arch/metag ---
>> --- arch/microblaze ---
>> --- arch/mips ---
>> arch/mips/Kconfig:config CPU_BIG_ENDIAN
>> arch/mips/Kconfig:config CPU_LITTLE_ENDIAN
>> --- arch/mn10300 ---
>> --- arch/nios2 ---
>> --- arch/openrisc ---
>> --- arch/parisc ---
>> --- arch/powerpc ---
>> arch/powerpc/platforms/Kconfig.cputype:config CPU_BIG_ENDIAN
>> arch/powerpc/platforms/Kconfig.cputype:config CPU_LITTLE_ENDIAN
>> --- arch/s390 ---
>> arch/s390/Kconfig:config CPU_BIG_ENDIAN
>> --- arch/score ---
>> --- arch/sh ---
>> arch/sh/Kconfig.cpu:config CPU_LITTLE_ENDIAN
>> arch/sh/Kconfig.cpu:config CPU_BIG_ENDIAN
>> --- arch/sparc ---
>> --- arch/tile ---
>> --- arch/um ---
>> --- arch/unicore32 ---
>> --- arch/x86 ---
>> --- arch/xtensa ---
>>
>> However, there are already a few users in generic code, which are thus
>> broken on many platforms:
>>
>>      drivers/of/base.c
>>      drivers/of/fdt.c
>>      drivers/tty/serial/earlycon.c
>>      drivers/tty/serial/serial_core.c
>>
>> include/asm-generic/qrwlock.h is also generic, but depends on the
>> architecture to select ARCH_USE_QUEUED_RWLOCKS, which only very few do
>> (x86, and now sparc).
>>
>> I guess the time is ripe for adding (both) symbols to all architectures?
> Good idea. I think we can do most of this by adding a few lines to
> arch/Kconfig:
>
> config CPU_BIG_ENDIAN
>          bool
>
> config CPU_LITTLE_ENDIAN
>         def_bool !CPU_BIG_ENDIAN
I noticed that even x86 does not define CPU_LITTLE_ENDIAN.  Strange.
With this code all the architecture will default to 
CONFIG_CPU_LITTLE_ENDIAN.
I can make it as a separate patch. But I can only test SPARC and little 
bit of x86.
Is that ok?

>
> This way, we only need to add 'select CPU_BIG_ENDIAN' to the
> architectures that are always big-endian, and we don't need to
> change anything for the ones that have a single 'CPU_BIG_ENDIAN'
> option.
>
> The three architectures that have a 'choice' statement (mips, ppc and
> sh) will have to convert, and m32r will have to replace the
> option with the opposite one, which could break 'make oldconfig',
> but nobody really cares about m32r any more.
>
>         Arnd

