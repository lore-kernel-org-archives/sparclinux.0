From: David Miller <davem@davemloft.net>
Date: Wed, 07 Sep 2011 17:12:17 +0000
Subject: Re: [PATCH 20/62] sparc: irq: Remove IRQF_DISABLED
Message-Id: <20110907.131217.2301665763990232637.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
	<1315383059-3673-21-git-send-email-yong.zhang0@gmail.com>
In-Reply-To: <1315383059-3673-21-git-send-email-yong.zhang0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: yong.zhang0@gmail.com
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@elte.hu, joe@perches.com, sparclinux@vger.kernel.org

From: Yong Zhang <yong.zhang0@gmail.com>
Date: Wed,  7 Sep 2011 16:10:17 +0800

> This flag is a NOOP and can be removed now.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>

How are things working now, if that is the case?

Specifically in the ldc_bind() case, we're passing iRQF_DISABLED here
so that the IRQ is not turned on when we request the IRQ, we later do
enable_irq() on these after we've take the spinlock in this function.

The IRQ cannot be allowed to be delivered between the request_irq()
call and the enable_irq() calls.

This sequence is necessary to deal with some lock ordering issues.
