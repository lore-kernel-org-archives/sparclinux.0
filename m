From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 03 Nov 2020 09:27:38 +0000
Subject: [patch V3 26/37] io-mapping: Provide iomap_local variant
Message-Id: <20201103095859.228149242@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20201103092712.714480842@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-aio@kvack.org, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Ben Segall <bsegall@google.com>, Chris Mason <clm@fb.com>, Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Christoph Hellwig <hch@lst.de>, Vincent Guittot <vincent.guittot@linaro.org>, Paul McKenney <paulmck@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, David Airlie <airlied@linux.ie>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Mel Gorman <mgorman@suse.de>, nouveau@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, linux-snps-arc@lists.infradead.org, Ben Skeggs <bskeggs@redhat.com>, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org, Roland Scheidegger <sroland@vmware.com>, Josef Bacik <josef@toxicpanda.com>, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, spice-devel@lists.freedesktop.org, David Sterba <dsterba@suse.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, linux-mm@kvack.org, Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, Benjamin LaHaise <bcrl@kvack.org>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, linux-btrfs@vger.kernel.org, Greentime Hu <green.hu@gmail.com>

Similar to kmap local provide a iomap local variant which only disables
migration, but neither disables pagefaults nor preemption.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Restrict migrate disable to the 32bit mapping case and update documentation.

V2: Split out from the large combo patch and add the !IOMAP_ATOMIC variants
---
 Documentation/driver-api/io-mapping.rst |   76 +++++++++++++++++++-------------
 include/linux/io-mapping.h              |   30 +++++++++++-
 2 files changed, 74 insertions(+), 32 deletions(-)

--- a/Documentation/driver-api/io-mapping.rst
+++ b/Documentation/driver-api/io-mapping.rst
@@ -20,55 +20,71 @@ as it would consume too much of the kern
 mappable, while 'size' indicates how large a mapping region to
 enable. Both are in bytes.
 
-This _wc variant provides a mapping which may only be used
-with the io_mapping_map_atomic_wc or io_mapping_map_wc.
+This _wc variant provides a mapping which may only be used with
+io_mapping_map_atomic_wc(), io_mapping_map_local_wc() or
+io_mapping_map_wc().
+
+With this mapping object, individual pages can be mapped either temporarily
+or long term, depending on the requirements. Of course, temporary maps are
+more efficient. They come in two flavours::
 
-With this mapping object, individual pages can be mapped either atomically
-or not, depending on the necessary scheduling environment. Of course, atomic
-maps are more efficient::
+	void *io_mapping_map_local_wc(struct io_mapping *mapping,
+				      unsigned long offset)
 
 	void *io_mapping_map_atomic_wc(struct io_mapping *mapping,
 				       unsigned long offset)
 
-'offset' is the offset within the defined mapping region.
-Accessing addresses beyond the region specified in the
-creation function yields undefined results. Using an offset
-which is not page aligned yields an undefined result. The
-return value points to a single page in CPU address space.
-
-This _wc variant returns a write-combining map to the
-page and may only be used with mappings created by
-io_mapping_create_wc
+'offset' is the offset within the defined mapping region.  Accessing
+addresses beyond the region specified in the creation function yields
+undefined results. Using an offset which is not page aligned yields an
+undefined result. The return value points to a single page in CPU address
+space.
 
-Note that the task may not sleep while holding this page
-mapped.
+This _wc variant returns a write-combining map to the page and may only be
+used with mappings created by io_mapping_create_wc()
 
-::
+Temporary mappings are only valid in the context of the caller. The mapping
+is not guaranteed to be globaly visible.
 
-	void io_mapping_unmap_atomic(void *vaddr)
+io_mapping_map_local_wc() has a side effect on X86 32bit as it disables
+migration to make the mapping code work. No caller can rely on this side
+effect.
+
+io_mapping_map_atomic_wc() has the side effect of disabling preemption and
+pagefaults. Don't use in new code. Use io_mapping_map_local_wc() instead.
 
-'vaddr' must be the value returned by the last
-io_mapping_map_atomic_wc call. This unmaps the specified
-page and allows the task to sleep once again.
+Nested mappings need to be undone in reverse order because the mapping
+code uses a stack for keeping track of them::
 
-If you need to sleep while holding the lock, you can use the non-atomic
-variant, although they may be significantly slower.
+ addr1 = io_mapping_map_local_wc(map1, offset1);
+ addr2 = io_mapping_map_local_wc(map2, offset2);
+ ...
+ io_mapping_unmap_local(addr2);
+ io_mapping_unmap_local(addr1);
 
-::
+The mappings are released with::
+
+	void io_mapping_unmap_local(void *vaddr)
+	void io_mapping_unmap_atomic(void *vaddr)
+
+'vaddr' must be the value returned by the last io_mapping_map_local_wc() or
+io_mapping_map_atomic_wc() call. This unmaps the specified mapping and
+undoes the side effects of the mapping functions.
+
+If you need to sleep while holding a mapping, you can use the regular
+variant, although this may be significantly slower::
 
 	void *io_mapping_map_wc(struct io_mapping *mapping,
 				unsigned long offset)
 
-This works like io_mapping_map_atomic_wc except it allows
-the task to sleep while holding the page mapped.
-
+This works like io_mapping_map_atomic/local_wc() except it has no side
+effects and the pointer is globaly visible.
 
-::
+The mappings are released with::
 
 	void io_mapping_unmap(void *vaddr)
 
-This works like io_mapping_unmap_atomic, except it is used
-for pages mapped with io_mapping_map_wc.
+Use for pages mapped with io_mapping_map_wc().
 
 At driver close time, the io_mapping object must be freed::
 
--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -83,6 +83,21 @@ io_mapping_unmap_atomic(void __iomem *va
 }
 
 static inline void __iomem *
+io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
+{
+	resource_size_t phys_addr;
+
+	BUG_ON(offset >= mapping->size);
+	phys_addr = mapping->base + offset;
+	return __iomap_local_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
+}
+
+static inline void io_mapping_unmap_local(void __iomem *vaddr)
+{
+	kunmap_local_indexed((void __force *)vaddr);
+}
+
+static inline void __iomem *
 io_mapping_map_wc(struct io_mapping *mapping,
 		  unsigned long offset,
 		  unsigned long size)
@@ -101,7 +116,7 @@ io_mapping_unmap(void __iomem *vaddr)
 	iounmap(vaddr);
 }
 
-#else
+#else  /* HAVE_ATOMIC_IOMAP */
 
 #include <linux/uaccess.h>
 
@@ -166,7 +181,18 @@ io_mapping_unmap_atomic(void __iomem *va
 	preempt_enable();
 }
 
-#endif /* HAVE_ATOMIC_IOMAP */
+static inline void __iomem *
+io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
+{
+	return io_mapping_map_wc(mapping, offset, PAGE_SIZE);
+}
+
+static inline void io_mapping_unmap_local(void __iomem *vaddr)
+{
+	io_mapping_unmap(vaddr);
+}
+
+#endif /* !HAVE_ATOMIC_IOMAP */
 
 static inline struct io_mapping *
 io_mapping_create_wc(resource_size_t base,
