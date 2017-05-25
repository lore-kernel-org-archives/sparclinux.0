From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 25 May 2017 22:27:48 +0000
Subject: Re: CPU_BIG_ENDIAN in generic code (was: Re: [PATCH v3 3/7] arch/sparc: Define config parameter CPU_
Message-Id: <CAMo8BfL8G0Fzn2SZ1356yaoxGgm8tpTDmFJ8cCxEEEgyObMwCQ@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAMuHMdVjh+1TR19mUUQYHSazHnBHa4uxn7KyHUO+jAh7WDxy5Q@mail.gmail.com>
 <CAK8P3a1XZGQk3b3q+JFJ+mLgw_upUdAtTM1VBjHZq5f2m-YdUg@mail.gmail.com>
In-Reply-To: <CAK8P3a1XZGQk3b3q+JFJ+mLgw_upUdAtTM1VBjHZq5f2m-YdUg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Babu Moger <babu.moger-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, sparclinux <sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Wed, May 24, 2017 at 3:18 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wed, May 24, 2017 at 11:59 AM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> I guess the time is ripe for adding (both) symbols to all architectures?
>
> Good idea. I think we can do most of this by adding a few lines to
> arch/Kconfig:
>
> config CPU_BIG_ENDIAN
>         bool
>
> config CPU_LITTLE_ENDIAN
>        def_bool !CPU_BIG_ENDIAN
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

Xtensa may have either endianness and for xtensa we define
CONFIG_CPU_BIG_ENDIAN or CONFIG_CPU_LITTLE_ENDIAN
in the arch/xtensa/Makefile based on the value of the compiler builtin
macro.

-- 
Thanks.
-- Max
