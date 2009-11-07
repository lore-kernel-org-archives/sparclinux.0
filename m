From: David Miller <davem@davemloft.net>
Date: Sat, 07 Nov 2009 06:16:43 +0000
Subject: Re: [patch 08/16] sparc: Make atomic locks raw
Message-Id: <20091106.221643.03023079.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20091106223547.784916750@linutronix.de>
	<20091106223806.721945005@linutronix.de>
In-Reply-To: <20091106223806.721945005@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, sparclinux@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 06 Nov 2009 22:41:39 -0000

> SPIN_LOCK_UNLOCKED is deprecated and the locks which protect the
> atomic operations have no dependency on other locks and the code is
> well tested so the conversion to a raw lock is safe.
> 
> Make the lock array static while at it.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Applied to sparc-next-2.6, thanks!
