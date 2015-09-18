From: Andre Przywara <andre.przywara@arm.com>
Date: Fri, 18 Sep 2015 09:03:40 +0000
Subject: Re: [PATCH] iommu-common: only compile lib/iommu_common.c for Sparc64
Message-Id: <55FBD36C.5070301@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1442479227-18320-1-git-send-email-andre.przywara@arm.com>
 <20150917.113806.1491126940106627619.davem@davemloft.net>
In-Reply-To: <20150917.113806.1491126940106627619.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi David,

On 17/09/15 19:38, David Miller wrote:
> From: Andre Przywara <andre.przywara@arm.com>
> Date: Thu, 17 Sep 2015 09:40:27 +0100
> 
>> It seems the types used in this file are not really correct, but a
>> fix isn't trivial.  So for the time being restrict this code to be
>> compiled only when we actually need it.  Compile tested on Sparc,
>> Sparc64, PPC64, ARM, ARM64, x86.
> 
> The whole reason this code gets compiled unconditionally is to
> ensure it's portability so that other platforms can use it at
> some point.
> 
> So I would ask that, instead of sweeping it under the rug, you
> help work on fixing the problem you've uncovered.

OK, I understand that. To be honest I tried that: changing the return
type of iommu_tbl_range_alloc() to dma_addr_t and taking it from there.
This resulted in quite some changes in the callers in arch/sparc, which
scared me a bit because I don't have a clue about the Sparc IOMMU and I
cannot test it seriously.
Also I deemed it not appropriate still for the 4.3 release, which was
what my patch was aiming at (because it is a 4.3 merging window regression).

So I have a simpler version of the proper fix mentioned above, which
simply changes the return type of iommu_tbl_range_alloc() and pushes
this warning away, though this still isn't right and just papers over
the issue, I think. (Sending that out in a minute in a separate mail for
reference).

So what is your hunch on that? Shall we go with a dual approach: Fixing
the compiler warning with either the simple return type change or the
Kconfig approach now for 4.3 and revert that after the actual culprit
gets fixed later?

Or do you know of a simpler way to fixing it properly which could make
it still into 4.3?

Cheers,
Andre.
