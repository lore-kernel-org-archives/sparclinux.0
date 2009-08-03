From: Ingo Molnar <mingo@elte.hu>
Date: Mon, 03 Aug 2009 05:56:08 +0000
Subject: Re: [PATCH v2 0/8] sparc: use asm-generic/dma-mapping-common.h and
Message-Id: <20090803055608.GB19428@elte.hu>
List-Id: <sparclinux.vger.kernel.org>
References: <20090714092354.GL19087@amd.com> <20090714.131224.205307048.davem@davemloft.net> <20090721160538.GL25756@amd.com> <20090721.121519.239732131.davem@davemloft.net>
In-Reply-To: <20090721.121519.239732131.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Miller <davem@davemloft.net>
Cc: joerg.roedel@amd.com, fujita.tomonori@lab.ntt.co.jp, reif@earthlink.net, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, tony.luck@intel.com, akpm@linux-foundation.org


* David Miller <davem@davemloft.net> wrote:

> From: Joerg Roedel <joerg.roedel@amd.com>
> Date: Tue, 21 Jul 2009 18:05:38 +0200
> 
> > Hmm these checks sound specific and hard to maintain. I think 
> > its best to give architectures the option whether to enable this 
> > check or not.
> 
> No matter how the arch works in this area, there should be some 
> kind of sanity check.
> 
> So, it probably makes sense to allow an arch to override the 
> validation function rather than turn the test completely off.

I'm wondering how sparc32 handles core_kernel_text() & friends? 

Those functions already assume that the bits between _stext and 
_etext are all core kernel text and not generic pages freed back to 
the buddy.

	Ingo
