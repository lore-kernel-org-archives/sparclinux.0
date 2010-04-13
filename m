From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 13 Apr 2010 08:37:14 +0000
Subject: Re: [PATCH 0/4]: Respin local_irq_*_nmi() stuff.
Message-Id: <1271147834.4807.980.camel@twins>
List-Id: <sparclinux.vger.kernel.org>
References: <20100409.160132.216116766.davem@davemloft.net>
	 <20100412.220838.132238558.davem@davemloft.net>
	 <1271144938.4807.925.camel@twins>
	 <20100413.005640.48990319.davem@davemloft.net>
In-Reply-To: <20100413.005640.48990319.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org

On Tue, 2010-04-13 at 00:56 -0700, David Miller wrote:

> If we are in an NMI then doing a plain raw_local_irq_disable() will
> write PIL_NORMAL_MAX into %pil, which is lower than PIL_NMI, and thus
> we'll re-enable NMIs and recurse.
> 
> Doing a simple:
> 
> 	%pil = %pil | PIL_NORMAL_MAX
> 
> does what we want, if we're already at PIL_NMI (15) we leave it at
> that setting, else we set it to PIL_NORMAL_MAX (14).

Ah indeed, and without a conditional, very nice! 

It does rely on the exact values of the PIL_levels, it might make sense
to note that in the comment, something like:

  * Assumes: PIL_NMI | PIL_NORMAL_MAX = PIL_NMI.

Hmm, it also assumes %pil is never anything other than 0,
PIL_NORMAL_MAX, PIL_NMI, because if:

  (%pil & 1) && (%pil != PIL_NMI)

then you'll end up disabling NMIs. Could something like that ever
happen?


