From: David Miller <davem@davemloft.net>
Date: Mon, 20 Aug 2007 22:51:09 +0000
Subject: Re: Re. [SPARC32]: Fix bogus ramdisk image location check.
Message-Id: <20070820.155109.03371741.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <46CA19DE.3000108@earthlink.net>
In-Reply-To: <46CA19DE.3000108@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Mon, 20 Aug 2007 18:46:54 -0400

> commit    f642b263800e6e57c377d630be6d2a999683b579
> 
> This patch causes sparc32 SMP to watchdog fail on boot.
> 
> Reverting it lets the system boot.

Thanks I'll revert this.

Mark, please work with Robert to figure out what we should
do about this if you want to try and make this change again.

I think this shows that SILO can in fact provide ramdisk addresses
which should not be normalized by KERNBASE in the kernel.
