From: Thomas Gleixner <tglx@linutronix.de>
Date: Thu, 29 Oct 2020 22:18:24 +0000
Subject: [patch V2 18/18] io-mapping: Provide iomap_local variant
Message-Id: <20201029222652.396632514@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20201029221806.189523375@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arch@vger.kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>, Peter Zijlstra <peterz@infradead.org>, Paul McKenney <paulmck@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Ard Biesheuvel <ardb@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, Christoph Hellwig <hch@lst.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Daniel Bristot de Oliveira <bristot@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>, linux-snps-arc@lists.infradead.org, Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org, Guo Ren <guoren@kernel.org>, linux-csky@vger.kernel.org, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>, Vincent Chen <deanbo422@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org, Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, linux-xtensa@linux-xtensa.org

Similar to kmap local provide a iomap local variant which only disables
migration, but neither disables pagefaults nor preemption.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Split out from the large combo patch and add the !IOMAP_ATOMIC variants
---
 include/linux/io-mapping.h |   34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -83,6 +83,23 @@ io_mapping_unmap_atomic(void __iomem *va
 }
 
 static inline void __iomem *
+io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
+{
+	resource_size_t phys_addr;
+
+	BUG_ON(offset >= mapping->size);
+	phys_addr = mapping->base + offset;
+	migrate_disable();
+	return __iomap_local_pfn_prot(PHYS_PFN(phys_addr), mapping->prot);
+}
+
+static inline void io_mapping_unmap_local(void __iomem *vaddr)
+{
+	kunmap_local_indexed((void __force *)vaddr);
+	migrate_enable();
+}
+
+static inline void __iomem *
 io_mapping_map_wc(struct io_mapping *mapping,
 		  unsigned long offset,
 		  unsigned long size)
@@ -101,7 +118,7 @@ io_mapping_unmap(void __iomem *vaddr)
 	iounmap(vaddr);
 }
 
-#else
+#else  /* HAVE_ATOMIC_IOMAP */
 
 #include <linux/uaccess.h>
 
@@ -166,7 +183,20 @@ io_mapping_unmap_atomic(void __iomem *va
 	preempt_enable();
 }
 
-#endif /* HAVE_ATOMIC_IOMAP */
+static inline void __iomem *
+io_mapping_map_local_wc(struct io_mapping *mapping, unsigned long offset)
+{
+	migrate_disable();
+	return io_mapping_map_wc(mapping, offset, PAGE_SIZE);
+}
+
+static inline void io_mapping_unmap_local(void __iomem *vaddr)
+{
+	io_mapping_unmap(vaddr);
+	migrate_enable();
+}
+
+#endif /* !HAVE_ATOMIC_IOMAP */
 
 static inline struct io_mapping *
 io_mapping_create_wc(resource_size_t base,
