From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sun, 19 Oct 2014 00:00:53 +0000
Subject: [PATCH 5/5] silo: ext2fs: replace _INLINE_ with static inline
Message-Id: <1413676853-23942-6-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Replace _INLINE_ with static inline.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 include/ext2fs/bitops.h | 116 ++++++++++++++++++++++--------------------------
 include/ext2fs/ext2fs.h |  39 +++++++---------
 2 files changed, 70 insertions(+), 85 deletions(-)

diff --git a/include/ext2fs/bitops.h b/include/ext2fs/bitops.h
index 2c9acae..a3f4a5e 100644
--- a/include/ext2fs/bitops.h
+++ b/include/ext2fs/bitops.h
@@ -17,12 +17,6 @@
  * EXT2FS bitmap manipulation routines.
  */
 
-#ifdef __GNUC__
-#define _INLINE_ extern __inline__
-#else				/* For Watcom C */
-#define _INLINE_ extern inline
-#endif
-
 #define _EXT2_HAVE_ASM_BITOPS_
 
 #ifndef EXT2_OLD_BITOPS
@@ -32,7 +26,7 @@
  * convention.
  */
 
-_INLINE_ int ext2fs_set_bit(int nr,void * addr)
+static inline int ext2fs_set_bit(int nr,void * addr)
 {
 #if 1
 	int		mask;
@@ -60,7 +54,7 @@ _INLINE_ int ext2fs_set_bit(int nr,void * addr)
 #endif
 }
 
-_INLINE_ int ext2fs_clear_bit(int nr, void * addr)
+static inline int ext2fs_clear_bit(int nr, void * addr)
 {
 #if 1
 	int		mask;
@@ -89,7 +83,7 @@ _INLINE_ int ext2fs_clear_bit(int nr, void * addr)
 #endif
 }
 
-_INLINE_ int ext2fs_test_bit(int nr, const void * addr)
+static inline int ext2fs_test_bit(int nr, const void * addr)
 {
 	int			mask;
 	const unsigned char	*ADDR = (const unsigned char *) addr;
@@ -103,7 +97,7 @@ _INLINE_ int ext2fs_test_bit(int nr, const void * addr)
 
 /* Do things the old, unplesant way. */
 
-_INLINE_ int ext2fs_set_bit(int nr, void *addr)
+static inline int ext2fs_set_bit(int nr, void *addr)
 {
 	int		mask, retval;
 	unsigned long	*ADDR = (unsigned long *) addr;
@@ -115,7 +109,7 @@ _INLINE_ int ext2fs_set_bit(int nr, void *addr)
 	return retval;
 }
 
-_INLINE_ int ext2fs_clear_bit(int nr, void *addr)
+static inline int ext2fs_clear_bit(int nr, void *addr)
 {
 	int		mask, retval;
 	unsigned long	*ADDR = (unsigned long *) addr;
@@ -127,7 +121,7 @@ _INLINE_ int ext2fs_clear_bit(int nr, void *addr)
 	return retval;
 }
 
-_INLINE_ int ext2fs_test_bit(int nr, const void *addr)
+static inline int ext2fs_test_bit(int nr, const void *addr)
 {
 	int			mask;
 	const unsigned long	*ADDR = (const unsigned long *) addr;
@@ -140,12 +134,12 @@ _INLINE_ int ext2fs_test_bit(int nr, const void *addr)
 
 #ifndef _EXT2_HAVE_ASM_SWAB
 
-_INLINE_ __u16 ext2fs_swab16(__u16 val)
+static inline __u16 ext2fs_swab16(__u16 val)
 {
 	return (val >> 8) | (val << 8);
 }
 
-_INLINE_ __u32 ext2fs_swab32(__u32 val)
+static inline __u32 ext2fs_swab32(__u32 val)
 {
 	return ((val>>24) | ((val>>8)&0xFF00) |
 		((val<<8)&0xFF0000) | (val<<24));
@@ -153,8 +147,8 @@ _INLINE_ __u32 ext2fs_swab32(__u32 val)
 
 #endif /* !_EXT2_HAVE_ASM_SWAB */
 
-_INLINE_ int ext2fs_mark_generic_bitmap(ext2fs_generic_bitmap bitmap,
-					 __u32 bitno)
+static inline int ext2fs_mark_generic_bitmap(ext2fs_generic_bitmap bitmap,
+					     __u32 bitno)
 {
 	if ((bitno < bitmap->start) || (bitno > bitmap->end)) {
 		ext2fs_warn_bitmap2(bitmap, EXT2FS_MARK_ERROR, bitno);
@@ -163,8 +157,8 @@ _INLINE_ int ext2fs_mark_generic_bitmap(ext2fs_generic_bitmap bitmap,
 	return ext2fs_set_bit(bitno - bitmap->start, bitmap->bitmap);
 }
 
-_INLINE_ int ext2fs_unmark_generic_bitmap(ext2fs_generic_bitmap bitmap,
-					   blk_t bitno)
+static inline int ext2fs_unmark_generic_bitmap(ext2fs_generic_bitmap bitmap,
+					       blk_t bitno)
 {
 	if ((bitno < bitmap->start) || (bitno > bitmap->end)) {
 		ext2fs_warn_bitmap2(bitmap, EXT2FS_UNMARK_ERROR, bitno);
@@ -173,8 +167,8 @@ _INLINE_ int ext2fs_unmark_generic_bitmap(ext2fs_generic_bitmap bitmap,
 	return ext2fs_clear_bit(bitno - bitmap->start, bitmap->bitmap);
 }
 
-_INLINE_ int ext2fs_test_generic_bitmap(ext2fs_generic_bitmap bitmap,
-					blk_t bitno)
+static inline int ext2fs_test_generic_bitmap(ext2fs_generic_bitmap bitmap,
+					     blk_t bitno)
 {
 	if ((bitno < bitmap->start) || (bitno > bitmap->end)) {
 		ext2fs_warn_bitmap2(bitmap, EXT2FS_TEST_ERROR, bitno);
@@ -183,51 +177,51 @@ _INLINE_ int ext2fs_test_generic_bitmap(ext2fs_generic_bitmap bitmap,
 	return ext2fs_test_bit(bitno - bitmap->start, bitmap->bitmap);
 }
 
-_INLINE_ int ext2fs_mark_block_bitmap(ext2fs_block_bitmap bitmap,
-				       blk_t block)
+static inline int ext2fs_mark_block_bitmap(ext2fs_block_bitmap bitmap,
+					   blk_t block)
 {
 	return ext2fs_mark_generic_bitmap((ext2fs_generic_bitmap)
 				       bitmap,
 					  block);
 }
 
-_INLINE_ int ext2fs_unmark_block_bitmap(ext2fs_block_bitmap bitmap,
-					 blk_t block)
+static inline int ext2fs_unmark_block_bitmap(ext2fs_block_bitmap bitmap,
+					     blk_t block)
 {
 	return ext2fs_unmark_generic_bitmap((ext2fs_generic_bitmap) bitmap, 
 					    block);
 }
 
-_INLINE_ int ext2fs_test_block_bitmap(ext2fs_block_bitmap bitmap,
-				       blk_t block)
+static inline int ext2fs_test_block_bitmap(ext2fs_block_bitmap bitmap,
+					   blk_t block)
 {
 	return ext2fs_test_generic_bitmap((ext2fs_generic_bitmap) bitmap, 
 					  block);
 }
 
-_INLINE_ int ext2fs_mark_inode_bitmap(ext2fs_inode_bitmap bitmap,
-				       ino_t inode)
+static inline int ext2fs_mark_inode_bitmap(ext2fs_inode_bitmap bitmap,
+					   ino_t inode)
 {
 	return ext2fs_mark_generic_bitmap((ext2fs_generic_bitmap) bitmap, 
 					  inode);
 }
 
-_INLINE_ int ext2fs_unmark_inode_bitmap(ext2fs_inode_bitmap bitmap,
-					 ino_t inode)
+static inline int ext2fs_unmark_inode_bitmap(ext2fs_inode_bitmap bitmap,
+					     ino_t inode)
 {
 	return ext2fs_unmark_generic_bitmap((ext2fs_generic_bitmap) bitmap, 
 				     inode);
 }
 
-_INLINE_ int ext2fs_test_inode_bitmap(ext2fs_inode_bitmap bitmap,
-				       ino_t inode)
+static inline int ext2fs_test_inode_bitmap(ext2fs_inode_bitmap bitmap,
+					   ino_t inode)
 {
 	return ext2fs_test_generic_bitmap((ext2fs_generic_bitmap) bitmap, 
 					  inode);
 }
 
-_INLINE_ void ext2fs_fast_mark_block_bitmap(ext2fs_block_bitmap bitmap,
-					    blk_t block)
+static inline void ext2fs_fast_mark_block_bitmap(ext2fs_block_bitmap bitmap,
+						 blk_t block)
 {
 #ifdef EXT2FS_DEBUG_FAST_OPS
 	if ((block < bitmap->start) || (block > bitmap->end)) {
@@ -239,8 +233,8 @@ _INLINE_ void ext2fs_fast_mark_block_bitmap(ext2fs_block_bitmap bitmap,
 	ext2fs_set_bit(block - bitmap->start, bitmap->bitmap);
 }
 
-_INLINE_ void ext2fs_fast_unmark_block_bitmap(ext2fs_block_bitmap bitmap,
-					      blk_t block)
+static inline void ext2fs_fast_unmark_block_bitmap(ext2fs_block_bitmap bitmap,
+						   blk_t block)
 {
 #ifdef EXT2FS_DEBUG_FAST_OPS
 	if ((block < bitmap->start) || (block > bitmap->end)) {
@@ -252,8 +246,8 @@ _INLINE_ void ext2fs_fast_unmark_block_bitmap(ext2fs_block_bitmap bitmap,
 	ext2fs_clear_bit(block - bitmap->start, bitmap->bitmap);
 }
 
-_INLINE_ int ext2fs_fast_test_block_bitmap(ext2fs_block_bitmap bitmap,
-					    blk_t block)
+static inline int ext2fs_fast_test_block_bitmap(ext2fs_block_bitmap bitmap,
+						blk_t block)
 {
 #ifdef EXT2FS_DEBUG_FAST_OPS
 	if ((block < bitmap->start) || (block > bitmap->end)) {
@@ -265,8 +259,8 @@ _INLINE_ int ext2fs_fast_test_block_bitmap(ext2fs_block_bitmap bitmap,
 	return ext2fs_test_bit(block - bitmap->start, bitmap->bitmap);
 }
 
-_INLINE_ void ext2fs_fast_mark_inode_bitmap(ext2fs_inode_bitmap bitmap,
-					    ino_t inode)
+static inline void ext2fs_fast_mark_inode_bitmap(ext2fs_inode_bitmap bitmap,
+						 ino_t inode)
 {
 #ifdef EXT2FS_DEBUG_FAST_OPS
 	if ((inode < bitmap->start) || (inode > bitmap->end)) {
@@ -278,8 +272,8 @@ _INLINE_ void ext2fs_fast_mark_inode_bitmap(ext2fs_inode_bitmap bitmap,
 	ext2fs_set_bit(inode - bitmap->start, bitmap->bitmap);
 }
 
-_INLINE_ void ext2fs_fast_unmark_inode_bitmap(ext2fs_inode_bitmap bitmap,
-					      ino_t inode)
+static inline void ext2fs_fast_unmark_inode_bitmap(ext2fs_inode_bitmap bitmap,
+						   ino_t inode)
 {
 #ifdef EXT2FS_DEBUG_FAST_OPS
 	if ((inode < bitmap->start) || (inode > bitmap->end)) {
@@ -291,8 +285,8 @@ _INLINE_ void ext2fs_fast_unmark_inode_bitmap(ext2fs_inode_bitmap bitmap,
 	ext2fs_clear_bit(inode - bitmap->start, bitmap->bitmap);
 }
 
-_INLINE_ int ext2fs_fast_test_inode_bitmap(ext2fs_inode_bitmap bitmap,
-					   ino_t inode)
+static inline int ext2fs_fast_test_inode_bitmap(ext2fs_inode_bitmap bitmap,
+						ino_t inode)
 {
 #ifdef EXT2FS_DEBUG_FAST_OPS
 	if ((inode < bitmap->start) || (inode > bitmap->end)) {
@@ -304,28 +298,28 @@ _INLINE_ int ext2fs_fast_test_inode_bitmap(ext2fs_inode_bitmap bitmap,
 	return ext2fs_test_bit(inode - bitmap->start, bitmap->bitmap);
 }
 
-_INLINE_ blk_t ext2fs_get_block_bitmap_start(ext2fs_block_bitmap bitmap)
+static inline blk_t ext2fs_get_block_bitmap_start(ext2fs_block_bitmap bitmap)
 {
 	return bitmap->start;
 }
 
-_INLINE_ ino_t ext2fs_get_inode_bitmap_start(ext2fs_inode_bitmap bitmap)
+static inline ino_t ext2fs_get_inode_bitmap_start(ext2fs_inode_bitmap bitmap)
 {
 	return bitmap->start;
 }
 
-_INLINE_ blk_t ext2fs_get_block_bitmap_end(ext2fs_block_bitmap bitmap)
+static inline blk_t ext2fs_get_block_bitmap_end(ext2fs_block_bitmap bitmap)
 {
 	return bitmap->end;
 }
 
-_INLINE_ ino_t ext2fs_get_inode_bitmap_end(ext2fs_inode_bitmap bitmap)
+static inline ino_t ext2fs_get_inode_bitmap_end(ext2fs_inode_bitmap bitmap)
 {
 	return bitmap->end;
 }
 
-_INLINE_ int ext2fs_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
-					    blk_t block, int num)
+static inline int ext2fs_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
+						 blk_t block, int num)
 {
 	int	i;
 
@@ -341,8 +335,8 @@ _INLINE_ int ext2fs_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
 	return 1;
 }
 
-_INLINE_ int ext2fs_fast_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
-						 blk_t block, int num)
+static inline int ext2fs_fast_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
+						      blk_t block, int num)
 {
 	int	i;
 
@@ -360,8 +354,8 @@ _INLINE_ int ext2fs_fast_test_block_bitmap_range(ext2fs_block_bitmap bitmap,
 	return 1;
 }
 
-_INLINE_ void ext2fs_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
-					     blk_t block, int num)
+static inline void ext2fs_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
+						  blk_t block, int num)
 {
 	int	i;
 	
@@ -374,8 +368,8 @@ _INLINE_ void ext2fs_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
 		ext2fs_set_bit(block + i - bitmap->start, bitmap->bitmap);
 }
 
-_INLINE_ void ext2fs_fast_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
-						  blk_t block, int num)
+static inline void ext2fs_fast_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
+						       blk_t block, int num)
 {
 	int	i;
 	
@@ -390,8 +384,8 @@ _INLINE_ void ext2fs_fast_mark_block_bitmap_range(ext2fs_block_bitmap bitmap,
 		ext2fs_set_bit(block + i - bitmap->start, bitmap->bitmap);
 }
 
-_INLINE_ void ext2fs_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
-					       blk_t block, int num)
+static inline void ext2fs_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
+						    blk_t block, int num)
 {
 	int	i;
 	
@@ -404,8 +398,8 @@ _INLINE_ void ext2fs_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
 		ext2fs_clear_bit(block + i - bitmap->start, bitmap->bitmap);
 }
 
-_INLINE_ void ext2fs_fast_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
-						    blk_t block, int num)
+static inline void ext2fs_fast_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
+							 blk_t block, int num)
 {
 	int	i;
 	
@@ -419,5 +413,3 @@ _INLINE_ void ext2fs_fast_unmark_block_bitmap_range(ext2fs_block_bitmap bitmap,
 	for (i=0; i < num; i++)
 		ext2fs_clear_bit(block + i - bitmap->start, bitmap->bitmap);
 }
-
-#undef _INLINE_
diff --git a/include/ext2fs/ext2fs.h b/include/ext2fs/ext2fs.h
index 91603b7..fe30bf1 100644
--- a/include/ext2fs/ext2fs.h
+++ b/include/ext2fs/ext2fs.h
@@ -842,17 +842,11 @@ extern int ext2fs_parse_version_string(const char *ver_string);
 extern int ext2fs_get_library_version(const char **ver_string,
 				      const char **date_string);
 
-#ifdef __GNUC__
-#define _INLINE_ extern __inline__
-#else				/* For Watcom C */
-#define _INLINE_ extern inline
-#endif
-
 #ifndef EXT2_CUSTOM_MEMORY_ROUTINES
 /*
  *  Allocate memory
  */
-_INLINE_ errcode_t ext2fs_get_mem(unsigned long size, void **ptr)
+static inline errcode_t ext2fs_get_mem(unsigned long size, void **ptr)
 {
 	*ptr = malloc(size);
 	if (!*ptr)
@@ -863,7 +857,7 @@ _INLINE_ errcode_t ext2fs_get_mem(unsigned long size, void **ptr)
 /*
  * Free memory
  */
-_INLINE_ errcode_t ext2fs_free_mem(void **ptr)
+static inline errcode_t ext2fs_free_mem(void **ptr)
 {
 	free(*ptr);
 	*ptr = 0;
@@ -874,8 +868,8 @@ _INLINE_ errcode_t ext2fs_free_mem(void **ptr)
 /*
  *  Resize memory
  */
-_INLINE_ errcode_t ext2fs_resize_mem(unsigned long old_size,
-				     unsigned long size, void **ptr)
+static inline errcode_t ext2fs_resize_mem(unsigned long old_size,
+					  unsigned long size, void **ptr)
 {
 	void *p;
 
@@ -891,7 +885,7 @@ _INLINE_ errcode_t ext2fs_resize_mem(unsigned long old_size,
 /*
  * Mark a filesystem superblock as dirty
  */
-_INLINE_ void ext2fs_mark_super_dirty(ext2_filsys fs)
+static inline void ext2fs_mark_super_dirty(ext2_filsys fs)
 {
 	fs->flags |= EXT2_FLAG_DIRTY | EXT2_FLAG_CHANGED;
 }
@@ -899,7 +893,7 @@ _INLINE_ void ext2fs_mark_super_dirty(ext2_filsys fs)
 /*
  * Mark a filesystem as changed
  */
-_INLINE_ void ext2fs_mark_changed(ext2_filsys fs)
+static inline void ext2fs_mark_changed(ext2_filsys fs)
 {
 	fs->flags |= EXT2_FLAG_CHANGED;
 }
@@ -907,7 +901,7 @@ _INLINE_ void ext2fs_mark_changed(ext2_filsys fs)
 /*
  * Check to see if a filesystem has changed
  */
-_INLINE_ int ext2fs_test_changed(ext2_filsys fs)
+static inline int ext2fs_test_changed(ext2_filsys fs)
 {
 	return (fs->flags & EXT2_FLAG_CHANGED);
 }
@@ -915,7 +909,7 @@ _INLINE_ int ext2fs_test_changed(ext2_filsys fs)
 /*
  * Mark a filesystem as valid
  */
-_INLINE_ void ext2fs_mark_valid(ext2_filsys fs)
+static inline void ext2fs_mark_valid(ext2_filsys fs)
 {
 	fs->flags |= EXT2_FLAG_VALID;
 }
@@ -923,7 +917,7 @@ _INLINE_ void ext2fs_mark_valid(ext2_filsys fs)
 /*
  * Mark a filesystem as NOT valid
  */
-_INLINE_ void ext2fs_unmark_valid(ext2_filsys fs)
+static inline void ext2fs_unmark_valid(ext2_filsys fs)
 {
 	fs->flags &= ~EXT2_FLAG_VALID;
 }
@@ -931,7 +925,7 @@ _INLINE_ void ext2fs_unmark_valid(ext2_filsys fs)
 /*
  * Check to see if a filesystem is valid
  */
-_INLINE_ int ext2fs_test_valid(ext2_filsys fs)
+static inline int ext2fs_test_valid(ext2_filsys fs)
 {
 	return (fs->flags & EXT2_FLAG_VALID);
 }
@@ -939,7 +933,7 @@ _INLINE_ int ext2fs_test_valid(ext2_filsys fs)
 /*
  * Mark the inode bitmap as dirty
  */
-_INLINE_ void ext2fs_mark_ib_dirty(ext2_filsys fs)
+static inline void ext2fs_mark_ib_dirty(ext2_filsys fs)
 {
 	fs->flags |= EXT2_FLAG_IB_DIRTY | EXT2_FLAG_CHANGED;
 }
@@ -947,7 +941,7 @@ _INLINE_ void ext2fs_mark_ib_dirty(ext2_filsys fs)
 /*
  * Mark the block bitmap as dirty
  */
-_INLINE_ void ext2fs_mark_bb_dirty(ext2_filsys fs)
+static inline void ext2fs_mark_bb_dirty(ext2_filsys fs)
 {
 	fs->flags |= EXT2_FLAG_BB_DIRTY | EXT2_FLAG_CHANGED;
 }
@@ -955,7 +949,7 @@ _INLINE_ void ext2fs_mark_bb_dirty(ext2_filsys fs)
 /*
  * Check to see if a filesystem's inode bitmap is dirty
  */
-_INLINE_ int ext2fs_test_ib_dirty(ext2_filsys fs)
+static inline int ext2fs_test_ib_dirty(ext2_filsys fs)
 {
 	return (fs->flags & EXT2_FLAG_IB_DIRTY);
 }
@@ -963,7 +957,7 @@ _INLINE_ int ext2fs_test_ib_dirty(ext2_filsys fs)
 /*
  * Check to see if a filesystem's block bitmap is dirty
  */
-_INLINE_ int ext2fs_test_bb_dirty(ext2_filsys fs)
+static inline int ext2fs_test_bb_dirty(ext2_filsys fs)
 {
 	return (fs->flags & EXT2_FLAG_BB_DIRTY);
 }
@@ -971,7 +965,7 @@ _INLINE_ int ext2fs_test_bb_dirty(ext2_filsys fs)
 /*
  * Return the group # of a block
  */
-_INLINE_ int ext2fs_group_of_blk(ext2_filsys fs, blk_t blk)
+static inline int ext2fs_group_of_blk(ext2_filsys fs, blk_t blk)
 {
 	return (blk - fs->super->s_first_data_block) /
 		fs->super->s_blocks_per_group;
@@ -980,11 +974,10 @@ _INLINE_ int ext2fs_group_of_blk(ext2_filsys fs, blk_t blk)
 /*
  * Return the group # of an inode number
  */
-_INLINE_ int ext2fs_group_of_ino(ext2_filsys fs, ino_t ino)
+static inline int ext2fs_group_of_ino(ext2_filsys fs, ino_t ino)
 {
 	return (ino - 1) / fs->super->s_inodes_per_group;
 }
-#undef _INLINE_
 
 #ifdef __cplusplus
 }
-- 
2.1.2

