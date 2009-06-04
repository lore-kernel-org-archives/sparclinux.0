From: David Miller <davem@davemloft.net>
Date: Thu, 04 Jun 2009 08:45:31 +0000
Subject: Re: [PATCH 0/4] sparc: unify dma-mapping_32.h and dma-mapping_64.h
Message-Id: <20090604.014531.34506854.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1242354191-6232-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
	<4A1F58E8.3090307@earthlink.net>
In-Reply-To: <4A1F58E8.3090307@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: reif@earthlink.net
Cc: fujita.tomonori@lab.ntt.co.jp, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Robert Reif <reif@earthlink.net>
Date: Thu, 28 May 2009 23:39:20 -0400

> FUJITA Tomonori wrote:
>> This patchset unifies dma-mapping_32.h and dma-mapping_64.h, that is,
>> it uses dma-mapping.h instead and removes dma-mapping_32.h and
>> dma-mapping_64.h.
>>   
> I just boot tested this patch set on sparc32 and it works fine.

All applied and I added a tested-by: for Robert to the commits.

Thanks!
