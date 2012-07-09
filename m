From: Kirill Tkhai <tkhai@yandex.ru>
Date: Mon, 09 Jul 2012 14:22:11 +0000
Subject: [PATCH] sparc64: remove unused function straddles_64bit_va_hole()
Message-Id: <262801341843731@web29e.yandex.ru>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Nobody uses straddles_64bit_va_hole(). Remove it

Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
---
arch/sparc/kernel/sys_sparc_64.c |   17 -----------------
 1 files changed, 0 insertions(+), 17 deletions(-)
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index 3ee51f1..a47c262 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -66,23 +66,6 @@ static inline int invalid_64bit_range(unsigned long addr, unsigned long len)
 	return 0;
 }
 
-/* Does start,end straddle the VA-space hole?  */
-static inline int straddles_64bit_va_hole(unsigned long start, unsigned long end)
-{
-	unsigned long va_exclude_start, va_exclude_end;
-
-	va_exclude_start = VA_EXCLUDE_START;
-	va_exclude_end   = VA_EXCLUDE_END;
-
-	if (likely(start < va_exclude_start && end < va_exclude_start))
-		return 0;
-
-	if (likely(start >= va_exclude_end && end >= va_exclude_end))
-		return 0;
-
-	return 1;
-}
-
 /* These functions differ from the default implementations in
  * mm/mmap.c in two ways:
  *
