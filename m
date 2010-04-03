From: Ben Hutchings <ben@decadent.org.uk>
Date: Sat, 03 Apr 2010 20:41:20 +0000
Subject: [PATCH] sparc64: Fix array size reported by vmemmap_populate()
Message-Id: <1270327280.12516.368.camel@localhost>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

vmemmap_populate() attempts to report the used index and total size of
vmemmap_table, but it wrongly shifts the total size so that it is
always shown as 0.

Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/sparc/mm/init_64.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index aaebc48..b2831dc 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2117,7 +2117,7 @@ int __meminit vmemmap_populate(struct page *start, unsigned long nr, int node)
 			       "node=%d entry=%lu/%lu\n", start, block, nr,
 			       node,
 			       addr >> VMEMMAP_CHUNK_SHIFT,
-			       VMEMMAP_SIZE >> VMEMMAP_CHUNK_SHIFT);
+			       VMEMMAP_SIZE);
 		}
 	}
 	return 0;
-- 
1.7.0.3


