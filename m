From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 19 Oct 2014 00:00:51 +0000
Subject: [PATCH 3/5] silo: ext2fs: bitops: delete non-sparc code
Message-Id: <1413676853-23942-4-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Delete non-SPARC code.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 include/ext2fs/bitops.h | 94 -------------------------------------------------
 1 file changed, 94 deletions(-)

diff --git a/include/ext2fs/bitops.h b/include/ext2fs/bitops.h
index 35f0b0b..d7d0ce0 100644
--- a/include/ext2fs/bitops.h
+++ b/include/ext2fs/bitops.h
@@ -83,98 +83,6 @@ extern void ext2fs_set_bitmap_padding(ext2fs_generic_bitmap map);
 #define _INLINE_ extern inline
 #endif
 
-#if ((defined __GNUC__) && (defined(__i386__) || defined(__i486__) || \
-			    defined(__i586__)))
-
-#define _EXT2_HAVE_ASM_BITOPS_
-	
-/*
- * These are done by inline assembly for speed reasons.....
- *
- * All bitoperations return 0 if the bit was cleared before the
- * operation and != 0 if it was not.  Bit 0 is the LSB of addr; bit 32
- * is the LSB of (addr+1).
- */
-
-/*
- * Some hacks to defeat gcc over-optimizations..
- */
-struct __dummy_h { unsigned long a[100]; };
-#define EXT2FS_ADDR (*(struct __dummy_h *) addr)
-#define EXT2FS_CONST_ADDR (*(const struct __dummy_h *) addr)	
-
-_INLINE_ int ext2fs_set_bit(int nr, void * addr)
-{
-	int oldbit;
-
-	__asm__ __volatile__("btsl %2,%1\n\tsbbl %0,%0"
-		:"=r" (oldbit),"=m" (EXT2FS_ADDR)
-		:"r" (nr));
-	return oldbit;
-}
-
-_INLINE_ int ext2fs_clear_bit(int nr, void * addr)
-{
-	int oldbit;
-
-	__asm__ __volatile__("btrl %2,%1\n\tsbbl %0,%0"
-		:"=r" (oldbit),"=m" (EXT2FS_ADDR)
-		:"r" (nr));
-	return oldbit;
-}
-
-_INLINE_ int ext2fs_test_bit(int nr, const void * addr)
-{
-	int oldbit;
-
-	__asm__ __volatile__("btl %2,%1\n\tsbbl %0,%0"
-		:"=r" (oldbit)
-		:"m" (EXT2FS_CONST_ADDR),"r" (nr));
-	return oldbit;
-}
-
-#undef EXT2FS_ADDR
-
-#endif	/* i386 */
-
-#ifdef __mc68000__
-
-#define _EXT2_HAVE_ASM_BITOPS_
-
-_INLINE_ int ext2fs_set_bit(int nr,void * addr)
-{
-	char retval;
-
-	__asm__ __volatile__ ("bfset %2@{%1:#1}; sne %0"
-	     : "=d" (retval) : "d" (nr^7), "a" (addr));
-
-	return retval;
-}
-
-_INLINE_ int ext2fs_clear_bit(int nr, void * addr)
-{
-	char retval;
-
-	__asm__ __volatile__ ("bfclr %2@{%1:#1}; sne %0"
-	     : "=d" (retval) : "d" (nr^7), "a" (addr));
-
-	return retval;
-}
-
-_INLINE_ int ext2fs_test_bit(int nr, const void * addr)
-{
-	char retval;
-
-	__asm__ __volatile__ ("bftst %2@{%1:#1}; sne %0"
-	     : "=d" (retval) : "d" (nr^7), "a" (addr));
-
-	return retval;
-}
-
-#endif /* __mc68000__ */
-
-#ifdef __sparc__
-
 #define _EXT2_HAVE_ASM_BITOPS_
 
 #ifndef EXT2_OLD_BITOPS
@@ -290,8 +198,6 @@ _INLINE_ int ext2fs_test_bit(int nr, const void *addr)
 }
 #endif
 
-#endif /* __sparc__ */
-
 #ifndef _EXT2_HAVE_ASM_SWAB
 
 _INLINE_ __u16 ext2fs_swab16(__u16 val)
-- 
2.1.2

