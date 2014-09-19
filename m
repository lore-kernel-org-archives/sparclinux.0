From: Allen Pais <allen.pais@oracle.com>
Date: Fri, 19 Sep 2014 13:42:26 +0000
Subject: [PATCH] sunvdc: compute vdisk geometry from capacity
Message-Id: <1411134146-26624-1-git-send-email-allen.pais@oracle.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

The LDom diskserver doesn't return reliable geometry data. In addition,
the types for all fields in the vio_disk_geom are u16, which were being
truncated in the cast into the u8's of the Linux struct hd_geometry.

Modify vdc_getgeo() to compute the geometry from the disk's capacity in a
manner consistent with xen-blkfront::blkif_getgeo().

Signed-off-by: Dwight Engen <dwight.engen@oracle.com>
---
 drivers/block/sunvdc.c |   23 ++++++++++++++---------
 1 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 66ddf70..1616ad0 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -70,7 +70,6 @@ struct vdc_port {
 
 	char			disk_name[32];
 
-	struct vio_disk_geom	geom;
 	struct vio_disk_vtoc	label;
 };
 
@@ -103,11 +102,15 @@ static inline u32 vdc_tx_dring_avail(struct vio_dring_state *dr)
 static int vdc_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
 	struct gendisk *disk = bdev->bd_disk;
-	struct vdc_port *port = disk->private_data;
+	sector_t nsect = get_capacity(disk);
+	sector_t cylinders = nsect;
 
-	geo->heads = (u8) port->geom.num_hd;
-	geo->sectors = (u8) port->geom.num_sec;
-	geo->cylinders = port->geom.num_cyl;
+	geo->heads = 0xff;
+	geo->sectors = 0x3f;
+	sector_div(cylinders, geo->heads * geo->sectors);
+	geo->cylinders = cylinders;
+	if ((sector_t)(geo->cylinders + 1) * geo->heads * geo->sectors < nsect)
+		geo->cylinders = 0xffff;
 
 	return 0;
 }
@@ -714,16 +717,18 @@ static int probe_disk(struct vdc_port *port)
 		if (port->vdisk_size = -1)
 			return -ENODEV;
 	} else {
+		struct vio_disk_geom geom;
+
 		err = generic_request(port, VD_OP_GET_DISKGEOM,
-				      &port->geom, sizeof(port->geom));
+				      &geom, sizeof(geom));
 		if (err < 0) {
 			printk(KERN_ERR PFX "VD_OP_GET_DISKGEOM returns "
 			       "error %d\n", err);
 			return err;
 		}
-		port->vdisk_size = ((u64)port->geom.num_cyl *
-				    (u64)port->geom.num_hd *
-				    (u64)port->geom.num_sec);
+		port->vdisk_size = ((u64)geom.num_cyl *
+				    (u64)geom.num_hd *
+				    (u64)geom.num_sec);
 	}
 
 	q = blk_init_queue(do_vdc_request, &port->vio.lock);
-- 
1.7.1

