From: Friedrich Oslage <bluebird@gentoo.org>
Date: Mon, 09 Mar 2009 00:30:37 +0000
Subject: sunhme: SBUS QFE not detected anymore
Message-Id: <49B4632D.7010606@gentoo.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050900050308030504030309"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------050900050308030504030309
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

my Ultra 2 has a SBUS Happy Meal and a SBUS Quad FastEthernet, both used
to work fine but the qfe is no longer detected since:

0b492fce3d72d982a7981905f85484a1e1ba7fde
sunhme: Don't match PCI devices in SBUS probe.


The parent node, sbus_dp, seems not to be set correctly. And the
sbus_dp->name == "sbus" check fails.

According to prtconf [0] the tree looks like this:

SUNW,Ultra-2
  sbus
    SUNW,hme
    SUNW,qfe
    SUNW,qfe
    SUNW,qfe
    SUNW,qfe

Setting sbus_dp = to_of_device(op->dev.parent->parent)->node will
therefore get "SUNW,Ultra-2" instead of "sbus".

This also makes reading the burst sizes fail and end up with the
default, 0x0.

I attached a patch :)

[0]http://git.kernel.org/?p=linux/kernel/git/davem/prtconfs.git;a=blob_plain;f=ultra2_2

Cheers,
Friedrich

--------------050900050308030504030309
Content-Type: text/x-patch;
 name="sunhme-qfe.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sunhme-qfe.patch"

    sunhme: Fix qfe parent detection.
    
    Signed-off-by: Friedrich Oslage <bluebird@gentoo.org>

diff --git a/drivers/net/sunhme.c b/drivers/net/sunhme.c
index d4fb4ac..4e9bd38 100644
--- a/drivers/net/sunhme.c
+++ b/drivers/net/sunhme.c
@@ -2649,8 +2649,6 @@ static int __devinit happy_meal_sbus_probe_one(struct of_device *op, int is_qfe)
 	int err = -ENODEV;
 
 	sbus_dp = to_of_device(op->dev.parent)->node;
-	if (is_qfe)
-		sbus_dp = to_of_device(op->dev.parent->parent)->node;
 
 	/* We can match PCI devices too, do not accept those here. */
 	if (strcmp(sbus_dp->name, "sbus"))

--------------050900050308030504030309--
