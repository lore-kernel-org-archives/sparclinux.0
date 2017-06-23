From: Jag Raman <jag.raman@oracle.com>
Date: Fri, 23 Jun 2017 18:58:40 +0000
Subject: [PATCH v2 12/12] sparc64: add port_id to VIO device metadata
Message-Id: <ab9580919b8b37f7e739c103eb095886e1f41bad.1498238657.git.jag.raman@oracle.com>
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
index 624f0a9..6715fc3 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -334,6 +334,7 @@ int vio_set_intr(unsigned long dev_ino, int state)
 		memset(vdev->compat, 0, sizeof(vdev->compat));
 	vdev->compat_len = clen;
 
+	vdev->port_id = ~0UL;
 	vdev->tx_irq = 0;
 	vdev->rx_irq = 0;
 
@@ -349,6 +350,7 @@ int vio_set_intr(unsigned long dev_ino, int state)
 		dev_set_name(&vdev->dev, "%s-%llu-%llu", type,
 			     *cfg_handle, *id);
 		vdev->dev_no = *cfg_handle;
+		vdev->port_id = *id;
 	}
 
 	vdev->dev.parent = parent;
-- 
1.7.1

