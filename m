From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 19 Oct 2014 00:00:49 +0000
Subject: [PATCH 1/5] silo: ext2fs: delete INCLUDE_INLINE_FUNCS ifdeffery
Message-Id: <1413676853-23942-2-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Delete INCLUDE_INLINE_FUNCS ifdeffery.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 include/ext2fs/bitops.h | 6 +-----
 include/ext2fs/ext2fs.h | 6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/ext2fs/bitops.h b/include/ext2fs/bitops.h
index 7e049d1..f8ce0fc 100644
--- a/include/ext2fs/bitops.h
+++ b/include/ext2fs/bitops.h
@@ -94,16 +94,12 @@ extern void ext2fs_set_bitmap_padding(ext2fs_generic_bitmap map);
 #endif
 #endif /* NO_INLINE_FUNCS */
 
-#if (defined(INCLUDE_INLINE_FUNCS) || !defined(NO_INLINE_FUNCS))
-#ifdef INCLUDE_INLINE_FUNCS
-#define _INLINE_ extern
-#else
+#if !defined(NO_INLINE_FUNCS)
 #ifdef __GNUC__
 #define _INLINE_ extern __inline__
 #else				/* For Watcom C */
 #define _INLINE_ extern inline
 #endif
-#endif
 
 #if ((defined __GNUC__) && (defined(__i386__) || defined(__i486__) || \
 			    defined(__i586__)))
diff --git a/include/ext2fs/ext2fs.h b/include/ext2fs/ext2fs.h
index 17481a0..b88e3a4 100644
--- a/include/ext2fs/ext2fs.h
+++ b/include/ext2fs/ext2fs.h
@@ -877,16 +877,12 @@ extern blk_t ext2fs_inode_data_blocks(ext2_filsys fs,
  * If NO_INLINE_FUNCS is defined, then we won't try to do inline
  * functions at all!
  */
-#if (defined(INCLUDE_INLINE_FUNCS) || !defined(NO_INLINE_FUNCS))
-#ifdef INCLUDE_INLINE_FUNCS
-#define _INLINE_ extern
-#else
+#if !defined(NO_INLINE_FUNCS)
 #ifdef __GNUC__
 #define _INLINE_ extern __inline__
 #else				/* For Watcom C */
 #define _INLINE_ extern inline
 #endif
-#endif
 
 #ifndef EXT2_CUSTOM_MEMORY_ROUTINES
 /*
-- 
2.1.2

