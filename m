From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 23 Sep 2004 04:46:55 +0000
Subject: Re: Ultra 2 Enterprise: All 2.6.xx SMP kernels hardlock
Message-Id: <20040922214655.40908fe5.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <703d4eaa04092018404389859@mail.gmail.com>
In-Reply-To: <703d4eaa04092018404389859@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Wed, 22 Sep 2004 18:26:14 -0600 (MDT)
Jason Wever <weeve@gentoo.org> wrote:

> tsk->{mm,active_mm}->context = 0000000000000000
> tsk->{mm,active_mm}->pgd = fffff8007f00ec00
>                \|/ ____ \|/
>                "@'/ .. \`@"
>                /_| \__/ |_\
>                   \__U_/
> swapper(0): Oops [#1]
> TSTATE: 0000009980f09602 TPC: 00000000004507ac TNPC: 00000000004507b0 Y: 
> 00000000    Not tainted
> TPC: <time_interpolator_update+0xc/0x260>

We're getting timer interrupts firing before the
register_time_interpolator() call in
arch/sparc64/kernel/time.c:time_init(), so that
dereferences a NULL time_interpolator pointer
and everything goes tits up.

I'll try to fix this tomorrow.
