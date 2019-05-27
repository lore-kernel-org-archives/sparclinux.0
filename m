From: Gen Zhang <blackgod016574@gmail.com>
Date: Mon, 27 May 2019 03:25:51 +0000
Subject: [PATCH] mdesc: fix a missing-check bug in get_vdev_port_node_info()
Message-Id: <20190527032551.GA19187@zhanggen-UX430UQ>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: davem@davemloft.net, rppt@linux.vnet.ibm.com, akpm@linux-foundation.org, mhocko@suse.com, sfr@canb.auug.org.au
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org

In get_vdev_port_node_info(), 'node_info->vdev_port.name' is allcoated
by kstrdup_const(), and it returns NULL when fails. So 
'node_info->vdev_port.name' should be checked.

Signed-off-by: Gen Zhang <blackgod016574@gmail.com>
---
diff --git a/arch/sparc/kernel/mdesc.c b/arch/sparc/kernel/mdesc.c
index 9a26b44..8e645dd 100644
--- a/arch/sparc/kernel/mdesc.c
+++ b/arch/sparc/kernel/mdesc.c
@@ -356,6 +356,8 @@ static int get_vdev_port_node_info(struct mdesc_handle *md, u64 node,
 
 	node_info->vdev_port.id = *idp;
 	node_info->vdev_port.name = kstrdup_const(name, GFP_KERNEL);
+	if (!node_info->vdev_port.name)
+		return -1;
 	node_info->vdev_port.parent_cfg_hdl = *parent_cfg_hdlp;
 
 	return 0;
---
