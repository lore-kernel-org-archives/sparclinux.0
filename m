From: Keith M Wesolowski <wesolows@foobazco.org>
Date: Thu, 01 Apr 2004 10:11:32 +0000
Subject: SPARC32 out of iommu/nocache
Message-Id: <20040401101131.GA23540@foobazco.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

I'm sure moving to first/next for allocation instead of straight next
helps with fragmentation.

However, what will help a lot more, especially with iommu, is to fix
this bug that prevents the allocator from ever reallocating anything
once it uses the area at the end of the map.

Please test.

Enjoy this one, folks. :-)

=== arch/sparc/lib/bitext.c 1.1 vs edited ==--- 1.1/arch/sparc/lib/bitext.c	Wed Apr 30 01:05:41 2003
+++ edited/arch/sparc/lib/bitext.c	Thu Apr  1 01:57:22 2004
@@ -60,8 +60,8 @@
 		}
 
 		if (offset + len > t->size) {
-			offset = 0;
 			count += t->size - offset;
+			offset = 0;
 			continue;
 		}
 


-- 
Keith M Wesolowski
