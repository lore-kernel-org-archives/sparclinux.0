From: Andre Przywara <andre.przywara@arm.com>
Date: Fri, 18 Sep 2015 17:28:24 +0000
Subject: Re: [PATCH] iommu-common: only compile lib/iommu_common.c for Sparc64
Message-Id: <55FC49B8.3020100@arm.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1442479227-18320-1-git-send-email-andre.przywara@arm.com>
 <20150917.113806.1491126940106627619.davem@davemloft.net>
 <55FBD36C.5070301@arm.com>
 <20150918.100952.975850165461332930.davem@davemloft.net>
In-Reply-To: <20150918.100952.975850165461332930.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi David,

On 18/09/15 18:09, David Miller wrote:
> From: Andre Przywara <andre.przywara@arm.com>
> Date: Fri, 18 Sep 2015 10:03:40 +0100
> 
>> Or do you know of a simpler way to fixing it properly which could make
>> it still into 4.3?
> 
> All I worry about is that if you take it out of the build, doing
> the proper fix will suddenly become very low priority and be
> forgotten about completely.
> 
> Whereas if it actually blocks the build for someone, it's a high
> priority issue to address.

I see. What about if I provide the two patches at the same time? An easy
fix for 4.3 and the proper fix for 4.4? You can then even choose to take
the proper fix for 4.3 if it's reasonably low risk.
I will try sending something on Monday.

Cheers,
Andre.
