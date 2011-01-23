From: David Miller <davem@davemloft.net>
Date: Sun, 23 Jan 2011 19:54:58 +0000
Subject: Re: [patch 4/9] sparc: Replace deprecated spinlock initialization
Message-Id: <20110123.115458.183063678.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20110123143631.392446736@linutronix.de>
	<20110123143837.223928325@linutronix.de>
In-Reply-To: <20110123143837.223928325@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, sparclinux@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>
Date: Sun, 23 Jan 2011 15:17:04 -0000

> SPIN_LOCK_UNLOCK is deprecated. Use the lockdep capable variant
> instead.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Acked-by: David S. Miller <davem@davemloft.net>
