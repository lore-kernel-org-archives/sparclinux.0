From: Sam Ravnborg <sam@ravnborg.org>
Date: Thu, 24 Apr 2014 18:13:13 +0000
Subject: Re: what is srmmu_inherit_prom_mappings for?
Message-Id: <20140424181313.GA11126@ravnborg.org>
List-Id: <sparclinux.vger.kernel.org>
References: <1A0A429E720CFD4A9673A435389F16362B9DEAA2@SMTP4.etri.info>
In-Reply-To: <1A0A429E720CFD4A9673A435389F16362B9DEAA2@SMTP4.etri.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi Chan.
> 
> Oh I found out what this is. It was checking if the 'start' address is in a big chunk. 
> from SRMMU_REAL_PMD_SIZE (2^18) to SRMMU_PGDIR_SIZE(2^24).
> The comparison result in equal only for the first page of a big chunk.

Inspired by your question I took a closer look at this method.
I ended up adding the following comments.
Does they match your understanding?

Note - this is on top of latest mainline.
I assume you are looking at some older code-base judging from the snippets
you provided earlier.

	Sam

diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index cfbe53c..a0e3c74 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -716,7 +716,11 @@ static void __init srmmu_allocate_ptable_skeleton(unsigned long start,
 	}
 }
 
-/* These flush types are not available on all chips... */
+/* Probe the MMU for an entry in one of the page tables.
+ * If the virtual address does not result in a match then return 0.
+ * 
+ * These flush types are not available on all chips...
+ */
 static inline unsigned long srmmu_probe(unsigned long vaddr)
 {
 	unsigned long retval;
@@ -764,6 +768,11 @@ static void __init srmmu_inherit_prom_mappings(unsigned long start,
 		what = 0;
 		addr = start - PAGE_SIZE;
 
+		/* Find out which level this entry belongs to.
+		 * If the probe of the last page return the same entry
+		 * as the first page - then we know the type.
+		 * Try PGDIR last as this is the largest entries.
+		 */
 		if (!(start & ~(SRMMU_REAL_PMD_MASK))) {
 			if (srmmu_probe(addr + SRMMU_REAL_PMD_SIZE) = probed)
 				what = 1;
