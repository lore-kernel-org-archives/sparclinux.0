From: Thomas Gleixner <tglx@linutronix.de>
Date: Tue, 03 Nov 2020 09:27:41 +0000
Subject: [patch V3 29/37] ARM: mm: Replace kmap_atomic_pfn()
Message-Id: <20201103095859.538827102@linutronix.de>
List-Id: <sparclinux.vger.kernel.org>
References: <20201103092712.714480842@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: Juri Lelli <juri.lelli@redhat.com>, linux-aio@kvack.org, Peter Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org, Ben Segall <bsegall@google.com>, Chris Mason <clm@fb.com>, Huang Rui <ray.huang@amd.com>, Paul Mackerras <paulus@samba.org>, Gerd Hoffmann <kraxel@redhat.com>, Daniel Bristot de Oliveira <bristot@redhat.com>, sparclinux@vger.kernel.org, Vincent Chen <deanbo422@gmail.com>, Christoph Hellwig <hch@lst.de>, Vincent Guittot <vincent.guittot@linaro.org>, Paul McKenney <paulmck@kernel.org>, Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Russell King <linux@armlinux.org.uk>, linux-csky@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, David Airlie <airlied@linux.ie>, VMware Graphics <linux-graphics-maintainer@vmware.com>, Mel Gorman <mgorman@suse.de>, nouveau@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>, linux-snps-arc@lists.infradead.org, Ben Skeggs <bskeggs@redhat.com>, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, intel-gfx@lists.freedesktop.org, Roland Scheidegger <sroland@vmware.com>, Josef Bacik <josef@toxicpanda.com>, Steven Rostedt <rostedt@goodmis.org>, Linus Torvalds <torvalds@linuxfoundation.org>, Alexander Viro <viro@zeniv.linux.org.uk>, spice-devel@lists.freedesktop.org, David Sterba <dsterba@suse.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, linux-arm-kernel@lists.infradead.org, Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Nick Hu <nickhu@andestech.com>, linux-mm@kvack.org, Vineet Gupta <vgupta@synopsys.com>, linux-mips@vger.kernel.org, Christian Koenig <christian.koenig@amd.com>, Benjamin LaHaise <bcrl@kvack.org>, linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>, linux-btrfs@vger.kernel.org, Greentime Hu <green.hu@gmail.com>

There is no requirement to disable pagefaults and preemption for these
cache management mappings.

Replace kmap_atomic_pfn() with kmap_local_pfn(). This allows to remove
kmap_atomic_pfn() in the next step.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
V3: New patch
---
 arch/arm/mm/cache-feroceon-l2.c |    6 +++---
 arch/arm/mm/cache-xsc3l2.c      |    4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

--- a/arch/arm/mm/cache-feroceon-l2.c
+++ b/arch/arm/mm/cache-feroceon-l2.c
@@ -49,9 +49,9 @@ static inline unsigned long l2_get_va(un
 	 * we simply install a virtual mapping for it only for the
 	 * TLB lookup to occur, hence no need to flush the untouched
 	 * memory mapping afterwards (note: a cache flush may happen
-	 * in some circumstances depending on the path taken in kunmap_atomic).
+	 * in some circumstances depending on the path taken in kunmap_local).
 	 */
-	void *vaddr = kmap_atomic_pfn(paddr >> PAGE_SHIFT);
+	void *vaddr = kmap_local_pfn(paddr >> PAGE_SHIFT);
 	return (unsigned long)vaddr + (paddr & ~PAGE_MASK);
 #else
 	return __phys_to_virt(paddr);
@@ -61,7 +61,7 @@ static inline unsigned long l2_get_va(un
 static inline void l2_put_va(unsigned long vaddr)
 {
 #ifdef CONFIG_HIGHMEM
-	kunmap_atomic((void *)vaddr);
+	kunmap_local((void *)vaddr);
 #endif
 }
 
--- a/arch/arm/mm/cache-xsc3l2.c
+++ b/arch/arm/mm/cache-xsc3l2.c
@@ -59,7 +59,7 @@ static inline void l2_unmap_va(unsigned
 {
 #ifdef CONFIG_HIGHMEM
 	if (va != -1)
-		kunmap_atomic((void *)va);
+		kunmap_local((void *)va);
 #endif
 }
 
@@ -75,7 +75,7 @@ static inline unsigned long l2_map_va(un
 		 * in place for it.
 		 */
 		l2_unmap_va(prev_va);
-		va = (unsigned long)kmap_atomic_pfn(pa >> PAGE_SHIFT);
+		va = (unsigned long)kmap_local_pfn(pa >> PAGE_SHIFT);
 	}
 	return va + (pa_offset >> (32 - PAGE_SHIFT));
 #else
