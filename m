From: Meelis Roos <mroos@linux.ee>
Date: Wed, 03 Nov 2010 09:37:59 +0000
Subject: [PATCH] fix openpromfs compile
Message-Id: <alpine.SOC.1.00.1011031134290.17199@math.ut.ee>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Fix openpromfs compilation by adding a missing semicolon in 
fs/openpromfs/inode.c openprom_mount().

Signed-off-by: Meelis Roos <mroos@linux.ee>

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index ddb1f41..911e61f 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -418,7 +418,7 @@ out_no_root:
 static struct dentry *openprom_mount(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {
-	return mount_single(fs_type, flags, data, openprom_fill_super)
+	return mount_single(fs_type, flags, data, openprom_fill_super);
 }
 
 static struct file_system_type openprom_fs_type = {


-- 
Meelis Roos (mroos@linux.ee)
