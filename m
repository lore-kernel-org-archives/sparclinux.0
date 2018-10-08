From: David Miller <davem@davemloft.net>
Date: Mon, 08 Oct 2018 05:58:10 +0000
Subject: Re: [PATCH] sparc64: fix fall-through annotation
Message-Id: <20181007.225810.2302554943604046616.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20181002101954.GA645@embeddedor.com>
In-Reply-To: <20181002101954.GA645@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gustavo@embeddedor.com
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 2 Oct 2018 12:19:54 +0200

> Replace "fallthru" with a proper "fall through" annotation.
> 
> This fix is part of the ongoing efforts to enabling
> -Wimplicit-fallthrough
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
