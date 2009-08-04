From: David Miller <davem@davemloft.net>
Date: Tue, 04 Aug 2009 04:22:32 +0000
Subject: Re: [PATCH v2 0/8] sparc: use asm-generic/dma-mapping-common.h and
Message-Id: <20090803.212232.259171216.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090721160538.GL25756@amd.com>
	<20090721.121519.239732131.davem@davemloft.net>
	<20090803055608.GB19428@elte.hu>
In-Reply-To: <20090803055608.GB19428@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@elte.hu
Cc: joerg.roedel@amd.com, fujita.tomonori@lab.ntt.co.jp, reif@earthlink.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, tony.luck@intel.com, akpm@linux-foundation.org

From: Ingo Molnar <mingo@elte.hu>
Date: Mon, 3 Aug 2009 07:56:08 +0200

> I'm wondering how sparc32 handles core_kernel_text() & friends? 
> 
> Those functions already assume that the bits between _stext and 
> _etext are all core kernel text and not generic pages freed back to 
> the buddy.

They won't work for such pages obviously.  Shows how many sparc32
users who trigger this case of actually freeing those pages and
using such facilities there actually are :-)
