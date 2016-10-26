From: David Miller <davem@davemloft.net>
Date: Wed, 26 Oct 2016 02:44:42 +0000
Subject: [PATCH] sparc64: Handle extremely large kernel TSB range flushes sanely.
Message-Id: <20161025.224442.1417439049113609110.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


If the number of pages we are flushing is more than twice the number
of entries in the TSB, just scan the TSB table for matches rather
than probing each and every page in the range.

Based upon a patch and report by James Clarke.

Signed-off-by: David S. Miller <davem@davemloft.net>
---

James this is the final version I pushed into the tree.

 arch/sparc/mm/tsb.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/sparc/mm/tsb.c b/arch/sparc/mm/tsb.c
index f2b7711..e20fbba 100644
--- a/arch/sparc/mm/tsb.c
+++ b/arch/sparc/mm/tsb.c
@@ -27,6 +27,20 @@ static inline int tag_compare(unsigned long tag, unsigned long vaddr)
 	return (tag = (vaddr >> 22));
 }
 
+static void flush_tsb_kernel_range_scan(unsigned long start, unsigned long end)
+{
+	unsigned long idx;
+
+	for (idx = 0; idx < KERNEL_TSB_NENTRIES; idx++) {
+		struct tsb *ent = &swapper_tsb[idx];
+		unsigned long match = idx << 13;
+
+		match |= (ent->tag << 22);
+		if (match >= start && match < end)
+			ent->tag = (1UL << TSB_TAG_INVALID_BIT);
+	}
+}
+
 /* TSB flushes need only occur on the processor initiating the address
  * space modification, not on each cpu the address space has run on.
  * Only the TLB flush needs that treatment.
@@ -36,6 +50,9 @@ void flush_tsb_kernel_range(unsigned long start, unsigned long end)
 {
 	unsigned long v;
 
+	if ((end - start) >> PAGE_SHIFT >= 2 * KERNEL_TSB_NENTRIES)
+		return flush_tsb_kernel_range_scan(start, end);
+
 	for (v = start; v < end; v += PAGE_SIZE) {
 		unsigned long hash = tsb_hash(v, PAGE_SHIFT,
 					      KERNEL_TSB_NENTRIES);
-- 
2.1.2.532.g19b5d50

