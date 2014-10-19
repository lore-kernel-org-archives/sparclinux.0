From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 19 Oct 2014 00:00:50 +0000
Subject: [PATCH 2/5] silo: ext2fs: delete NO_INLINE_FUNCS ifdeffery
Message-Id: <1413676853-23942-3-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Delete NO_INLINE_FUNCS ifdeffery.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 include/ext2fs/bitops.h | 20 --------------------
 include/ext2fs/ext2fs.h | 15 ---------------
 2 files changed, 35 deletions(-)

diff --git a/include/ext2fs/bitops.h b/include/ext2fs/bitops.h
index f8ce0fc..35f0b0b 100644
--- a/include/ext2fs/bitops.h
+++ b/include/ext2fs/bitops.h
@@ -77,24 +77,6 @@ extern int ext2fs_fast_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
 					       blk_t block, int num);
 extern void ext2fs_set_bitmap_padding(ext2fs_generic_bitmap map);
 
-/*
- * The inline routines themselves...
- * 
- * If NO_INLINE_FUNCS is defined, then we won't try to do inline
- * functions at all; they will be included as normal functions in
- * inline.c
- */
-#ifdef NO_INLINE_FUNCS
-#if (defined(__GNUC__) && (defined(__i386__) || defined(__i486__) || \
-			   defined(__i586__) || defined(__mc68000__) || \
-			   defined(__sparc__)))
-	/* This prevents bitops.c from trying to include the C */
-	/* function version of these functions */
-#define _EXT2_HAVE_ASM_BITOPS_
-#endif
-#endif /* NO_INLINE_FUNCS */
-
-#if !defined(NO_INLINE_FUNCS)
 #ifdef __GNUC__
 #define _INLINE_ extern __inline__
 #else				/* For Watcom C */
@@ -600,5 +582,3 @@ _INLINE_ void ext2fs_fast_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
 }
 
 #undef _INLINE_
-#endif
-
diff --git a/include/ext2fs/ext2fs.h b/include/ext2fs/ext2fs.h
index b88e3a4..359838f 100644
--- a/include/ext2fs/ext2fs.h
+++ b/include/ext2fs/ext2fs.h
@@ -17,13 +17,6 @@ extern "C" {
 #endif
 
 /*
- * Non-GNU C compilers won't necessarily understand inline
- */
-#if (!defined(__GNUC__) && !defined(__WATCOMC__))
-#define NO_INLINE_FUNCS
-#endif
-
-/*
  * Where the master copy of the superblock is located, and how big
  * superblocks are supposed to be.  We define SUPERBLOCK_SIZE because
  * the size of the superblock structure is not necessarily trustworthy
@@ -871,13 +864,6 @@ extern int ext2fs_group_of_ino(ext2_filsys fs, ino_t ino);
 extern blk_t ext2fs_inode_data_blocks(ext2_filsys fs,
 				     struct ext2_inode *inode);
 
-/*
- * The actual inlined functions definitions themselves...
- *
- * If NO_INLINE_FUNCS is defined, then we won't try to do inline
- * functions at all!
- */
-#if !defined(NO_INLINE_FUNCS)
 #ifdef __GNUC__
 #define _INLINE_ extern __inline__
 #else				/* For Watcom C */
@@ -1021,7 +1007,6 @@ _INLINE_ int ext2fs_group_of_ino(ext2_filsys fs, ino_t ino)
 	return (ino - 1) / fs->super->s_inodes_per_group;
 }
 #undef _INLINE_
-#endif
 
 #ifdef __cplusplus
 }
-- 
2.1.2

