From: David Miller <davem@davemloft.net>
Date: Tue, 27 Mar 2007 02:11:07 +0000
Subject: Re: [PATCH] fix sparc32 SMP build regression
Message-Id: <20070326.191107.38321993.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1174960990.13037.7.camel@dell>
In-Reply-To: <1174960990.13037.7.camel@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: 26 Mar 2007 22:03:10 -0400

> commit b19cbe2a1695c09c74f83646c4b82b51123b3690 [BRIDGE]: Fix fdb RCU
> race
> 
> breaks sparc SMP build because atomic_add_unless is not exported.
> 
> This patch exports atomic_add_unless and atomic_cmpxchg.
> 
> Compile tested only.
> 
> Signed-off-by: Robert Reif <reif@earthlink.net>

Applied, thanks Robert.
