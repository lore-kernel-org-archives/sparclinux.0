From: David Miller <davem@davemloft.net>
Date: Tue, 04 Aug 2009 04:21:10 +0000
Subject: Re: [PATCH v2 0/8] sparc: use asm-generic/dma-mapping-common.h and
Message-Id: <20090803.212110.104970698.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090718110620.GC27287@elte.hu>
	<20090802.202135.63875488.davem@davemloft.net>
	<20090803055441.GA19428@elte.hu>
In-Reply-To: <20090803055441.GA19428@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@elte.hu
Cc: a.p.zijlstra@chello.nl, joerg.roedel@amd.com, fujita.tomonori@lab.ntt.co.jp, reif@earthlink.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, tony.luck@intel.com, akpm@linux-foundation.org

From: Ingo Molnar <mingo@elte.hu>
Date: Mon, 3 Aug 2009 07:54:41 +0200

> So that it can be freed. It's also placed next to the regular init 
> section to not create too many holes. It also keeps the 'kernel text 
> area' continuous and things like core_kernel_text() & co still work 
> fine.

Ok, I'll look into doing similar on sparc.
