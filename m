From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 08:46:31 +0000
Subject: Re: [PATCH 0/4]: Respin local_irq_*_nmi() stuff.
Message-Id: <20100413.014631.45686537.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1271144938.4807.925.camel@twins>
	<20100413.005640.48990319.davem@davemloft.net>
	<1271147834.4807.980.camel@twins>
In-Reply-To: <1271147834.4807.980.camel@twins>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: peterz@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 13 Apr 2010 10:37:14 +0200

> Hmm, it also assumes %pil is never anything other than 0,
> PIL_NORMAL_MAX, PIL_NMI, because if:
> 
>   (%pil & 1) && (%pil != PIL_NMI)
> 
> then you'll end up disabling NMIs. Could something like that ever
> happen?

The only values we ever program into the %pil are 0, PIL_NORMAL_MAX
and PIL_NMI

Since PIL_NMI is the largest %pil value and all bits are set in it
(0xf), it doesn't matter what PIL_NORMAL_MAX actually is.

Yes this all deserves a comment, I'll add one, thanks for pointing
that out.
