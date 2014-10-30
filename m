From: Dwight Engen <dwight.engen@oracle.com>
Date: Thu, 30 Oct 2014 19:55:35 +0000
Subject: [PATCH] sunvdc: don't call VD_OP_GET_VTOC
Message-Id: <1414698935-7520-1-git-send-email-dwight.engen@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The VD_OP_GET_VTOC operation will succeed only if the vdisk backend has a
VTOC label, otherwise it will fail. In particular, it will return error
48 (ENOTSUP) if the disk has an EFI label. VTOC disk labels are already
handled by directly reading the disk in block/partitions/sun.c (enabled by
CONFIG_SUN_PARTITION which defaults to y on SPARC). Since port->label is
unused in the driver, remove the call and the field.

Signed-off-by: Dwight Engen <dwight.engen@oracle.com>
---
 drivers/block/sunvdc.c |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 756b8ec..0ebadf9 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -69,8 +69,6 @@ struct vdc_port {
 	u8			vdisk_mtype;
 
 	char			disk_name[32];
-
-	struct vio_disk_vtoc	label;
 };
 
 static inline struct vdc_port *to_vdc_port(struct vio_driver_state *vio)
@@ -710,13 +708,6 @@ static int probe_disk(struct vdc_port *port)
 	if (comp.err)
 		return comp.err;
 
-	err = generic_request(port, VD_OP_GET_VTOC,
-			      &port->label, sizeof(port->label));
-	if (err < 0) {
-		printk(KERN_ERR PFX "VD_OP_GET_VTOC returns error %d\n", err);
-		return err;
-	}
-
 	if (vdc_version_supported(port, 1, 1)) {
 		/* vdisk_size should be set during the handshake, if it wasn't
 		 * then the underlying disk is reserved by another system
-- 
1.7.1

