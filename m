From: Jan Engelhardt <jengelh@medozas.de>
Date: Mon, 15 Nov 2010 21:46:19 +0000
Subject: openpromfs: fix compile error
Message-Id: <alpine.LNX.2.01.1011152245320.30823@obet.zrqbmnf.qr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: sparclinux@vger.kernel.org

parent b3cfc0e84039db344d2e1c5ccf870ebec6b89af3 (v2.6.37-rc1-3-gb3cfc0e)
commit 56a31331f7f834c41c4841d901ab9097d200b5de
Author: Jan Engelhardt <jengelh@medozas.de>
Date:   Mon Nov 15 22:38:16 2010 +0100

openpromfs: fix compile error

Fix a compile error introduced by v2.6.37-rc1~44^2~23.

  CC [M]  fs/openpromfs/inode.o
fs/openpromfs/inode.c: In function ‘openprom_mount’:
fs/openpromfs/inode.c:422:1: error: expected ‘;’ before ‘}’ token

Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Jan Engelhardt <jengelh@medozas.de>
---
 fs/openpromfs/inode.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

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
# Created with git-export-patch

