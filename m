From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 19 Oct 2014 00:00:52 +0000
Subject: [PATCH 4/5] silo: ext2fs: delete forward declarations of inline functions
Message-Id: <1413676853-23942-5-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Delete forward declarations of inline functions.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 include/ext2fs/bitops.h | 67 -------------------------------------------------
 include/ext2fs/ext2fs.h | 22 ----------------
 2 files changed, 89 deletions(-)

diff --git a/include/ext2fs/bitops.h b/include/ext2fs/bitops.h
index d7d0ce0..2c9acae 100644
--- a/include/ext2fs/bitops.h
+++ b/include/ext2fs/bitops.h
@@ -13,70 +13,10 @@
  * Linus Torvalds.
  */
 
-
-extern int ext2fs_set_bit(int nr,void * addr);
-extern int ext2fs_clear_bit(int nr, void * addr);
-extern int ext2fs_test_bit(int nr, const void * addr);
-extern __u16 ext2fs_swab16(__u16 val);
-extern __u32 ext2fs_swab32(__u32 val);
-
 /*
  * EXT2FS bitmap manipulation routines.
  */
 
-/* Support for sending warning messages from the inline subroutines */
-extern const char *ext2fs_block_string;
-extern const char *ext2fs_inode_string;
-extern const char *ext2fs_mark_string;
-extern const char *ext2fs_unmark_string;
-extern const char *ext2fs_test_string;
-extern void ext2fs_warn_bitmap(errcode_t errcode, unsigned long arg,
-			       const char *description);
-extern void ext2fs_warn_bitmap2(ext2fs_generic_bitmap bitmap,
-				int code, unsigned long arg);
-
-extern int ext2fs_mark_block_bitmap(ext2fs_block_bitmap bitmap, blk_t block);
-extern int ext2fs_unmark_block_bitmap(ext2fs_block_bitmap bitmap,
-				       blk_t block);
-extern int ext2fs_test_block_bitmap(ext2fs_block_bitmap bitmap, blk_t block);
-
-extern int ext2fs_mark_inode_bitmap(ext2fs_inode_bitmap bitmap, ino_t inode);
-extern int ext2fs_unmark_inode_bitmap(ext2fs_inode_bitmap bitmap,
-				       ino_t inode);
-extern int ext2fs_test_inode_bitmap(ext2fs_inode_bitmap bitmap, ino_t inode);
-
-extern void ext2fs_fast_mark_block_bitmap(ext2fs_block_bitmap bitmap,
-					  blk_t block);
-extern void ext2fs_fast_unmark_block_bitmap(ext2fs_block_bitmap bitmap,
-					    blk_t block);
-extern int ext2fs_fast_test_block_bitmap(ext2fs_block_bitmap bitmap,
-					 blk_t block);
-
-extern void ext2fs_fast_mark_inode_bitmap(ext2fs_inode_bitmap bitmap,
-					  ino_t inode);
-extern void ext2fs_fast_unmark_inode_bitmap(ext2fs_inode_bitmap bitmap,
-					    ino_t inode);
-extern int ext2fs_fast_test_inode_bitmap(ext2fs_inode_bitmap bitmap,
-					 ino_t inode);
-extern blk_t ext2fs_get_block_bitmap_start(ext2fs_block_bitmap bitmap);
-extern ino_t ext2fs_get_inode_bitmap_start(ext2fs_inode_bitmap bitmap);
-extern blk_t ext2fs_get_block_bitmap_end(ext2fs_block_bitmap bitmap);
-extern ino_t ext2fs_get_inode_bitmap_end(ext2fs_inode_bitmap bitmap);
-
-extern void ext2fs_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
-					   blk_t block, int num);
-extern void ext2fs_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
-					     blk_t block, int num);
-extern int ext2fs_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
-					  blk_t block, int num);
-extern void ext2fs_fast_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
-						blk_t block, int num);
-extern void ext2fs_fast_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
-						  blk_t block, int num);
-extern int ext2fs_fast_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
-					       blk_t block, int num);
-extern void ext2fs_set_bitmap_padding(ext2fs_generic_bitmap map);
-
 #ifdef __GNUC__
 #define _INLINE_ extern __inline__
 #else				/* For Watcom C */
@@ -214,13 +154,6 @@ _INLINE_ __u32 ext2fs_swab32(__u32 val)
 #endif /* !_EXT2_HAVE_ASM_SWAB */
 
 _INLINE_ int ext2fs_mark_generic_bitmap(ext2fs_generic_bitmap bitmap,
-					 __u32 bitno);
-_INLINE_ int ext2fs_unmark_generic_bitmap(ext2fs_generic_bitmap bitmap,
-					   blk_t bitno);
-_INLINE_ int ext2fs_test_generic_bitmap(ext2fs_generic_bitmap bitmap,
-					blk_t bitno);
-
-_INLINE_ int ext2fs_mark_generic_bitmap(ext2fs_generic_bitmap bitmap,
 					 __u32 bitno)
 {
 	if ((bitno < bitmap->start) || (bitno > bitmap->end)) {
diff --git a/include/ext2fs/ext2fs.h b/include/ext2fs/ext2fs.h
index 359838f..91603b7 100644
--- a/include/ext2fs/ext2fs.h
+++ b/include/ext2fs/ext2fs.h
@@ -842,28 +842,6 @@ extern int ext2fs_parse_version_string(const char *ver_string);
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
 #ifdef __GNUC__
 #define _INLINE_ extern __inline__
 #else				/* For Watcom C */
-- 
2.1.2

