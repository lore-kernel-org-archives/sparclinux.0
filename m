From: Robert Reif <reif@earthlink.net>
Date: Fri, 29 May 2009 03:39:20 +0000
Subject: Re: [PATCH 0/4] sparc: unify dma-mapping_32.h and dma-mapping_64.h
Message-Id: <4A1F58E8.3090307@earthlink.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1242354191-6232-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1242354191-6232-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Cc: davem@davemloft.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

FUJITA Tomonori wrote:
> This patchset unifies dma-mapping_32.h and dma-mapping_64.h, that is,
> it uses dma-mapping.h instead and removes dma-mapping_32.h and
> dma-mapping_64.h.
>   
I just boot tested this patch set on sparc32 and it works fine.
