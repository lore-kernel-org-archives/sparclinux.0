From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 09 Jun 2017 16:31:01 +0000
Subject: [PATCH v1 12/12] sparc64: add port_id to VIO device metadata
Message-Id: <15c4d71fb71a99787ef6ee80435cdabf292d825f.1497024216.git.jag.raman@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Add port_id field to VIO device metadata to identify the port of
VIO device.

Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Reviewed-by: Shannon Nelson <shannon.nelson@oracle.com>
---
 arch/sparc/include/asm/vio.h |    1 +
 arch/sparc/kernel/vio.c      |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/arch/sparc/include/asm/vio.h b/arch/sparc/include/asm/vio.h
index 25ede61..d1c47e9 100644
--- a/arch/sparc/include/asm/vio.h
+++ b/arch/sparc/include/asm/vio.h
@@ -330,6 +330,7 @@ struct vio_dev {
 
 	u64			dev_no;
 
+	unsigned long		port_id;
 	unsigned long		channel_id;
 
 	unsigned int		tx_irq;
diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index bd3a108..c8cf1c2 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -332,6 +332,7 @@ int vio_set_intr(unsigned long dev_ino, int state)
 		memset(vdev->compat, 0, sizeof(vdev->compat));
 	vdev->compat_len = clen;
 
+	vdev->port_id = ~0UL;
 	vdev->tx_irq = 0;
 	vdev->rx_irq = 0;
 
@@ -347,6 +348,7 @@ int vio_set_intr(unsigned long dev_ino, int state)
 		dev_set_name(&vdev->dev, "%s-%llu-%llu", type,
 			     *cfg_handle, *id);
 		vdev->dev_no = *cfg_handle;
+		vdev->port_id = *id;
 	}
 
 	vdev->dev.parent = parent;
-- 
1.7.1

