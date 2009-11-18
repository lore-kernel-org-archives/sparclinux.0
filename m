From: David Miller <davem@davemloft.net>
Date: Wed, 18 Nov 2009 07:26:42 +0000
Subject: Re: [patch 04/13] sparc: Fixup last users of irq_chip->typename
Message-Id: <20091117.232642.201632251.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20091117224852.846805939@linutronix.de>
	<20091117224916.491090342@linutronix.de>
In-Reply-To: <20091117224916.491090342@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, sparclinux@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 17 Nov 2009 22:50:40 -0000

> The typename member of struct irq_chip was kept for migration purposes
> and is obsolete since more than 2 years. Fix up the leftovers.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: David S. Miller <davem@davemloft.net>
