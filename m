From: David Miller <davem@davemloft.net>
Date: Mon, 02 Aug 2010 23:04:33 +0000
Subject: Re: [PATCH] arch/sparc/mm: Use GFP_KERNEL
Message-Id: <20100802.160433.42797035.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <Pine.LNX.4.64.1008011109260.21594@ask.diku.dk>
In-Reply-To: <Pine.LNX.4.64.1008011109260.21594@ask.diku.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: julia@diku.dk
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

From: Julia Lawall <julia@diku.dk>
Date: Sun, 1 Aug 2010 11:09:44 +0200 (CEST)

> From: Julia Lawall <julia@diku.dk>
> 
> GFP_ATOMIC is not needed here, as evidenced by the other two uses of
> GFP_KERNEL in the same function.
> 
> The semantic match that finds this problem is as follows:
> (http://coccinelle.lip6.fr/)
 ...
> Signed-off-by: Julia Lawall <julia@diku.dk>

Applied, thanks Julia.
