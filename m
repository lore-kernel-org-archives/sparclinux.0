From: Adrian Bunk <bunk@kernel.org>
Date: Thu, 05 Jun 2008 18:26:58 +0000
Subject: [2.6 patch] drivers/sbus/: cleanups
Message-Id: <20080605182649.GL1469@cs181133002.pp.htv.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

This patch contains the following cleanups:
- make the following needlessly global code static:
  - char/uctrl.c: uctrl_get_event_status()
  - char/uctrl.c: uctrl_get_external_status()
  - char/vfc_dev.c: struct vfc_dev_lst
  - char/vfc_dev.c: vfc_lock_device()
  - char/vfc_dev.c: vfc_unlock_device()
  - char/vfc_dev.c: vfc_captstat_reset()
  - char/vfc_dev.c: vfc_memptr_reset()
  - char/vfc_dev.c: vfc_csr_init()
  - char/vfc_dev.c: vfc_saa9051_init()
  - char/vfc_dev.c: init_vfc_hw()
  - char/vfc_dev.c: init_vfc_devstruct()
  - char/vfc_dev.c: init_vfc_device()
  - char/vfc_dev.c: vfc_get_dev_ptr()
  - char/vfc_dev.c: vfc_capture_start()
  - char/vfc_dev.c: vfc_capture_poll()
  - char/vfc_dev.c: vfc_port_change_ioctl()
  - char/vfc_dev.c: vfc_set_video_ioctl()
  - char/vfc_dev.c: vfc_get_video_ioctl()
  - char/vfc_i2c.c: vfc_i2c_wait_for_bus()
  - char/vfc_i2c.c: vfc_i2c_wait_for_pin()
  - char/vfc_i2c.c: vfc_i2c_xmit_addr()
  - char/vfc_i2c.c: vfc_i2c_xmit_byte()
  - char/vfc_i2c.c: vfc_i2c_recv_byte()
  - dvma.c: init_one_dvma()
- remove an unused variable from a function:
  - char/uctrl.c: ts102_uctrl_init()
- remove the following unused and empty function:
  - char/uctrl.c: uctrl_set_video()

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 drivers/sbus/char/uctrl.c   |   16 ++++----------
 drivers/sbus/char/vfc.h     |    4 ---
 drivers/sbus/char/vfc_dev.c |   39 ++++++++++++++++++------------------
 drivers/sbus/char/vfc_i2c.c |   12 ++++++-----
 drivers/sbus/dvma.c         |    2 -
 5 files changed, 33 insertions(+), 40 deletions(-)

26ea969416ee8957dc9c4e8a7c464911493635ee diff --git a/drivers/sbus/char/uctrl.c b/drivers/sbus/char/uctrl.c
index 383f32c..2f6df34 100644
--- a/drivers/sbus/char/uctrl.c
+++ b/drivers/sbus/char/uctrl.c
@@ -194,8 +194,8 @@ struct uctrl_driver {
 
 static struct uctrl_driver drv;
 
-void uctrl_get_event_status(void);
-void uctrl_get_external_status(void);
+static void uctrl_get_event_status(void);
+static void uctrl_get_external_status(void);
 
 static int
 uctrl_ioctl(struct inode *inode, struct file *file,
@@ -263,12 +263,6 @@ static struct miscdevice uctrl_dev = {
   driver->regs->uctrl_stat = UCTRL_STAT_RXNE_STA; \
 }
 
-void uctrl_set_video(int status)
-{
-	struct uctrl_driver *driver = &drv;
-	
-}
-
 static void uctrl_do_txn(struct uctrl_txn *txn)
 {
 	struct uctrl_driver *driver = &drv;
@@ -308,7 +302,7 @@ static void uctrl_do_txn(struct uctrl_txn *txn)
 	}
 }
 
-void uctrl_get_event_status(void)
+static void uctrl_get_event_status(void)
 {
 	struct uctrl_driver *driver = &drv;
 	struct uctrl_txn txn;
@@ -328,7 +322,7 @@ void uctrl_get_event_status(void)
 	dprintk(("ev is %x\n", driver->status.event_status));
 }
 
-void uctrl_get_external_status(void)
+static void uctrl_get_external_status(void)
 {
 	struct uctrl_driver *driver = &drv;
 	struct uctrl_txn txn;
@@ -360,7 +354,7 @@ void uctrl_get_external_status(void)
 static int __init ts102_uctrl_init(void)
 {
 	struct uctrl_driver *driver = &drv;
-	int len, i;
+	int len;
 	struct linux_prom_irqs tmp_irq[2];
         unsigned int vaddr[2] = { 0, 0 };
 	int tmpnode, uctrlnode = prom_getchild(prom_root_node);
diff --git a/drivers/sbus/char/vfc.h b/drivers/sbus/char/vfc.h
index f1aa138..a5240c5 100644
--- a/drivers/sbus/char/vfc.h
+++ b/drivers/sbus/char/vfc.h
@@ -133,8 +133,6 @@ struct vfc_dev {
 	unsigned char saa9051_state_array[VFC_SAA9051_NR];
 };
 
-extern struct vfc_dev **vfc_dev_lst;
-
 void captstat_reset(struct vfc_dev *);
 void memptr_reset(struct vfc_dev *);
 
@@ -145,8 +143,6 @@ int vfc_i2c_sendbuf(struct vfc_dev *, unsigned char, char *, int) ;
 int vfc_i2c_recvbuf(struct vfc_dev *, unsigned char, char *, int) ;
 int vfc_i2c_reset_bus(struct vfc_dev *);
 int vfc_init_i2c_bus(struct vfc_dev *);
-void vfc_lock_device(struct vfc_dev *);
-void vfc_unlock_device(struct vfc_dev *);
 
 #define VFC_CONTROL_DIAGMODE  0x10000000
 #define VFC_CONTROL_MEMPTR    0x20000000
diff --git a/drivers/sbus/char/vfc_dev.c b/drivers/sbus/char/vfc_dev.c
index d4f8fcd..c06b2a1 100644
--- a/drivers/sbus/char/vfc_dev.c
+++ b/drivers/sbus/char/vfc_dev.c
@@ -44,7 +44,7 @@
 #include <asm/vfc_ioctls.h>
 
 static const struct file_operations vfc_fops;
-struct vfc_dev **vfc_dev_lst;
+static struct vfc_dev **vfc_dev_lst;
 static char vfcstr[]="vfc";
 static unsigned char saa9051_init_array[VFC_SAA9051_NR] = {
 	0x00, 0x64, 0x72, 0x52,
@@ -53,18 +53,18 @@ static unsigned char saa9051_init_array[VFC_SAA9051_NR] = {
 	0x3e
 };
 
-void vfc_lock_device(struct vfc_dev *dev)
+static void vfc_lock_device(struct vfc_dev *dev)
 {
 	mutex_lock(&dev->device_lock_mtx);
 }
 
-void vfc_unlock_device(struct vfc_dev *dev)
+static void vfc_unlock_device(struct vfc_dev *dev)
 {
 	mutex_unlock(&dev->device_lock_mtx);
 }
 
 
-void vfc_captstat_reset(struct vfc_dev *dev) 
+static void vfc_captstat_reset(struct vfc_dev *dev) 
 {
 	dev->control_reg |= VFC_CONTROL_CAPTRESET;
 	sbus_writel(dev->control_reg, &dev->regs->control);
@@ -74,7 +74,7 @@ void vfc_captstat_reset(struct vfc_dev *dev)
 	sbus_writel(dev->control_reg, &dev->regs->control);
 }
 
-void vfc_memptr_reset(struct vfc_dev *dev) 
+static void vfc_memptr_reset(struct vfc_dev *dev) 
 {
 	dev->control_reg |= VFC_CONTROL_MEMPTR;
 	sbus_writel(dev->control_reg, &dev->regs->control);
@@ -84,7 +84,7 @@ void vfc_memptr_reset(struct vfc_dev *dev)
 	sbus_writel(dev->control_reg, &dev->regs->control);
 }
 
-int vfc_csr_init(struct vfc_dev *dev)
+static int vfc_csr_init(struct vfc_dev *dev)
 {
 	dev->control_reg = 0x80000000;
 	sbus_writel(dev->control_reg, &dev->regs->control);
@@ -106,7 +106,7 @@ int vfc_csr_init(struct vfc_dev *dev)
 	return 0;
 }
 
-int vfc_saa9051_init(struct vfc_dev *dev)
+static int vfc_saa9051_init(struct vfc_dev *dev)
 {
 	int i;
 
@@ -118,7 +118,7 @@ int vfc_saa9051_init(struct vfc_dev *dev)
 	return 0;
 }
 
-int init_vfc_hw(struct vfc_dev *dev) 
+static int init_vfc_hw(struct vfc_dev *dev) 
 {
 	vfc_lock_device(dev);
 	vfc_csr_init(dev);
@@ -131,7 +131,7 @@ int init_vfc_hw(struct vfc_dev *dev)
 	return 0; 
 }
 
-int init_vfc_devstruct(struct vfc_dev *dev, int instance) 
+static int init_vfc_devstruct(struct vfc_dev *dev, int instance) 
 {
 	dev->instance=instance;
 	mutex_init(&dev->device_lock_mtx);
@@ -140,7 +140,8 @@ int init_vfc_devstruct(struct vfc_dev *dev, int instance)
 	return 0;
 }
 
-int init_vfc_device(struct sbus_dev *sdev,struct vfc_dev *dev, int instance)
+static int init_vfc_device(struct sbus_dev *sdev,struct vfc_dev *dev,
+			   int instance)
 {
 	if(dev = NULL) {
 		printk(KERN_ERR "VFC: Bogus pointer passed\n");
@@ -167,7 +168,7 @@ int init_vfc_device(struct sbus_dev *sdev,struct vfc_dev *dev, int instance)
 }
 
 
-struct vfc_dev *vfc_get_dev_ptr(int instance) 
+static struct vfc_dev *vfc_get_dev_ptr(int instance) 
 {
 	return vfc_dev_lst[instance];
 }
@@ -287,7 +288,7 @@ static int vfc_debug(struct vfc_dev *dev, int cmd, void __user *argp)
 	return 0;
 }
 
-int vfc_capture_start(struct vfc_dev *dev) 
+static int vfc_capture_start(struct vfc_dev *dev) 
 {
 	vfc_captstat_reset(dev);
 	dev->control_reg = sbus_readl(&dev->regs->control);
@@ -309,7 +310,7 @@ int vfc_capture_start(struct vfc_dev *dev)
 	return 0;
 }
 
-int vfc_capture_poll(struct vfc_dev *dev) 
+static int vfc_capture_poll(struct vfc_dev *dev) 
 {
 	int timeout = 1000;
 
@@ -385,8 +386,8 @@ static int vfc_set_control_ioctl(struct inode *inode, struct file *file,
 }
 
 
-int vfc_port_change_ioctl(struct inode *inode, struct file *file, 
-			  struct vfc_dev *dev, unsigned long arg) 
+static int vfc_port_change_ioctl(struct inode *inode, struct file *file, 
+				 struct vfc_dev *dev, unsigned long arg) 
 {
 	int ret = 0;
 	int cmd;
@@ -455,8 +456,8 @@ int vfc_port_change_ioctl(struct inode *inode, struct file *file,
 	return ret;
 }
 
-int vfc_set_video_ioctl(struct inode *inode, struct file *file, 
-			struct vfc_dev *dev, unsigned long arg) 
+static int vfc_set_video_ioctl(struct inode *inode, struct file *file, 
+			       struct vfc_dev *dev, unsigned long arg) 
 {
 	int ret = 0;
 	int cmd;
@@ -506,8 +507,8 @@ int vfc_set_video_ioctl(struct inode *inode, struct file *file,
 	return ret;
 }
 
-int vfc_get_video_ioctl(struct inode *inode, struct file *file, 
-			struct vfc_dev *dev, unsigned long arg) 
+static int vfc_get_video_ioctl(struct inode *inode, struct file *file, 
+			       struct vfc_dev *dev, unsigned long arg) 
 {
 	int ret = 0;
 	unsigned int status = NO_LOCK;
diff --git a/drivers/sbus/char/vfc_i2c.c b/drivers/sbus/char/vfc_i2c.c
index 9efed77..4930a9c 100644
--- a/drivers/sbus/char/vfc_i2c.c
+++ b/drivers/sbus/char/vfc_i2c.c
@@ -114,7 +114,7 @@ int vfc_i2c_reset_bus(struct vfc_dev *dev)
 	return 0;
 }
 
-int vfc_i2c_wait_for_bus(struct vfc_dev *dev) 
+static int vfc_i2c_wait_for_bus(struct vfc_dev *dev) 
 {
 	int timeout = 1000; 
 
@@ -126,7 +126,7 @@ int vfc_i2c_wait_for_bus(struct vfc_dev *dev)
 	return 0;
 }
 
-int vfc_i2c_wait_for_pin(struct vfc_dev *dev, int ack)
+static int vfc_i2c_wait_for_pin(struct vfc_dev *dev, int ack)
 {
 	int timeout = 1000; 
 	int s1;
@@ -144,7 +144,8 @@ int vfc_i2c_wait_for_pin(struct vfc_dev *dev, int ack)
 }
 
 #define SHIFT(a) ((a) << 24)
-int vfc_i2c_xmit_addr(struct vfc_dev *dev, unsigned char addr, char mode) 
+static int vfc_i2c_xmit_addr(struct vfc_dev *dev, unsigned char addr,
+			     char mode) 
 { 
 	int ret, raddr;
 #if 1
@@ -195,7 +196,7 @@ int vfc_i2c_xmit_addr(struct vfc_dev *dev, unsigned char addr, char mode)
 	return 0;
 }
 
-int vfc_i2c_xmit_byte(struct vfc_dev *dev,unsigned char *byte) 
+static int vfc_i2c_xmit_byte(struct vfc_dev *dev,unsigned char *byte) 
 {
 	int ret;
 	u32 val = SHIFT((unsigned int)*byte);
@@ -218,7 +219,8 @@ int vfc_i2c_xmit_byte(struct vfc_dev *dev,unsigned char *byte)
 	return ret;
 }
 
-int vfc_i2c_recv_byte(struct vfc_dev *dev, unsigned char *byte, int last) 
+static int vfc_i2c_recv_byte(struct vfc_dev *dev, unsigned char *byte,
+			     int last) 
 {
 	int ret;
 
diff --git a/drivers/sbus/dvma.c b/drivers/sbus/dvma.c
index 57e1526..ab0d2de 100644
--- a/drivers/sbus/dvma.c
+++ b/drivers/sbus/dvma.c
@@ -16,7 +16,7 @@
 
 struct sbus_dma *dma_chain;
 
-void __init init_one_dvma(struct sbus_dma *dma, int num_dma)
+static void __init init_one_dvma(struct sbus_dma *dma, int num_dma)
 {
 	printk("dma%d: ", num_dma);
 	

