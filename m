From: David Miller <davem@davemloft.net>
Date: Thu, 17 Sep 2015 18:38:06 +0000
Subject: Re: [PATCH] iommu-common: only compile lib/iommu_common.c for Sparc64
Message-Id: <20150917.113806.1491126940106627619.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <1442479227-18320-1-git-send-email-andre.przywara@arm.com>
In-Reply-To: <1442479227-18320-1-git-send-email-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>
Date: Thu, 17 Sep 2015 09:40:27 +0100

> It seems the types used in this file are not really correct, but a
> fix isn't trivial.  So for the time being restrict this code to be
> compiled only when we actually need it.  Compile tested on Sparc,
> Sparc64, PPC64, ARM, ARM64, x86.

The whole reason this code gets compiled unconditionally is to
ensure it's portability so that other platforms can use it at
some point.

So I would ask that, instead of sweeping it under the rug, you
help work on fixing the problem you've uncovered.

Thanks.
