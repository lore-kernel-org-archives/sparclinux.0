From: David Miller <davem@davemloft.net>
Date: Sat, 07 Nov 2009 06:18:34 +0000
Subject: Re: [patch 14/16] sparc: Replace old style lock initializer
Message-Id: <20091106.221834.246946954.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20091106223547.784916750@linutronix.de>
	<20091106223806.973326715@linutronix.de>
In-Reply-To: <20091106223806.973326715@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tglx@linutronix.de
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu, peterz@infradead.org, sparclinux@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>
Date: Fri, 06 Nov 2009 22:42:14 -0000

> SPIN_LOCK_UNLOCKED is deprecated. Use __SPIN_LOCK_UNLOCKED instead.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Applied to sparc-next-2.6, thanks.
