From: Jurij Smakov <jurij@wooyd.org>
Date: Sat, 21 Oct 2006 04:18:49 +0000
Subject: Building silo against 2.6.18 kernel headers
Message-Id: <20061021041849.GA4720@droopy.oc.cox.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Due to some changes in the kernel headers, introduced in 2.6.18 (the 
struct ufs_super_block was split into three different structs 
ufs_super_block_{first,second,third}), silo no longer builds against 
them. I came up with the patch for it (attached). Please note that the 
patch removes the ability to build silo against previous versions of 
kernel headers, so it probably is not suitable for upstream in the 
present form. I asked people to test it and so far did not receive any 
negative reports :-).

Comments and improvements are welcome.

Best regards,
-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC

--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="10-silo_new_ufs_superblock.patch"

diff -aur a/second/fs/ufs.c b/second/fs/ufs.c
--- a/second/fs/ufs.c	2006-06-01 10:24:53.000000000 -0700
+++ b/second/fs/ufs.c	2006-10-16 20:11:00.000000000 -0700
@@ -40,28 +40,18 @@
 
 ino_t inode = 0;
 
-#ifdef UFS_CIGAM
-/* Apparently new header */
-
 #define ufsi_size(x) ((unsigned int)((x)->ui_size))
 #define ufsi_db(x) ((unsigned int *)((x)->ui_u2.ui_addr.ui_db))
 #define ufsi_ib(x) ((unsigned int *)((x)->ui_u2.ui_addr.ui_ib))
 #define ufsd_namlen(x) ((unsigned char)((x)->d_u.d_44.d_namlen))
 
-#ifdef UFS_MINFREE
-/* Apparently even newer header */
-#define ufs_superblock ufs_super_block
+struct ufs_superblock_full {
+	struct ufs_super_block_first first;
+	struct ufs_super_block_second second;
+	struct ufs_super_block_third third;
+};
+#define ufs_superblock ufs_super_block_first
 #define ufs_direct ufs_dir_entry
-#endif
-
-#else
-
-#define ufsi_size(x) (((x)->ui_size.val[1]))
-#define ufsi_db(x) ((unsigned int *)((x)->ui_db))
-#define ufsi_ib(x) ((unsigned int *)((x)->ui_ib))
-#define ufsd_namlen(x) ((unsigned char)((x)->d_namlen))
-
-#endif
 
 #ifndef S_ISLNK
 #include <sys/stat.h>
@@ -92,25 +82,22 @@
         return p;
 }
 
-static struct ufs_superblock *ufs_read_super(ufs_filsys fs)
+static struct ufs_superblock_full *ufs_read_super(ufs_filsys fs)
 {
-    struct ufs_superblock *usb;
+    struct ufs_superblock_full *usb;
 
-    usb = (struct ufs_superblock *) malloc (2048);
+    usb = (struct ufs_superblock_full *) malloc (2048);
     if (!usb) return 0;
     if (io_channel_read_blk (fs->io, UFS_SBLOCK/1024, -2048, (char *)usb))
         return 0;
-    if (usb->fs_magic != UFS_MAGIC) {
-	/* XXX - replace hard-coded constant with a byte-swap macro */
-	if (usb->fs_magic == 0x54190100) {
-	}
+    if (usb->third.fs_magic != UFS_MAGIC) {
 	return 0;
     }
-    if (usb->fs_bsize != UFS_BSIZE)
+    if (usb->first.fs_bsize != UFS_BSIZE)
         return 0;
-    if (usb->fs_fsize != UFS_FSIZE)
+    if (usb->first.fs_fsize != UFS_FSIZE)
         return 0;
-    io_channel_set_blksize (fs->io, usb->fs_fsize);
+    io_channel_set_blksize (fs->io, usb->first.fs_fsize);
     return usb;
 }
 

--9amGYk9869ThD9tj--
