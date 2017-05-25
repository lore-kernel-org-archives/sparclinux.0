From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 25 May 2017 20:09:24 +0000
Subject: Re: CPU_BIG_ENDIAN in generic code (was: Re: [PATCH v3 3/7] arch/sparc: Define config parameter CPU_
Message-Id: <CAK8P3a0MEkZ0wpsrit+sS8A0Z5T_jFWF5vFq_BqF2A1tReb7tQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAMuHMdVjh+1TR19mUUQYHSazHnBHa4uxn7KyHUO+jAh7WDxy5Q@mail.gmail.com>
 <CAK8P3a1XZGQk3b3q+JFJ+mLgw_upUdAtTM1VBjHZq5f2m-YdUg@mail.gmail.com> <8ddc7276-6296-2284-51d3-01093ccbeccb@oracle.com>
In-Reply-To: <8ddc7276-6296-2284-51d3-01093ccbeccb@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Babu Moger <babu.moger@oracle.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "David S. Miller" <davem@davemloft.net>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, sparclinux <sparclinux@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>

On Thu, May 25, 2017 at 4:51 PM, Babu Moger <babu.moger@oracle.com> wrote:
> On 5/24/2017 5:18 AM, Arnd Bergmann wrote:

>>> I guess the time is ripe for adding (both) symbols to all architectures?
>>
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
>
>
> what to you mean by "(mips, ppc andsh) will have to convert"?  Do you expect
> any changes here?
>

Kconfig does not allow you to have the same symbol as both a regular
'bool' and also 'bool within choice', so those three have to replace the
choice with a user-visible 'config CPU_BIG_ENDIAN' option like the
other ones have.

I also notice that  for arch/s390/Kconfig you now have both the
'select CPU_BIG_ENDIAN' and the 'config CPU_BIG_ENDIAN
def_bool y', I'd remove the second one in the same patch.

       Arnd
