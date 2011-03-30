From: David Miller <davem@davemloft.net>
Date: Wed, 30 Mar 2011 22:41:24 +0000
Subject: Re: [PATCH] sparc32,leon: need VIRQ:IRQ 1:1, don't mask/ack IRQ
Message-Id: <20110330.154124.108778473.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1300290864-20678-1-git-send-email-daniel@gaisler.com>
In-Reply-To: <1300290864-20678-1-git-send-email-daniel@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Wed, 30 Mar 2011 14:41:45 +0200

> I see, however that is almost as bad because that would also require
> one driver per core but in the LEON IRQ layer of Linux.

This is absolutely unavoidable since the firmware device tree doesn't
pass along the proper set of IRQs.  You have to fixup your tree,
because it is broken.
