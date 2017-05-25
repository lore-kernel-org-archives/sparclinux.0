From: Babu Moger <babu.moger@oracle.com>
Date: Thu, 25 May 2017 22:41:11 +0000
Subject: Re: CPU_BIG_ENDIAN in generic code (was: Re: [PATCH v3 3/7] arch/sparc: Define config parameter CPU_
Message-Id: <116e7ba5-cb5e-8e96-ea74-bf91b4818d69@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAMuHMdVjh+1TR19mUUQYHSazHnBHa4uxn7KyHUO+jAh7WDxy5Q@mail.gmail.com>
 <CAK8P3a1XZGQk3b3q+JFJ+mLgw_upUdAtTM1VBjHZq5f2m-YdUg@mail.gmail.com>
 <CAMo8BfL8G0Fzn2SZ1356yaoxGgm8tpTDmFJ8cCxEEEgyObMwCQ@mail.gmail.com>
In-Reply-To: <CAMo8BfL8G0Fzn2SZ1356yaoxGgm8tpTDmFJ8cCxEEEgyObMwCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>


On 5/25/2017 5:27 PM, Max Filippov wrote:
> On Wed, May 24, 2017 at 3:18 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Wed, May 24, 2017 at 11:59 AM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>>> I guess the time is ripe for adding (both) symbols to all architectures?
>> Good idea. I think we can do most of this by adding a few lines to
>> arch/Kconfig:
>>
>> config CPU_BIG_ENDIAN
>>          bool
>>
>> config CPU_LITTLE_ENDIAN
>>         def_bool !CPU_BIG_ENDIAN
>>
>> This way, we only need to add 'select CPU_BIG_ENDIAN' to the
>> architectures that are always big-endian, and we don't need to
>> change anything for the ones that have a single 'CPU_BIG_ENDIAN'
>> option.
>>
>> The three architectures that have a 'choice' statement (mips, ppc and
>> sh) will have to convert, and m32r will have to replace the
>> option with the opposite one, which could break 'make oldconfig',
>> but nobody really cares about m32r any more.
> Xtensa may have either endianness and for xtensa we define
> CONFIG_CPU_BIG_ENDIAN or CONFIG_CPU_LITTLE_ENDIAN
> in the arch/xtensa/Makefile based on the value of the compiler builtin
> macro.

Hmm.. That means defining  CPU_LITTLE_ENDIAN  based on "def_bool 
!CPU_BIG_ENDIAN" will
  be a problem for Xtensa because menuconfig does not have the knowledge 
of compiler builtin macro.
Is that correct?


