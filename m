From: David Miller <davem@davemloft.net>
Date: Mon, 29 Aug 2011 16:26:47 +0000
Subject: Re: [PATCH] sparc32,sun4d: Change IPI IRQ level to prevent
Message-Id: <20110829.122647.235514630837001271.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1108282349020.24571@oizys.tordivel.org>
In-Reply-To: <Pine.LNX.4.64.1108282349020.24571@oizys.tordivel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Kjetil Oftedal <oftedal@gmail.com>
Date: Mon, 29 Aug 2011 00:16:28 +0200 (CEST)

> On Sun4d systems running in SMP mode, IRQ 14 is used for timer interrupts 
> and has a specialized interrupt handler. IPI is currently set to use IRQ 14 
> as well, which causes it to trigger the timer interrupt handler, and not the 
> IPI interrupt handler. 
> 
> The IPI interrupt is therefore changed to IRQ 13, which is the highest 
> normally handled interrupt. This IRQ is also used for SBUS interrupts, 
> however there is nothing in the IPI/SBUS interrupt handlers that indicate 
> that they will not handle sharing the interrupt.
> (IRQ 13 is indicated as audio interrupt, which is unlikely to be found in a 
> sun4d system)
> 
> Signed-off-by: Kjetil Oftedal <oftedal@gmail.com>

Applied, thanks a lot!
