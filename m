From: David Miller <davem@davemloft.net>
Date: Tue, 13 Apr 2010 06:48:59 +0000
Subject: [PATCH 2/3] sparc64: Add kmemleak annotation to sun4v_build_virq()
Message-Id: <20100412.234859.267128985.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


The only reference we store to this memory is in the form of a
physical address, so kmemleak can't see it.

Add a kmemleak_not_leak() annotation.

It's probably useful to be able to look at a dump of these things
either via debugfs or similar, and thus we could at some point store
them in some kind of table and therefore get rid of this annotation.

Signed-off-by: David S. Miller <davem@davemloft.net>
---
 arch/sparc/kernel/irq_64.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index af5c76c..454ce3a 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -648,6 +648,14 @@ unsigned int sun4v_build_virq(u32 devhandle, unsigned int devino)
 	bucket = kzalloc(sizeof(struct ino_bucket), GFP_ATOMIC);
 	if (unlikely(!bucket))
 		return 0;
+
+	/* The only reference we store to the IRQ bucket is
+	 * by physical address which kmemleak can't see, tell
+	 * it that this object explicitly is not a leak and
+	 * should be scanned.
+	 */
+	kmemleak_not_leak(bucket);
+
 	__flush_dcache_range((unsigned long) bucket,
 			     ((unsigned long) bucket +
 			      sizeof(struct ino_bucket)));
-- 
1.7.0.4

