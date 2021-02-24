From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <uwe@kleine-koenig.org>
Date: Wed, 24 Feb 2021 07:25:16 +0000
Subject: [PATCH v2] vio: make remove callback return void
Message-Id: <20210224072516.74696-1-uwe@kleine-koenig.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>, Jens Axboe <axboe@kernel.dk>, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Haren Myneni <haren@us.ibm.com>, =?UTF-8?q?Breno=20Leit=C3=A3o?= <leitao@debian.org>, Nayna Jain <nayna@linux.ibm.com>, Paulo Flabiano Smorigo <pfsmorigo@gmail.com>, Steven Royer <seroyer@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Cristobal Forno <cforno12@linux.ibm.com>, Jakub Kicinski <kuba@kernel.org>, Dany Madden <drt@linux.ibm.com>, Lijun Pan <ljp@linux.ibm.com>, Sukadev Bhattiprolu <sukadev@linux.ibm.com>, Tyrel Datwyler <tyreld@linux.ibm.com>, "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Michael Cyr <mikecyr@linux.ibm.com>, Jiri Slaby <jirislaby@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org, linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org, netdev@vger.kernel.org, linux-scsi@vger.kernel.org, target-devel@vger.kernel.org

The driver core ignores the return value of struct bus_type::remove()
because there is only little that can be done. To simplify the quest to
make this function return void, let struct vio_driver::remove() return
void, too. All users already unconditionally return 0, this commit makes
it obvious that returning an error code is a bad idea and makes it
obvious for future driver authors that returning an error code isn't
intended.

Note there are two nominally different implementations for a vio bus:
one in arch/sparc/kernel/vio.c and the other in
arch/powerpc/platforms/pseries/vio.c. I didn't care to check which
driver is using which of these busses (or if even some of them can be
used with both) and simply adapt all drivers and the two bus codes in
one go.

Note that for the powerpc implementation there is a semantical change:
Before this patch for a device that was bound to a driver without a
remove callback vio_cmo_bus_remove(viodev) wasn't called. As the device
core still considers the device unbound after vio_bus_remove() returns
calling this unconditionally is the consistent behaviour which is
implemented here.

Reviewed-by: Tyrel Datwyler <tyreld@linux.ibm.com>
Acked-by: Lijun Pan <ljp@linux.ibm.com>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Uwe Kleine-K=C3=B6nig <uwe@kleine-koenig.org>
---
Hello,

v1 (sent with Message-Id: 20210127215010.99954-1-uwe@kleine-koenig.org>
had an back then unfulfilled precondition for a patch to
drivers/net/ethernet/ibm/ibmvnic.c. That patch already got into v5.11 as
5e9eff5dfa46 "ibmvnic: device remove has higher precedence over reset".
So the way is free for this patch.

Compared to v1 I rebased on a later linus/master and added acks.

Best regards
Uwe

 arch/powerpc/include/asm/vio.h           | 2 +-
 arch/powerpc/platforms/pseries/vio.c     | 7 +++----
 arch/sparc/include/asm/vio.h             | 2 +-
 arch/sparc/kernel/ds.c                   | 6 ------
 arch/sparc/kernel/vio.c                  | 4 ++--
 drivers/block/sunvdc.c                   | 3 +--
 drivers/char/hw_random/pseries-rng.c     | 3 +--
 drivers/char/tpm/tpm_ibmvtpm.c           | 4 +---
 drivers/crypto/nx/nx-842-pseries.c       | 4 +---
 drivers/crypto/nx/nx.c                   | 4 +---
 drivers/misc/ibmvmc.c                    | 4 +---
 drivers/net/ethernet/ibm/ibmveth.c       | 4 +---
 drivers/net/ethernet/ibm/ibmvnic.c       | 4 +---
 drivers/net/ethernet/sun/ldmvsw.c        | 4 +---
 drivers/net/ethernet/sun/sunvnet.c       | 3 +--
 drivers/scsi/ibmvscsi/ibmvfc.c           | 3 +--
 drivers/scsi/ibmvscsi/ibmvscsi.c         | 4 +---
 drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c | 4 +---
 drivers/tty/hvc/hvcs.c                   | 3 +--
 drivers/tty/vcc.c                        | 4 +---
 20 files changed, 22 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/include/asm/vio.h b/arch/powerpc/include/asm/vio.h
index 0cf52746531b..721c0d6715ac 100644
--- a/arch/powerpc/include/asm/vio.h
+++ b/arch/powerpc/include/asm/vio.h
@@ -113,7 +113,7 @@ struct vio_driver {
 	const char *name;
 	const struct vio_device_id *id_table;
 	int (*probe)(struct vio_dev *dev, const struct vio_device_id *id);
-	int (*remove)(struct vio_dev *dev);
+	void (*remove)(struct vio_dev *dev);
 	/* A driver must have a get_desired_dma() function to
 	 * be loaded in a CMO environment if it uses DMA.
 	 */
diff --git a/arch/powerpc/platforms/pseries/vio.c b/arch/powerpc/platforms/=
pseries/vio.c
index b2797cfe4e2b..9cb4fc839fd5 100644
--- a/arch/powerpc/platforms/pseries/vio.c
+++ b/arch/powerpc/platforms/pseries/vio.c
@@ -1261,7 +1261,6 @@ static int vio_bus_remove(struct device *dev)
 	struct vio_dev *viodev =3D to_vio_dev(dev);
 	struct vio_driver *viodrv =3D to_vio_driver(dev->driver);
 	struct device *devptr;
-	int ret =3D 1;
=20
 	/*
 	 * Hold a reference to the device after the remove function is called
@@ -1270,13 +1269,13 @@ static int vio_bus_remove(struct device *dev)
 	devptr =3D get_device(dev);
=20
 	if (viodrv->remove)
-		ret =3D viodrv->remove(viodev);
+		viodrv->remove(viodev);
=20
-	if (!ret && firmware_has_feature(FW_FEATURE_CMO))
+	if (firmware_has_feature(FW_FEATURE_CMO))
 		vio_cmo_bus_remove(viodev);
=20
 	put_device(devptr);
-	return ret;
+	return 0;
 }
=20
 /**
diff --git a/arch/sparc/include/asm/vio.h b/arch/sparc/include/asm/vio.h
index 059f0eb678e0..8a1a83bbb6d5 100644
--- a/arch/sparc/include/asm/vio.h
+++ b/arch/sparc/include/asm/vio.h
@@ -362,7 +362,7 @@ struct vio_driver {
 	struct list_head		node;
 	const struct vio_device_id	*id_table;
 	int (*probe)(struct vio_dev *dev, const struct vio_device_id *id);
-	int (*remove)(struct vio_dev *dev);
+	void (*remove)(struct vio_dev *dev);
 	void (*shutdown)(struct vio_dev *dev);
 	unsigned long			driver_data;
 	struct device_driver		driver;
diff --git a/arch/sparc/kernel/ds.c b/arch/sparc/kernel/ds.c
index 522e5b51050c..4a5bdb0df779 100644
--- a/arch/sparc/kernel/ds.c
+++ b/arch/sparc/kernel/ds.c
@@ -1236,11 +1236,6 @@ static int ds_probe(struct vio_dev *vdev, const stru=
ct vio_device_id *id)
 	return err;
 }
=20
-static int ds_remove(struct vio_dev *vdev)
-{
-	return 0;
-}
-
 static const struct vio_device_id ds_match[] =3D {
 	{
 		.type =3D "domain-services-port",
@@ -1251,7 +1246,6 @@ static const struct vio_device_id ds_match[] =3D {
 static struct vio_driver ds_driver =3D {
 	.id_table	=3D ds_match,
 	.probe		=3D ds_probe,
-	.remove		=3D ds_remove,
 	.name		=3D "ds",
 };
=20
diff --git a/arch/sparc/kernel/vio.c b/arch/sparc/kernel/vio.c
index 4f57056ed463..348a88691219 100644
--- a/arch/sparc/kernel/vio.c
+++ b/arch/sparc/kernel/vio.c
@@ -105,10 +105,10 @@ static int vio_device_remove(struct device *dev)
 		 * routines to do so at the moment. TBD
 		 */
=20
-		return drv->remove(vdev);
+		drv->remove(vdev);
 	}
=20
-	return 1;
+	return 0;
 }
=20
 static ssize_t devspec_show(struct device *dev,
diff --git a/drivers/block/sunvdc.c b/drivers/block/sunvdc.c
index 39aeebc6837d..1547d4345ad8 100644
--- a/drivers/block/sunvdc.c
+++ b/drivers/block/sunvdc.c
@@ -1071,7 +1071,7 @@ static int vdc_port_probe(struct vio_dev *vdev, const=
 struct vio_device_id *id)
 	return err;
 }
=20
-static int vdc_port_remove(struct vio_dev *vdev)
+static void vdc_port_remove(struct vio_dev *vdev)
 {
 	struct vdc_port *port =3D dev_get_drvdata(&vdev->dev);
=20
@@ -1094,7 +1094,6 @@ static int vdc_port_remove(struct vio_dev *vdev)
=20
 		kfree(port);
 	}
-	return 0;
 }
=20
 static void vdc_requeue_inflight(struct vdc_port *port)
diff --git a/drivers/char/hw_random/pseries-rng.c b/drivers/char/hw_random/=
pseries-rng.c
index 8038a8a9fb58..f4949b689bd5 100644
--- a/drivers/char/hw_random/pseries-rng.c
+++ b/drivers/char/hw_random/pseries-rng.c
@@ -54,10 +54,9 @@ static int pseries_rng_probe(struct vio_dev *dev,
 	return hwrng_register(&pseries_rng);
 }
=20
-static int pseries_rng_remove(struct vio_dev *dev)
+static void pseries_rng_remove(struct vio_dev *dev)
 {
 	hwrng_unregister(&pseries_rng);
-	return 0;
 }
=20
 static const struct vio_device_id pseries_rng_driver_ids[] =3D {
diff --git a/drivers/char/tpm/tpm_ibmvtpm.c b/drivers/char/tpm/tpm_ibmvtpm.c
index 994385bf37c0..903604769de9 100644
--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -343,7 +343,7 @@ static int ibmvtpm_crq_send_init_complete(struct ibmvtp=
m_dev *ibmvtpm)
  *
  * Return: Always 0.
  */
-static int tpm_ibmvtpm_remove(struct vio_dev *vdev)
+static void tpm_ibmvtpm_remove(struct vio_dev *vdev)
 {
 	struct tpm_chip *chip =3D dev_get_drvdata(&vdev->dev);
 	struct ibmvtpm_dev *ibmvtpm =3D dev_get_drvdata(&chip->dev);
@@ -372,8 +372,6 @@ static int tpm_ibmvtpm_remove(struct vio_dev *vdev)
 	kfree(ibmvtpm);
 	/* For tpm_ibmvtpm_get_desired_dma */
 	dev_set_drvdata(&vdev->dev, NULL);
-
-	return 0;
 }
=20
 /**
diff --git a/drivers/crypto/nx/nx-842-pseries.c b/drivers/crypto/nx/nx-842-=
pseries.c
index 2de5e3672e42..cc8dd3072b8b 100644
--- a/drivers/crypto/nx/nx-842-pseries.c
+++ b/drivers/crypto/nx/nx-842-pseries.c
@@ -1042,7 +1042,7 @@ static int nx842_probe(struct vio_dev *viodev,
 	return ret;
 }
=20
-static int nx842_remove(struct vio_dev *viodev)
+static void nx842_remove(struct vio_dev *viodev)
 {
 	struct nx842_devdata *old_devdata;
 	unsigned long flags;
@@ -1063,8 +1063,6 @@ static int nx842_remove(struct vio_dev *viodev)
 	if (old_devdata)
 		kfree(old_devdata->counters);
 	kfree(old_devdata);
-
-	return 0;
 }
=20
 static const struct vio_device_id nx842_vio_driver_ids[] =3D {
diff --git a/drivers/crypto/nx/nx.c b/drivers/crypto/nx/nx.c
index 0d2dc5be7f19..1d0e8a1ba160 100644
--- a/drivers/crypto/nx/nx.c
+++ b/drivers/crypto/nx/nx.c
@@ -783,7 +783,7 @@ static int nx_probe(struct vio_dev *viodev, const struc=
t vio_device_id *id)
 	return nx_register_algs();
 }
=20
-static int nx_remove(struct vio_dev *viodev)
+static void nx_remove(struct vio_dev *viodev)
 {
 	dev_dbg(&viodev->dev, "entering nx_remove for UA 0x%x\n",
 		viodev->unit_address);
@@ -811,8 +811,6 @@ static int nx_remove(struct vio_dev *viodev)
 		nx_unregister_skcipher(&nx_ecb_aes_alg, NX_FC_AES,
 				       NX_MODE_AES_ECB);
 	}
-
-	return 0;
 }
=20
=20
diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
index 2d778d0f011e..c0fe3295c330 100644
--- a/drivers/misc/ibmvmc.c
+++ b/drivers/misc/ibmvmc.c
@@ -2288,15 +2288,13 @@ static int ibmvmc_probe(struct vio_dev *vdev, const=
 struct vio_device_id *id)
 	return -EPERM;
 }
=20
-static int ibmvmc_remove(struct vio_dev *vdev)
+static void ibmvmc_remove(struct vio_dev *vdev)
 {
 	struct crq_server_adapter *adapter =3D dev_get_drvdata(&vdev->dev);
=20
 	dev_info(adapter->dev, "Entering remove for UA 0x%x\n",
 		 vdev->unit_address);
 	ibmvmc_release_crq_queue(adapter);
-
-	return 0;
 }
=20
 static struct vio_device_id ibmvmc_device_table[] =3D {
diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/=
ibmveth.c
index c3ec9ceed833..7fea9ae60f13 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1758,7 +1758,7 @@ static int ibmveth_probe(struct vio_dev *dev, const s=
truct vio_device_id *id)
 	return 0;
 }
=20
-static int ibmveth_remove(struct vio_dev *dev)
+static void ibmveth_remove(struct vio_dev *dev)
 {
 	struct net_device *netdev =3D dev_get_drvdata(&dev->dev);
 	struct ibmveth_adapter *adapter =3D netdev_priv(netdev);
@@ -1771,8 +1771,6 @@ static int ibmveth_remove(struct vio_dev *dev)
=20
 	free_netdev(netdev);
 	dev_set_drvdata(&dev->dev, NULL);
-
-	return 0;
 }
=20
 static struct attribute veth_active_attr;
diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/=
ibmvnic.c
index 1c0e4beb56e7..53124b06145d 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -5349,7 +5349,7 @@ static int ibmvnic_probe(struct vio_dev *dev, const s=
truct vio_device_id *id)
 	return rc;
 }
=20
-static int ibmvnic_remove(struct vio_dev *dev)
+static void ibmvnic_remove(struct vio_dev *dev)
 {
 	struct net_device *netdev =3D dev_get_drvdata(&dev->dev);
 	struct ibmvnic_adapter *adapter =3D netdev_priv(netdev);
@@ -5390,8 +5390,6 @@ static int ibmvnic_remove(struct vio_dev *dev)
 	device_remove_file(&dev->dev, &dev_attr_failover);
 	free_netdev(netdev);
 	dev_set_drvdata(&dev->dev, NULL);
-
-	return 0;
 }
=20
 static ssize_t failover_store(struct device *dev, struct device_attribute =
*attr,
diff --git a/drivers/net/ethernet/sun/ldmvsw.c b/drivers/net/ethernet/sun/l=
dmvsw.c
index 01ea0d6f8819..50bd4e3b0af9 100644
--- a/drivers/net/ethernet/sun/ldmvsw.c
+++ b/drivers/net/ethernet/sun/ldmvsw.c
@@ -404,7 +404,7 @@ static int vsw_port_probe(struct vio_dev *vdev, const s=
truct vio_device_id *id)
 	return err;
 }
=20
-static int vsw_port_remove(struct vio_dev *vdev)
+static void vsw_port_remove(struct vio_dev *vdev)
 {
 	struct vnet_port *port =3D dev_get_drvdata(&vdev->dev);
 	unsigned long flags;
@@ -430,8 +430,6 @@ static int vsw_port_remove(struct vio_dev *vdev)
=20
 		free_netdev(port->dev);
 	}
-
-	return 0;
 }
=20
 static void vsw_cleanup(void)
diff --git a/drivers/net/ethernet/sun/sunvnet.c b/drivers/net/ethernet/sun/=
sunvnet.c
index 96b883f965f6..58ee89223951 100644
--- a/drivers/net/ethernet/sun/sunvnet.c
+++ b/drivers/net/ethernet/sun/sunvnet.c
@@ -510,7 +510,7 @@ static int vnet_port_probe(struct vio_dev *vdev, const =
struct vio_device_id *id)
 	return err;
 }
=20
-static int vnet_port_remove(struct vio_dev *vdev)
+static void vnet_port_remove(struct vio_dev *vdev)
 {
 	struct vnet_port *port =3D dev_get_drvdata(&vdev->dev);
=20
@@ -533,7 +533,6 @@ static int vnet_port_remove(struct vio_dev *vdev)
=20
 		kfree(port);
 	}
-	return 0;
 }
=20
 static const struct vio_device_id vnet_port_match[] =3D {
diff --git a/drivers/scsi/ibmvscsi/ibmvfc.c b/drivers/scsi/ibmvscsi/ibmvfc.c
index 755313b766b9..e663085a8944 100644
--- a/drivers/scsi/ibmvscsi/ibmvfc.c
+++ b/drivers/scsi/ibmvscsi/ibmvfc.c
@@ -6038,7 +6038,7 @@ static int ibmvfc_probe(struct vio_dev *vdev, const s=
truct vio_device_id *id)
  * Return value:
  * 	0
  **/
-static int ibmvfc_remove(struct vio_dev *vdev)
+static void ibmvfc_remove(struct vio_dev *vdev)
 {
 	struct ibmvfc_host *vhost =3D dev_get_drvdata(&vdev->dev);
 	LIST_HEAD(purge);
@@ -6070,7 +6070,6 @@ static int ibmvfc_remove(struct vio_dev *vdev)
 	spin_unlock(&ibmvfc_driver_lock);
 	scsi_host_put(vhost->host);
 	LEAVE;
-	return 0;
 }
=20
 /**
diff --git a/drivers/scsi/ibmvscsi/ibmvscsi.c b/drivers/scsi/ibmvscsi/ibmvs=
csi.c
index 29fcc44be2d5..77fafb1bc173 100644
--- a/drivers/scsi/ibmvscsi/ibmvscsi.c
+++ b/drivers/scsi/ibmvscsi/ibmvscsi.c
@@ -2335,7 +2335,7 @@ static int ibmvscsi_probe(struct vio_dev *vdev, const=
 struct vio_device_id *id)
 	return -1;
 }
=20
-static int ibmvscsi_remove(struct vio_dev *vdev)
+static void ibmvscsi_remove(struct vio_dev *vdev)
 {
 	struct ibmvscsi_host_data *hostdata =3D dev_get_drvdata(&vdev->dev);
=20
@@ -2356,8 +2356,6 @@ static int ibmvscsi_remove(struct vio_dev *vdev)
 	spin_unlock(&ibmvscsi_driver_lock);
=20
 	scsi_host_put(hostdata->host);
-
-	return 0;
 }
=20
 /**
diff --git a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c b/drivers/scsi/ibmvsc=
si_tgt/ibmvscsi_tgt.c
index cc3908c2d2f9..9abd9e253af6 100644
--- a/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
+++ b/drivers/scsi/ibmvscsi_tgt/ibmvscsi_tgt.c
@@ -3595,7 +3595,7 @@ static int ibmvscsis_probe(struct vio_dev *vdev,
 	return rc;
 }
=20
-static int ibmvscsis_remove(struct vio_dev *vdev)
+static void ibmvscsis_remove(struct vio_dev *vdev)
 {
 	struct scsi_info *vscsi =3D dev_get_drvdata(&vdev->dev);
=20
@@ -3622,8 +3622,6 @@ static int ibmvscsis_remove(struct vio_dev *vdev)
 	list_del(&vscsi->list);
 	spin_unlock_bh(&ibmvscsis_dev_lock);
 	kfree(vscsi);
-
-	return 0;
 }
=20
 static ssize_t system_id_show(struct device *dev,
diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index c90848919644..01fc97e3c5c8 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -819,7 +819,7 @@ static int hvcs_probe(
 	return 0;
 }
=20
-static int hvcs_remove(struct vio_dev *dev)
+static void hvcs_remove(struct vio_dev *dev)
 {
 	struct hvcs_struct *hvcsd =3D dev_get_drvdata(&dev->dev);
 	unsigned long flags;
@@ -849,7 +849,6 @@ static int hvcs_remove(struct vio_dev *dev)
=20
 	printk(KERN_INFO "HVCS: vty-server@%X removed from the"
 			" vio bus.\n", dev->unit_address);
-	return 0;
 };
=20
 static struct vio_driver hvcs_vio_driver =3D {
diff --git a/drivers/tty/vcc.c b/drivers/tty/vcc.c
index e2d6205f83ce..5f72ebf93821 100644
--- a/drivers/tty/vcc.c
+++ b/drivers/tty/vcc.c
@@ -677,7 +677,7 @@ static int vcc_probe(struct vio_dev *vdev, const struct=
 vio_device_id *id)
  *
  * Return: status of removal
  */
-static int vcc_remove(struct vio_dev *vdev)
+static void vcc_remove(struct vio_dev *vdev)
 {
 	struct vcc_port *port =3D dev_get_drvdata(&vdev->dev);
=20
@@ -712,8 +712,6 @@ static int vcc_remove(struct vio_dev *vdev)
 		kfree(port->domain);
 		kfree(port);
 	}
-
-	return 0;
 }
=20
 static const struct vio_device_id vcc_match[] =3D {
--=20
2.30.0
