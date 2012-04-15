From: David Miller <davem@davemloft.net>
Date: Sun, 15 Apr 2012 17:31:43 +0000
Subject: Re: [PATCH 2/2 - v2] sparc32: generic clockevent support
Message-Id: <20120415.133143.1509013513815952247.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20120406161407.GA17310@merkur.ravnborg.org>
In-Reply-To: <20120406161407.GA17310@merkur.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Sam Ravnborg <sam@ravnborg.org>
Date: Fri, 6 Apr 2012 18:14:07 +0200

>>From aa76a8eb7aa0e5747adccaa8b8ba11a461a9baab Mon Sep 17 00:00:00 2001
> From: Tkhai Kirill <tkhai@yandex.ru>
> Date: Wed, 4 Apr 2012 21:49:26 +0200
> Subject: [PATCH 2/2] sparc32: generic clockevent support
> 
> The kernel uses l14 timers as clockevents. l10 timer is used
> as clocksource if platform master_l10_counter isn't constantly
> zero. The clocksource is continuous, so it's possible to use
> high resolution timers. l10 timer is also used as clockevent
> on UP configurations.
> 
> This realization is for sun4m, sun4d, sun4c, microsparc-IIep
> and LEON platforms. The appropriate LEON changes was made by
> Konrad Eisele.
> 
> In case of sun4m's oneshot mode, profile irq is zeroed in
> smp4m_percpu_timer_interrupt(). It is maybe
> needless (double, triple etc overflow does nothing).
> 
> sun4d is able to have oneshot mode too, but I haven't
> any way to test it. So code of its percpu timer handler
> is made as much equal to the current code as possible.
> 
> The patch is tested on sun4m box in SMP mode by me,
> and tested by Konrad on leon in up mode (leon smp
> is broken atm - due to other reasons).
> 
> Signed-off-by: Tkhai Kirill <tkhai@yandex.ru>
> Tested-by: Konrad Eisele <konrad@gaisler.com> [leon up]
> [sam: revised patch to provide generic support for leon]
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

Applied.
