From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Mon, 01 Mar 2010 06:05:48 +0000
Subject: Re: [PATCH] sparc: use asm-generic/scatterlist.h
Message-Id: <20100301150532R.fujita.tomonori@lab.ntt.co.jp>
List-Id: <sparclinux.vger.kernel.org>
References: <20100226093941C.fujita.tomonori@lab.ntt.co.jp>
	<20100226.043536.63730567.davem@davemloft.net>
In-Reply-To: <20100226.043536.63730567.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net
Cc: fujita.tomonori@lab.ntt.co.jp, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On Fri, 26 Feb 2010 04:35:36 -0800 (PST)
David Miller <davem@davemloft.net> wrote:

> From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> Date: Fri, 26 Feb 2010 09:43:51 +0900
> 
> > sparc's scatterlist structure is identical to the generic one.
> > 
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> 
> Applied, thank you.

Thanks,

> BTW, the conditional sg_dma_len() definition cpp games done
> in asm-generic/scatterlist.h might be superfluous these days.

You are referring to the following code (I guess that this hack came
from x86)?

#if __BITS_PER_LONG = 64
#define sg_dma_len(sg)		((sg)->dma_length)
#else
#define sg_dma_len(sg)		((sg)->length)
#endif /* 64 bit */

if so, seems that you are right. we could simply have:

#define sg_dma_len(sg)		((sg)->dma_length)

The current users of asm-generic/scatterlist.h are microblaze, s390,
score, sh, and x86.

The first three users don't support DMA so sg_dma_len doesn't matter
for them.

sh and x86_32 use sg->length, x86_64 uses sg->dma_length. However, sh
and x86_32 sets dma_length in dma_map_sg() so they can use
sg->dma_length.

I'll clean up this in the next merge window.
