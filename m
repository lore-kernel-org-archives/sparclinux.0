From: David Miller <davem@davemloft.net>
Date: Sun, 01 Aug 2010 02:13:16 +0000
Subject: Re: question about arch/sparc/mm/iommu.c
Message-Id: <20100731.191316.242140768.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

From: Julia Lawall <julia@diku.dk>
Date: Sat, 31 Jul 2010 11:35:17 +0200 (CEST)

> The function sbus_iommu_init in arch/sparc/mm/iommu.c sometimes uses 
> GFP_ATOMIC and sometimes GFP_KERNEL.  Is there a reason for that?

None at all, they should both use GFP_KERNEL
