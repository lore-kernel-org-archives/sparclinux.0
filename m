From: David Miller <davem@davemloft.net>
Date: Wed, 17 Sep 2014 00:16:51 +0000
Subject: Re: [PATCH V2] sparc64: sun4v TLB error power off events
Message-Id: <20140916.201651.256110320447871912.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1410874007-11501-1-git-send-email-bpicco@meloft.net>
In-Reply-To: <1410874007-11501-1-git-send-email-bpicco@meloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: David Miller <davem@davemloft.net>
Date: Tue, 16 Sep 2014 17:47:25 -0400 (EDT)

> However I notice that 0x8 is set, which is a reserved bit.  That
> shouldn't happen, and could be what the hypervisor really doesn't
> like.

I just confirmed that this is why the hypervisor throws an error.  It
actually inspects all of 0xf in the PTE as a size field (rather than
just 0x7) via the TTE_SIZE() macro (in include/sun4v/mmu.h), which
uses TTE_SZ_MASK (also in include/sun4v/mmu.h), which is defined as
0xf.

It then makes sure that only CPU supported sizes are set in the PTE by
using the TTE_VALIDSIZEARRAY (f.e. in greatlakes/ontario/include/mmu.h
or greatlakes/huron/include/mmu.h) bitmask, which is different for
each platform hypervisor build.

Anyways, we have to figure out why 0x8 is set in the PTE that we try
to load into ITLB.  I haven't found any smoking guns yet.
