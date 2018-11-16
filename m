From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Nov 2018 21:06:53 +0000
Subject: [PATCH v2 02/10] fs/openpromfs: Use of_node_name_eq for node name comparisons
Message-Id: <20181116210701.22968-3-robh@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Convert string compares of DT node names to use of_node_name_eq helper
instead. This removes direct access to the node name pointer.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 fs/openpromfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 3d8e9bcfe239..1b2d0d2fe2ee 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -246,7 +246,7 @@ static struct dentry *openpromfs_lookup(struct inode *dir, struct dentry *dentry
 		set_nlink(inode, 2);
 		break;
 	case op_inode_prop:
-		if (!strcmp(dp->name, "options") && (len = 17) &&
+		if (of_node_name_eq(dp, "options") && (len = 17) &&
 		    !strncmp (name, "security-password", 17))
 			inode->i_mode = S_IFREG | S_IRUSR | S_IWUSR;
 		else
-- 
2.19.1
