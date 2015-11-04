From: David Miller <davem@davemloft.net>
Date: Wed, 04 Nov 2015 16:38:26 +0000
Subject: Re: [PATCH] sparc(64)/iommu: fixup iommu_tbl_range_alloc() types
Message-Id: <20151104.113826.1878743361979570759.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <55FC49B8.3020100@arm.com>
 <1442855829-11245-1-git-send-email-andre.przywara@arm.com>
 <561248BD.8080809@arm.com>
In-Reply-To: <561248BD.8080809@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Andre Przywara <andre.przywara@arm.com>
Date: Mon, 5 Oct 2015 10:54:05 +0100

> On 21/09/15 18:17, Andre Przywara wrote:
>> With DMA_ERROR_CODE now being dma_addr_t in most architectures, it
>> turned out that iommu_tbl_range_alloc (defined in lib/iommu-common.c)
>> is actually using a wrong return type.
>> This was easily fixed in a previous patch, but now the types in the
>> callers do not match anymore.
>> This patch fixes the obvious mismatches to allow sane comparisons with
>> the error return value.
>> Compile-tested on sparc, sparc64, x86, ARM, arm64.
> 
> Is there any news on that issue? Are you willing to take either of my
> patches to fix the compile warnings I see on ARM with LPAE enabled?

Sorry for the late response, I was travelling/conferencing and didn't
have a lot of time for issues like this.

I'm going to fix iommu_tbl_range_alloc()'s return value semantics.

The thing it is returning is a page table index, not a dma_addr_t
address.  So it is appropriate to create a special error indication
value for this, independant of DMA_ERROR_CODE.

I got this wrong during my initial review of these changes.
