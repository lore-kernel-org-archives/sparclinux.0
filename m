From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 19 Oct 2014 11:57:37 +0000
Subject: [PATCH v2 2/2] silo: ext2fs: delete _INLINE_ functions
Message-Id: <1413719857-9838-3-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Delete all _INLINE_ functions, they are not used and cause issues
with GNU11 mode.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 include/ext2fs/ext2fs.h | 185 ------------------------------------------------
 1 file changed, 185 deletions(-)

diff --git a/include/ext2fs/ext2fs.h b/include/ext2fs/ext2fs.h
index 78f517a..a37be99 100644
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
@@ -843,184 +836,6 @@ extern int ext2fs_parse_version_string(const char *ver_string);
 extern int ext2fs_get_library_version(const char **ver_string,
 				      const char **date_string);
 
-/* inline functions */
-extern errcode_t ext2fs_get_mem(unsigned long size, void **ptr);
-extern errcode_t ext2fs_free_mem(void **ptr);
-#if 0
-extern errcode_t ext2fs_resize_mem(unsigned long old_size,
-				   unsigned long size, void **ptr);
-#endif
-extern void ext2fs_mark_super_dirty(ext2_filsys fs);
-extern void ext2fs_mark_changed(ext2_filsys fs);
-extern int ext2fs_test_changed(ext2_filsys fs);
-extern void ext2fs_mark_valid(ext2_filsys fs);
-extern void ext2fs_unmark_valid(ext2_filsys fs);
-extern int ext2fs_test_valid(ext2_filsys fs);
-extern void ext2fs_mark_ib_dirty(ext2_filsys fs);
-extern void ext2fs_mark_bb_dirty(ext2_filsys fs);
-extern int ext2fs_test_ib_dirty(ext2_filsys fs);
-extern int ext2fs_test_bb_dirty(ext2_filsys fs);
-extern int ext2fs_group_of_blk(ext2_filsys fs, blk_t blk);
-extern int ext2fs_group_of_ino(ext2_filsys fs, ino_t ino);
-extern blk_t ext2fs_inode_data_blocks(ext2_filsys fs,
-				     struct ext2_inode *inode);
-
-/*
- * The actual inlined functions definitions themselves...
- *
- * If NO_INLINE_FUNCS is defined, then we won't try to do inline
- * functions at all!
- */
-#if (defined(INCLUDE_INLINE_FUNCS) || !defined(NO_INLINE_FUNCS))
-#ifdef INCLUDE_INLINE_FUNCS
-#define _INLINE_ extern
-#else
-#ifdef __GNUC__
-#define _INLINE_ extern __inline__
-#else				/* For Watcom C */
-#define _INLINE_ extern inline
-#endif
-#endif
-
-#ifndef EXT2_CUSTOM_MEMORY_ROUTINES
-/*
- *  Allocate memory
- */
-_INLINE_ errcode_t ext2fs_get_mem(unsigned long size, void **ptr)
-{
-	*ptr = malloc(size);
-	if (!*ptr)
-		return EXT2_ET_NO_MEMORY;
-	return 0;
-}
-
-/*
- * Free memory
- */
-_INLINE_ errcode_t ext2fs_free_mem(void **ptr)
-{
-	free(*ptr);
-	*ptr = 0;
-	return 0;
-}
-
-#if 0
-/*
- *  Resize memory
- */
-_INLINE_ errcode_t ext2fs_resize_mem(unsigned long old_size,
-				     unsigned long size, void **ptr)
-{
-	void *p;
-
-	p = realloc(*ptr, size);
-	if (!p)
-		return EXT2_ET_NO_MEMORY;
-	*ptr = p;
-	return 0;
-}
-#endif
-#endif	/* Custom memory routines */
-
-/*
- * Mark a filesystem superblock as dirty
- */
-_INLINE_ void ext2fs_mark_super_dirty(ext2_filsys fs)
-{
-	fs->flags |= EXT2_FLAG_DIRTY | EXT2_FLAG_CHANGED;
-}
-
-/*
- * Mark a filesystem as changed
- */
-_INLINE_ void ext2fs_mark_changed(ext2_filsys fs)
-{
-	fs->flags |= EXT2_FLAG_CHANGED;
-}
-
-/*
- * Check to see if a filesystem has changed
- */
-_INLINE_ int ext2fs_test_changed(ext2_filsys fs)
-{
-	return (fs->flags & EXT2_FLAG_CHANGED);
-}
-
-/*
- * Mark a filesystem as valid
- */
-_INLINE_ void ext2fs_mark_valid(ext2_filsys fs)
-{
-	fs->flags |= EXT2_FLAG_VALID;
-}
-
-/*
- * Mark a filesystem as NOT valid
- */
-_INLINE_ void ext2fs_unmark_valid(ext2_filsys fs)
-{
-	fs->flags &= ~EXT2_FLAG_VALID;
-}
-
-/*
- * Check to see if a filesystem is valid
- */
-_INLINE_ int ext2fs_test_valid(ext2_filsys fs)
-{
-	return (fs->flags & EXT2_FLAG_VALID);
-}
-
-/*
- * Mark the inode bitmap as dirty
- */
-_INLINE_ void ext2fs_mark_ib_dirty(ext2_filsys fs)
-{
-	fs->flags |= EXT2_FLAG_IB_DIRTY | EXT2_FLAG_CHANGED;
-}
-
-/*
- * Mark the block bitmap as dirty
- */
-_INLINE_ void ext2fs_mark_bb_dirty(ext2_filsys fs)
-{
-	fs->flags |= EXT2_FLAG_BB_DIRTY | EXT2_FLAG_CHANGED;
-}
-
-/*
- * Check to see if a filesystem's inode bitmap is dirty
- */
-_INLINE_ int ext2fs_test_ib_dirty(ext2_filsys fs)
-{
-	return (fs->flags & EXT2_FLAG_IB_DIRTY);
-}
-
-/*
- * Check to see if a filesystem's block bitmap is dirty
- */
-_INLINE_ int ext2fs_test_bb_dirty(ext2_filsys fs)
-{
-	return (fs->flags & EXT2_FLAG_BB_DIRTY);
-}
-
-/*
- * Return the group # of a block
- */
-_INLINE_ int ext2fs_group_of_blk(ext2_filsys fs, blk_t blk)
-{
-	return (blk - fs->super->s_first_data_block) /
-		fs->super->s_blocks_per_group;
-}
-
-/*
- * Return the group # of an inode number
- */
-_INLINE_ int ext2fs_group_of_ino(ext2_filsys fs, ino_t ino)
-{
-	return (ino - 1) / fs->super->s_inodes_per_group;
-}
-#undef _INLINE_
-#endif
-
 #ifdef __cplusplus
 }
 #endif
-- 
2.1.2

