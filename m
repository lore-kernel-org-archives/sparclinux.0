From: Andreas Larsson <andreas@gaisler.com>
Date: Wed, 27 Jan 2021 15:03:00 +0000
Subject: sparc32: boot fails with > 256 MB memory after switch to NO_BOOTMEM
Message-Id: <5adb7c41-ad71-b904-6b73-35aef4dfcafe@gaisler.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sparc kernel list <sparclinux@vger.kernel.org>, linux-mm@kvack.org, Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Sam Ravnborg <sam@ravnborg.org>, Michal Hocko <mhocko@kernel.org>



Commit cca079ef8ac29a7c02192d2bad2ffe4c0c5ffdd0 makes sparc32 use
memblocks instead of the previous bootmem solution. Unfortunately, due
to this:

#define PAGE_OFFSET  0xf0000000
#define __va(x)	     ((void *)((unsigned long) (x) - phys_base + 
PAGE_OFFSET))
#define phys_to_virt __va

it makes physical addresses >= 0x10000000 past phys_base wrap around the
32-bit memory space when converted to virtual addresses, e.g. in
memblock_alloc_try_nid. Physical memory exactly 0x10000000 past
phys_base is returned as an unintended NULL pointer, leading to a panic
in my boot when percpu memory allocation fails due to it.

Unfortunately I have had 256 MB memory or less in a lot of my testing,
so this old one has slipped by me.

Does anyone has any ideas or pointers on how to resolve this?

Example follows where I have 512 MB memory at 0x40000000:

----->%>%>%>%-----
memblock_add: [0x40000000-0x5fffafff] bootmem_init+0x1f8/0x210
319MB HIGHMEM available.
memblock_reserve: [0x40000000-0x40e71fff] bootmem_init+0x178/0x210
memblock_add: [0x40000000-0x40e71fff] bootmem_init+0x188/0x210
memblock_alloc_try_nid: 5242880 bytes align=0x40000 nid=-1 
from=0x00000000 max_addr=0x00000000 srmmu_nocache_init+0x20/0x25c
memblock_reserve: [0x40e80000-0x4137ffff] 
memblock_alloc_range_nid+0xcc/0x178
memblock_alloc_try_nid: 2560 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 srmmu_nocache_init+0x94/0x25c
memblock_reserve: [0x40e72000-0x40e729ff] 
memblock_alloc_range_nid+0xcc/0x178
memblock_alloc_try_nid: 4096 bytes align=0x20 nid=-1 from=0x00000000 
max_addr=0x00000000 sparc_context_init+0x1c/0xe4
memblock_reserve: [0x40e72a00-0x40e739ff] 
memblock_alloc_range_nid+0xcc/0x178
Zone ranges:
   DMA      [mem 0x0000000040000000-0x000000004bffffff]
   Normal   empty
   HighMem  [mem 0x000000004c000000-0x000000005fffafff]
Movable zone start for each node
Early memory node ranges
   node   0: [mem 0x0000000040000000-0x000000005fffafff]
Initmem setup node 0 [mem 0x0000000040000000-0x000000005fffafff]
----->%>%>%>%-----

then much much later memblock_alloc_internal gets 0x50000000 from
memblock_alloc_range_nid and returns a NULL pointer as result of
phys_to_virt.

----->%>%>%>%-----
memblock_alloc_try_nid: 40960 bytes align=0x1000 nid=-1 from=0x4fffffff 
max_addr=0x00000000 pcpu_dfl_fc_alloc+0x28/0x40
memblock_reserve: [0x50000000-0x50009fff] 
memblock_alloc_range_nid+0xcc/0x178
memblock_free: [0x40e7e000-0x40e7efff] pcpu_free_alloc_info+0x1c/0x30
memblock_free: [0x40e7f000-0x40e7ffff] pcpu_embed_first_chunk+0x194/0x3b8
Kernel panic - not syncing: Failed to initialize percpu areas.
CPU: 0 PID: 0 Comm: swapper Not tainted 
5.11.0-rc3-00040-gbc4547251e1-dirty #28
----->%>%>%>%-----

Adding mem%6M to the command line solves the panic problem but makes
the extra memory not be available for normal allocation later on either.

The two first memblock_add calls (seen in the first first set of
outputs) with overlapping address ranges that is done in bootmem_init
also looks a bit worrying, but removing the second one does not affect
this problem.

-- 
Best regards,

Andreas Larsson
Cobham Gaisler
