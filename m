From: Sam Ravnborg <sam.ravnborg@gmail.com>
Date: Thu, 29 Dec 2011 12:42:08 +0000
Subject: Re: Clock event support on SPARC32
Message-Id: <CAMGS=fCqyu7XUesv67BmNJ3sTQFsfoLs+qq4s_Uj=bxAhai8tg@mail.gmail.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1323120797.3274.20.camel@hp>
In-Reply-To: <1323120797.3274.20.camel@hp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Mon, Dec 5, 2011 at 10:33 PM, Kirill Tkhai <tkhai@yandex.ru> wrote:
> Hello!
Hi Kirill - late answer...

>
> There is no clock event support on SPARC32, but it's possible to
> implement it.
In general we would like to use as much of the generic code for
sparc32 as possible.
Introducing support for clock events is thus a good thing.

> The plan is to use local timers as periodic and one-shot clock events,
> while global timer is a continuous clock source. It ticks and increases
> internal counter of tick number every 2 seconds (it's possible to use
> more, but I use a round number). The number "counter * size_of_tick +
> master_l10_counter" gives us the continuous clocksource.

Sounds like a good plan.

> The only problem is a fact that LEON doesn't have a master_l10_counter,
> but it's possible to use HZ-lenght clocksource for this case.
Let's get it working for plain sparc32 - then we can surely work out
somethign for LEON later.

I will try to find time to review your patches (short on Linux time...)

    Sam
