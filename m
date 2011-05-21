From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 21 May 2011 19:39:12 +0000
Subject: [PATCH 0/4] resources: Add lookup_resource()
Message-Id: <1306006756-32009-1-git-send-email-geert@linux-m68k.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-m68k@vger.kernel.org

The resource system is a nice existing subsystem to implement simple allocators
on top of.
Unfortunately, there's no official method to find an existing resource by a
resource start address, which is needed for a freeing function that just takes
the start address of the region to free.
        
Currently there are 3 users of the resource subsystem that implement this by
traversing the resource tree theirselves:
  - The Amiga Chip RAM allocator on m68k,
  - iomap()/iounmap() on sparc,
  - DMA allocation API on sparc.
They all lack locking of the resource tree, as resource_lock is static in
kernel/resource.c.

Hence this patchset adds lookup_resource() and converts the above users to it.

  [1/4] sparc: _sparc_find_resource() should check for exact matches
  [2/4] resources: Add lookup_resource()
  [3/4] m68k/amiga: Chip RAM - Use lookup_resource()
  [4/4] sparc: iounmap() and *_free_coherent() - Use lookup_resource()

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
