From: "David S. Miller" <davem@redhat.com>
Date: Tue, 17 Feb 2004 05:32:20 +0000
Subject: Re: Non-PCI build broken on sparc64, maybe others
Message-Id: <20040216213220.594052c7.davem@redhat.com>
List-Id: <sparclinux.vger.kernel.org>
References: <1076993402.21443.5.camel@ori.thedillows.org>
In-Reply-To: <1076993402.21443.5.camel@ori.thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: David Dillow <dave@thedillows.org>
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

On 16 Feb 2004 23:50:03 -0500
David Dillow <dave@thedillows.org> wrote:

> I believe this changeset in Linus's tree:
 ...
> breaks builds that do not include PCI support.

Indeed, thanks for catching this David.  This patch should fix it
and I'll be pushing this to Linus.

Thanks again.

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/16 21:28:29-08:00 davem@nuts.davemloft.net 
#   [SPARC64]: Fix non-PCI build, reported by David Dillow.
# 
# include/asm-sparc64/dma-mapping.h
#   2004/02/16 21:25:35-08:00 davem@nuts.davemloft.net +21 -1
#   [SPARC64]: Fix non-PCI build, reported by David Dillow.
# 
diff -Nru a/include/asm-sparc64/dma-mapping.h b/include/asm-sparc64/dma-mapping.h
--- a/include/asm-sparc64/dma-mapping.h	Mon Feb 16 21:28:51 2004
+++ b/include/asm-sparc64/dma-mapping.h	Mon Feb 16 21:28:51 2004
@@ -1,5 +1,25 @@
+#ifndef _ASM_SPARC64_DMA_MAPPING_H
+#define _ASM_SPARC64_DMA_MAPPING_H
+
 #include <linux/config.h>
 
 #ifdef CONFIG_PCI
 #include <asm-generic/dma-mapping.h>
-#endif
+#else
+
+static inline void *dma_alloc_coherent(struct device *dev, size_t size,
+			 dma_addr_t *dma_handle, int flag)
+{
+	BUG();
+	return NULL;
+}
+
+static inline void dma_free_coherent(struct device *dev, size_t size,
+		       void *vaddr, dma_addr_t dma_handle)
+{
+	BUG();
+}
+
+#endif /* PCI */
+
+#endif /* _ASM_SPARC64_DMA_MAPPING_H */
