From: "David S. Miller" <davem@davemloft.net>
Date: Thu, 10 Feb 2005 08:23:41 +0000
Subject: Re: [2.6 PATCH] syntax errors by smp_{mb,rmb,wmb} on sparc32
Message-Id: <20050210002341.55663bd9.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.SOC.4.61.0502092331420.4099@math.ut.ee>
In-Reply-To: <Pine.SOC.4.61.0502092331420.4099@math.ut.ee>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

On Thu, 10 Feb 2005 09:19:28 +0200 (EET)
Meelis Roos <mroos@linux.ee> wrote:

> smp_mb(), smp_rmp() and smp_wmb() definitions have a trailing semicolon 
> and cause compilation errors in single statement context, like 
> if-then-else on line 358 in include/linux/skbuff.h. This patch removes 
> all three offending semicolons to make it compile.
> 
> Signed-off-by: Meelis Roos <mroos@linux.ee>

Sorry, I should have checked this out when I fixed the same exact
bug on sparc64.

I'll apply and push upstream, thanks.
