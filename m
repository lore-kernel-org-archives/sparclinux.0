From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 25 May 2017 22:52:14 +0000
Subject: Re: CPU_BIG_ENDIAN in generic code (was: Re: [PATCH v3 3/7] arch/sparc: Define config parameter CPU_
Message-Id: <CAMo8Bf+m0mqnrpC=b+3sGq0iMfqUj2uVtQxtLU6+5pNc_4fWNw@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <CAMuHMdVjh+1TR19mUUQYHSazHnBHa4uxn7KyHUO+jAh7WDxy5Q@mail.gmail.com>
 <CAK8P3a1XZGQk3b3q+JFJ+mLgw_upUdAtTM1VBjHZq5f2m-YdUg@mail.gmail.com>
 <CAMo8BfL8G0Fzn2SZ1356yaoxGgm8tpTDmFJ8cCxEEEgyObMwCQ@mail.gmail.com> <116e7ba5-cb5e-8e96-ea74-bf91b4818d69@oracle.com>
In-Reply-To: <116e7ba5-cb5e-8e96-ea74-bf91b4818d69-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Babu Moger <babu.moger-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, "David S. Miller" <davem-fT/PcQaiUtIeIZ0/mPfg9Q@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Ingo Molnar <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, sparclinux <sparclinux-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux-Arch <linux-arch-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>

On Thu, May 25, 2017 at 3:41 PM, Babu Moger <babu.moger@oracle.com> wrote:
> On 5/25/2017 5:27 PM, Max Filippov wrote:
>> Xtensa may have either endianness and for xtensa we define
>> CONFIG_CPU_BIG_ENDIAN or CONFIG_CPU_LITTLE_ENDIAN
>> in the arch/xtensa/Makefile based on the value of the compiler builtin
>> macro.
>
> Hmm.. That means defining  CPU_LITTLE_ENDIAN  based on "def_bool
> !CPU_BIG_ENDIAN" will
>  be a problem for Xtensa because menuconfig does not have the knowledge of
> compiler builtin macro.
> Is that correct?

I think so. OTOH outside the arch/ CPU_LITTLE_ENDIAN is only used in
two Kconfig files:

drivers/crypto/nx/Kconfig
drivers/isdn/hisax/Kconfig

both of which are irrelevant for xtensa.

-- 
Thanks.
-- Max
