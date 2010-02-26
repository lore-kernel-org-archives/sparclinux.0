From: David Miller <davem@davemloft.net>
Date: Fri, 26 Feb 2010 12:35:36 +0000
Subject: Re: [PATCH] sparc: use asm-generic/scatterlist.h
Message-Id: <20100226.043536.63730567.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20100226093941C.fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <20100226093941C.fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fujita.tomonori@lab.ntt.co.jp
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Fri, 26 Feb 2010 09:43:51 +0900

> sparc's scatterlist structure is identical to the generic one.
> 
> Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>

Applied, thank you.

BTW, the conditional sg_dma_len() definition cpp games done
in asm-generic/scatterlist.h might be superfluous these days.
