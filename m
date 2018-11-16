From: Rob Herring <robh@kernel.org>
Date: Fri, 16 Nov 2018 21:06:52 +0000
Subject: [PATCH v2 01/10] fs/openpromfs: use full_name instead of path_component_name
Message-Id: <20181116210701.22968-2-robh@kernel.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

In preparation to remove struct device_node.path_component_name, use
full_name instead. kbasename is used so full_name can be used whether it
is the full path or just the node's name and unit-address.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 fs/openpromfs/inode.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index 607092f367ad..3d8e9bcfe239 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -199,10 +199,11 @@ static struct dentry *openpromfs_lookup(struct inode *dir, struct dentry *dentry
 
 	child = dp->child;
 	while (child) {
-		int n = strlen(child->path_component_name);
+		const char *node_name = kbasename(child->full_name);
+		int n = strlen(node_name);
 
 		if (len = n &&
-		    !strncmp(child->path_component_name, name, len)) {
+		    !strncmp(node_name, name, len)) {
 			ent_type = op_inode_node;
 			ent_data.node = child;
 			ino = child->unique_id;
@@ -293,8 +294,8 @@ static int openpromfs_readdir(struct file *file, struct dir_context *ctx)
 	}
 	while (child) {
 		if (!dir_emit(ctx,
-			    child->path_component_name,
-			    strlen(child->path_component_name),
+			    kbasename(child->full_name),
+			    strlen(kbasename(child->full_name)),
 			    child->unique_id, DT_DIR))
 			goto out;
 
-- 
2.19.1
