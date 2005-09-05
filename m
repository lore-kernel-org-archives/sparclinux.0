From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 05 Sep 2005 19:00:41 +0000
Subject: Re: No EDD on sparc64
Message-Id: <20050905.120041.15493405.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0509051716010.7596@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0509051716010.7596@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Meelis Roos <mroos@linux.ee>
Date: Mon, 5 Sep 2005 17:16:45 +0300 (EEST)

> Current git tree offers BIOS EDD driver on sparc64. This mistake is 
> probably from the Kconfig merge.

That's merely a side-effect of bringing in drivers/firmware/Kconfig,
which is where the necessary dependencies need to be introduced.
