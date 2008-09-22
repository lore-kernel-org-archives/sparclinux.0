From: David Miller <davem@davemloft.net>
Date: Mon, 22 Sep 2008 19:49:29 +0000
Subject: Re: [PATCH]: Fix disappearing PCI devices
Message-Id: <20080922.124929.193700887.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080921.163315.125565921.davem@davemloft.net>
In-Reply-To: <20080921.163315.125565921.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 22 Sep 2008 15:49:12 +0300 (EEST)

> By the way, there seems to be a EBUS bridge together with each PCI HME - 
> what are these useful for?

Nothing, they aren't hooked up to any actual devices.

I think it was just too much work to remove them from the chip design with
the HME, so they just left it there.

Thanks for testing.
