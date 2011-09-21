From: David Miller <davem@davemloft.net>
Date: Wed, 21 Sep 2011 17:40:07 +0000
Subject: Re: [PATCH 18/57] sparc: irq: Remove IRQF_DISABLED
Message-Id: <20110921.134007.1812828154454173068.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1316597339-29861-1-git-send-email-yong.zhang0@gmail.com>
	<1316597339-29861-19-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1316597339-29861-19-git-send-email-yong.zhang0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yong.zhang0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, joe@perches.com, paul.gortmaker@windriver.com, sparclinux@vger.kernel.org

From: Yong Zhang <yong.zhang0@gmail.com>
Date: Wed, 21 Sep 2011 17:28:19 +0800

> Since commit [c58543c8: genirq: Run irq handlers with interrupts disabled],
> We run all interrupt handlers with interrupts disabled
> and we even check and yell when an interrupt handler
> returns with interrupts enabled (see commit [b738a50a:
> genirq: Warn when handler enables interrupts]).
> 
> So now this flag is a NOOP and can be removed.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>

Acked-by: David S. Miller <davem@davemloft.net>
