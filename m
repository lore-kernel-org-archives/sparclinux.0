From: David Miller <davem@davemloft.net>
Date: Wed, 20 Apr 2011 05:42:17 +0000
Subject: Re: [PATCH 0/7] sparc32,leon: additional genirq patches
Message-Id: <20110419.224217.104064563.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <4DADB2F4.6070402@gaisler.com>
In-Reply-To: <4DADB2F4.6070402@gaisler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Daniel Hellstrom <daniel@gaisler.com>
Date: Tue, 19 Apr 2011 18:06:12 +0200

> Hello Dave,
> 
> All the changes in this patch set [1..7] must be applied on top
> of Sam genirq patch. The are all LEON specific.
> 
> They add:
> * mask/unmask spinlock protection
> * Support for LEON Extended IRQ controller
> * Use new genirq layer for per-cpu Timer ISR (cleanup)
> * other cleanups
> * add support for CPU affinity
> 
> Daniel Hellstrom

Hey Daniel, could you please address Sam's feedback on a few patches
and then resubmit this?  You can integrate the ACK's he gave for
some of the patches when you do that.

Thanks!
