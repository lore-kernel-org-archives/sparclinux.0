From: David Miller <davem@davemloft.net>
Date: Tue, 21 Jul 2009 19:15:19 +0000
Subject: Re: [PATCH v2 0/8] sparc: use asm-generic/dma-mapping-common.h and
Message-Id: <20090721.121519.239732131.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20090714092354.GL19087@amd.com>
	<20090714.131224.205307048.davem@davemloft.net>
	<20090721160538.GL25756@amd.com>
In-Reply-To: <20090721160538.GL25756@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: joerg.roedel@amd.com
Cc: fujita.tomonori@lab.ntt.co.jp, reif@earthlink.net, mingo@elte.hu, sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, tony.luck@intel.com, akpm@linux-foundation.org

From: Joerg Roedel <joerg.roedel@amd.com>
Date: Tue, 21 Jul 2009 18:05:38 +0200

> Hmm these checks sound specific and hard to maintain. I think its best
> to give architectures the option whether to enable this check or not.

No matter how the arch works in this area, there should be some
kind of sanity check.

So, it probably makes sense to allow an arch to override the
validation function rather than turn the test completely off.
