From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 29 May 2017 12:54:16 +0000
Subject: Re: CPU_BIG_ENDIAN in generic code (was: Re: [PATCH v3 3/7] arch/sparc: Define config parameter CPU_
Message-Id: <CAK8P3a0GEzj16=M5jV=u6ACE8K3_QMPk142AhFDLSp9MgpFTeQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAMuHMdVjh+1TR19mUUQYHSazHnBHa4uxn7KyHUO+jAh7WDxy5Q@mail.gmail.com>
 <CAK8P3a1XZGQk3b3q+JFJ+mLgw_upUdAtTM1VBjHZq5f2m-YdUg@mail.gmail.com>
 <CAMo8BfL8G0Fzn2SZ1356yaoxGgm8tpTDmFJ8cCxEEEgyObMwCQ@mail.gmail.com> <CAMo8BfJDRStMDGThMQhmZBQs2LLwxFOthuqQaC1qyws14gwhRA@mail.gmail.com>
In-Reply-To: <CAMo8BfJDRStMDGThMQhmZBQs2LLwxFOthuqQaC1qyws14gwhRA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Babu Moger <babu.moger@oracle.com>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Fri, May 26, 2017 at 12:43 AM, Max Filippov <jcmvbkbc@gmail.com> wrote:
> On Thu, May 25, 2017 at 3:27 PM, Max Filippov <jcmvbkbc@gmail.com> wrote:
>> On Wed, May 24, 2017 at 3:18 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Wed, May 24, 2017 at 11:59 AM, Geert Uytterhoeven
>>> <geert@linux-m68k.org> wrote:
>>>> I guess the time is ripe for adding (both) symbols to all architectures?
>>>
>>> Good idea. I think we can do most of this by adding a few lines to
>>> arch/Kconfig:
>>>
>>> config CPU_BIG_ENDIAN
>>>         bool
>>>
>>> config CPU_LITTLE_ENDIAN
>>>        def_bool !CPU_BIG_ENDIAN
>>>
>>> This way, we only need to add 'select CPU_BIG_ENDIAN' to the
>>> architectures that are always big-endian, and we don't need to
>>> change anything for the ones that have a single 'CPU_BIG_ENDIAN'
>>> option.
>>>
>>> The three architectures that have a 'choice' statement (mips, ppc and
>>> sh) will have to convert, and m32r will have to replace the
>>> option with the opposite one, which could break 'make oldconfig',
>>> but nobody really cares about m32r any more.
>>
>> Xtensa may have either endianness and for xtensa we define
>> CONFIG_CPU_BIG_ENDIAN or CONFIG_CPU_LITTLE_ENDIAN
>> in the arch/xtensa/Makefile based on the value of the compiler builtin
>> macro.

I can sort of see why xtensa did it the other way round from everyone
else (letting the toolchain decide what the kernel is, rather than letting
the kernel pass the respective flags to gcc), but I'd argue that it would
be better overall for xtensa to change over so we do it consistently
on all architectures.

> Also, in outside the Kconfig files there's much more instances of
> __{BIG,LITTLE}_ENDIAN than CONFIG_CPU_{BIG,LITTLE}_ENDIAN:
>
> $ git grep '__\(BIG\|LITTLE\)_ENDIAN' | wc -l
> 4537
> $ git grep 'CONFIG_CPU_\(BIG\|LITTLE\)_ENDIAN' | wc -l
> 247
>
> My understanding is that CONFIG_CPU_{BIG,LITTLE}_ENDIAN was
> intended to be used only in Kconfig files, and perhaps all of its uses
> outside should be replaced with __{BIG,LITTLE}_ENDIAN.

Right, but I also think that using the CONFIG_CPU_* symbols in
code makes sense because it is less ambiguous: the way we use
__{BIG,LITTLE}_ENDIAN in the kernel is different from how user
space uses them in glibc, and this confuses everyone when they
try to use them in the kernel after being familiar with the traditional
way. The Kconfig symbols don't have this problem.

       Arnd
