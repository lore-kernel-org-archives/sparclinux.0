From: =?UTF-8?Q?Ren=c3=a9_Rebe?= <rene@exactcode.com>
Date: Tue, 26 Dec 2017 20:06:58 +0000
Subject: [PATCH^WHACK] sun_esp v2 on older sparc
Message-Id: <8b01d2e6-341f-9f43-f29b-9385d489529b@exactcode.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

Hi,

just when support for sun4c was deleted from the mainline tree you found=20
someone crazy enough to take it out of the attic and give it a try for=20
the vintage Christmas fun. Using the last booting kernel I found the=20
sun_esp SCSI controller would not show up. With a little hack I=20
surprisingly could get it to work. Looks like the v2 driver rewrite=20
assumes that the "dma" device is the parent, while on this SPARCstation=20
2 all the devices are next to each other.

You probably already want to ignore this as I mention sun4c and=20
SPARCstation2, but maybe it affects other currently supported vintage=20
machines - I only have one sparc32, this SS2, ...

The older driver compared the sbus bus and slot number to match. If you=20
have a better, real implementation I'm happy to cross compile and test=20
boot it ;-) On the next rainy weekend I might try to find out why >=3D3.0=20
hang, probably the untested genirq support, ...

--- linux-2.6.39.4/drivers/scsi/sun_esp.c.vanilla	2017-12-26=20
12:21:15.881902541 +0000
+++ linux-2.6.39.4/drivers/scsi/sun_esp.c	2017-12-26 14:17:09.061647990=20
+0000
@@ -577,6 +580,10 @@
  		dma_node =3D op->dev.of_node;
  		hme =3D 1;
  	}
+	if (!dma_node) {
+		dma_node =3D of_find_node_by_name(dp->parent, "dma");
+	}
+
  	if (dma_node)
  		dma_of =3D of_find_device_by_node(dma_node);
  	if (!dma_of)



--=20
   Ren=C3=A9 Rebe, ExactCODE GmbH, Lietzenburger Str. 42, DE-10789 Berlin
   https://exactcode.com | https://t2sde.org | https://rene.rebe.de
