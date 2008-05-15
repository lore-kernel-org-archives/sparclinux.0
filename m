From: David Miller <davem@davemloft.net>
Date: Thu, 15 May 2008 06:11:11 +0000
Subject: Re: [BUG] 2.6.26-rc1 lost half the RAM on UltraSPARC 5
Message-Id: <20080514.231111.107604885.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20080512.153628.193699676.davem@davemloft.net>
	<20080512.153948.193688062.davem@davemloft.net>
	<18473.60551.911448.98269@alkaid.it.uu.se>
In-Reply-To: <18473.60551.911448.98269@alkaid.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mikpe@it.uu.se
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Tue, 13 May 2008 21:31:19 +0200

Ok, Mikael, I think I figured out this bug:

> Found ramdisk at physical address 0x10800000, size 3683665
> lmb_dump_all:
>     memory.cnt		  = 0x4
>     memory.size		  = 0xff40000
>     memory.region[0x0].base       = 0x0
> 		      .size     = 0x8000000
>     memory.region[0x1].base       = 0x10000000
> 		      .size     = 0x7efe000
>     memory.region[0x2].base       = 0x17f00000
> 		      .size     = 0x3a000
>     memory.region[0x3].base       = 0x17f3e000
> 		      .size     = 0x8000
>     reserved.cnt	  = 0x2
>     reserved.size	  = 0x0
>     reserved.region[0x0].base       = 0x10000000
> 		      .size     = 0x35bf60
>     reserved.region[0x1].base       = 0x10800000
> 		      .size     = 0x10b83551

From the very beginning your higher RAM is gone.
It's correct that some memory should be reserved,
for the ramdisk, but not 128MB :-)

The ramdisk is just under 4MB in size, so something is fishy here.

And indeed, I'm reserving the wrong length.  Please try this
patch:

sparc64: Fix lmb_reserve() args in find_ramdisk().

This fixes the missing ram regression reported by
Mikael Pettersson <mikpe@it.uu.se>, much thanks for
all of this help in diagnosing this.

The second argument to lmb_reserve() is a size,
not an end address bounds.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc64/mm/init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc64/mm/init.c b/arch/sparc64/mm/init.c
index a9828d7..3c7b947 100644
--- a/arch/sparc64/mm/init.c
+++ b/arch/sparc64/mm/init.c
@@ -768,7 +768,7 @@ static void __init find_ramdisk(unsigned long phys_base)
 		initrd_start = ramdisk_image;
 		initrd_end = ramdisk_image + sparc_ramdisk_size;
 
-		lmb_reserve(initrd_start, initrd_end);
+		lmb_reserve(initrd_start, sparc_ramdisk_size);
 
 		initrd_start += PAGE_OFFSET;
 		initrd_end += PAGE_OFFSET;
-- 
1.5.5.1.57.g5909c

