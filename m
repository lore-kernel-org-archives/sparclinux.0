From: David Miller <davem@davemloft.net>
Date: Tue, 15 Oct 2019 20:34:14 +0000
Subject: Re: [PATCH 19/34] sparc: Use CONFIG_PREEMPTION
Message-Id: <20191015.133414.946929614650400310.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
        <20191015191821.11479-20-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-20-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: bigeasy@linutronix.de
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, sparclinux@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Tue, 15 Oct 2019 21:18:06 +0200

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
> Both PREEMPT and PREEMPT_RT require the same functionality which today
> depends on CONFIG_PREEMPT.
> 
> Switch the trap code over to use CONFIG_PREEMPTION.
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: +Kconfig]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: David S. Miller <davem@davemloft.net>
