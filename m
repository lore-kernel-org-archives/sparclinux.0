From: Kirill Tkhai <tkhai@yandex.ru>
Date: Mon, 05 Dec 2011 21:33:17 +0000
Subject: Clock event support on SPARC32
Message-Id: <1323120797.3274.20.camel@hp>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hello!

I'm not sending a patch, just asking a question.

There is no clock event support on SPARC32, but it's possible to
implement it.

The plan is to use local timers as periodic and one-shot clock events,
while global timer is a continuous clock source. It ticks and increases
internal counter of tick number every 2 seconds (it's possible to use
more, but I use a round number). The number "counter * size_of_tick +
master_l10_counter" gives us the continuous clocksource.

The only problem is a fact that LEON doesn't have a master_l10_counter,
but it's possible to use HZ-lenght clocksource for this case.

If we get clocksource support, we'll get HIGH_RES_TIMERS.

So, the question is "will this feature be useful for SPARC?". I did the
same on 2.6.33 for my work, I can do this for version 3.*.

Regards,
Kirill Tkhai

