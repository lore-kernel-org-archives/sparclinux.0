From: David Miller <davem@davemloft.net>
Date: Mon, 08 Oct 2018 05:58:05 +0000
Subject: Re: [PATCH] sparc32: fix fall-through annotation
Message-Id: <20181007.225805.1715245011770040083.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20181002101517.GA32181@embeddedor.com>
In-Reply-To: <20181002101517.GA32181@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gustavo@embeddedor.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 2 Oct 2018 12:15:17 +0200

> Replace "fallthru" with a proper "fall through" annotation.
> 
> This fix is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
