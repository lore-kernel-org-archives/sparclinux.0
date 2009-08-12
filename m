From: David Miller <davem@davemloft.net>
Date: Wed, 12 Aug 2009 23:34:27 +0000
Subject: Re: [PATCH resend 0/8] sparc: use asm-generic/dma-mapping-common.h
Message-Id: <20090812.163427.161326946.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1249872797-1314-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
In-Reply-To: <1249872797-1314-1-git-send-email-fujita.tomonori@lab.ntt.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: fujita.tomonori@lab.ntt.co.jp
Cc: mingo@elte.hu, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, tony.luck@intel.com, fenghua.yu@intel.com

From: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
Date: Mon, 10 Aug 2009 11:53:09 +0900

> This is the repost of the patchset (as Ingo asked me offline) :
> 
> http://lkml.org/lkml/2009/7/13/20
> 
> There is no functional change. I just added David's ack to #3-8
> patches and Robert's Tested-by to #8 patch.
> 
> I confirmed that it can be applied cleanly to mainline, -next, and
> -tip trees.
> 
> The git tree is also available:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/tomo/linux-2.6-misc.git sparc

I just made a quick build test on sparc32 and sparc64, as well as
a non-debug execution test on sparc64 and it all looks fine.

Thanks for doing this work!

I assume Ingo or someone else is going to merge this stuff?
