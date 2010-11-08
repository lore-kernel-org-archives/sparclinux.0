From: David Miller <davem@davemloft.net>
Date: Mon, 08 Nov 2010 21:38:14 +0000
Subject: sparc: fix openpromfs compile
Message-Id: <20101108.133814.28818304.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


From: Meelis Roos <mroos@linux.ee>

Fix openpromfs compilation by adding a missing semicolon in 
fs/openpromfs/inode.c openprom_mount().

Signed-off-by: Meelis Roos <mroos@linux.ee>
Signed-off-by: David S. Miller <davem@davemloft.net>
---

Linus, please just apply this build fix directly.  It's fallout
from Al's commit fc14f2fef682df677d64a145256dbd263df2aa7b.

Thank you.

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
