From: Babu Moger <babu.moger@oracle.com>
Date: Wed, 24 May 2017 17:03:38 +0000
Subject: Re: CPU_BIG_ENDIAN in generic code (was: Re: [PATCH v3 3/7] arch/sparc: Define config parameter CPU_
Message-Id: <9d446ade-e3ef-f694-2b9b-f82e5ef463cb@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAMuHMdVjh+1TR19mUUQYHSazHnBHa4uxn7KyHUO+jAh7WDxy5Q@mail.gmail.com>
 <CAK8P3a1XZGQk3b3q+JFJ+mLgw_upUdAtTM1VBjHZq5f2m-YdUg@mail.gmail.com>
 <8ec12d9b-30da-6088-e340-93cc92245ed4@oracle.com>
 <CAK8P3a2gk07SW2nGZdNXSzRwx5+Ap5hDf4wDksunLtYkpC5WOg@mail.gmail.com>
In-Reply-To: <CAK8P3a2gk07SW2nGZdNXSzRwx5+Ap5hDf4wDksunLtYkpC5WOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>


On 5/24/2017 10:09 AM, Arnd Bergmann wrote:
> On Wed, May 24, 2017 at 4:45 PM, Babu Moger <babu.moger@oracle.com> wrote:
>> On 5/24/2017 5:18 AM, Arnd Bergmann wrote:
>>> On Wed, May 24, 2017 at 11:59 AM, Geert Uytterhoeven
>>> <geert@linux-m68k.org> wrote:
>>>> On Tue, May 23, 2017 at 11:45 PM, Babu Moger <babu.moger@oracle.com>
>>>> wrote:
>>>> include/asm-generic/qrwlock.h is also generic, but depends on the
>>>> architecture to select ARCH_USE_QUEUED_RWLOCKS, which only very few do
>>>> (x86, and now sparc).
>>>>
>>>> I guess the time is ripe for adding (both) symbols to all architectures?
>>> Good idea. I think we can do most of this by adding a few lines to
>>> arch/Kconfig:
>>>
>>> config CPU_BIG_ENDIAN
>>>           bool
>>>
>>> config CPU_LITTLE_ENDIAN
>>>          def_bool !CPU_BIG_ENDIAN
>> I noticed that even x86 does not define CPU_LITTLE_ENDIAN.  Strange.
> There is no architecture-independent code that tests for
> CONFIG_CPU_LITTLE_ENDIAN, unlike CONFIG_CPU_BIG_ENDIAN,
> so that's not very suprising.

Ok. Thanks
>> With this code all the architecture will default to
>> CONFIG_CPU_LITTLE_ENDIAN.
> What I meant is that we have to 'select CPU_BIG_ENDIAN' on all architectures
> that actually are big-endian:
Ok. Sure.
>
> These are all configurable:
> $ git grep -l linux/byteorder/big_endian.h | xargs grep -l
> linux/byteorder/little_endian.h
> arch/arc/include/uapi/asm/byteorder.h
> arch/arm/include/uapi/asm/byteorder.h
> arch/arm64/include/uapi/asm/byteorder.h
> arch/c6x/include/uapi/asm/byteorder.h
> arch/m32r/include/uapi/asm/byteorder.h
> arch/microblaze/include/uapi/asm/byteorder.h
> arch/mips/include/uapi/asm/byteorder.h
> arch/powerpc/include/uapi/asm/byteorder.h
> arch/sh/include/uapi/asm/byteorder.h
> arch/tile/include/uapi/asm/byteorder.h
>
> These are always big-endian:
> $ git grep -l linux/byteorder/big_endian.h | xargs grep -L
> linux/byteorder/little_endian.h
> arch/avr32/include/uapi/asm/byteorder.h
> arch/frv/include/uapi/asm/byteorder.h
> arch/m68k/include/uapi/asm/byteorder.h
> arch/openrisc/include/uapi/asm/byteorder.h
> arch/parisc/include/uapi/asm/byteorder.h
> arch/s390/include/uapi/asm/byteorder.h
> arch/sparc/include/uapi/asm/byteorder.h
>
> And these are always little-endian:
> arch/alpha/include/uapi/asm/byteorder.h
> arch/blackfin/include/uapi/asm/byteorder.h
> arch/cris/include/uapi/asm/byteorder.h
> arch/hexagon/include/uapi/asm/byteorder.h
> arch/ia64/include/uapi/asm/byteorder.h
> arch/metag/include/uapi/asm/byteorder.h
> arch/mn10300/include/uapi/asm/byteorder.h
> arch/score/include/uapi/asm/byteorder.h
> arch/unicore32/include/uapi/asm/byteorder.h
> arch/x86/include/uapi/asm/byteorder.h
>
> So if we 'select CPU_BIG_ENDIAN' from avr32, frv, m68k, openrisc, parisc,
> s390 and sparc, this covers all the fixed-endian architectures, and the
> other ones are those that already have either CPU_BIG_ENDIAN
> as a 'bool' option, or both as a 'choice'.
Ok.  Great details. I think I have all the details required for the 
first version.  Will post it soon. Thanks

>> I can make it as a separate patch. But I can only test SPARC and little bit
>> of x86. Is that ok?
> I think that's ok.
>
>          Arnd

