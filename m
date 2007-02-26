From: Emanuele Rocca <ema@debian.org>
Date: Mon, 26 Feb 2007 23:14:49 +0000
Subject: Re: 2.6.20 unaligned accesses
Message-Id: <20070226231449.GA6522@darkmoon.home>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
List-Id: <sparclinux.vger.kernel.org>
References: <200702231155.25915.andrew@walrond.org>
In-Reply-To: <200702231155.25915.andrew@walrond.org>
To: sparclinux@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

* Andrew Walrond <andrew@walrond.org>, [2007-02-23 11:55 +0000]:
>  On a Sun T1000 running 2.6.20 I'm seeing lots of these:
> =20
>  Kernel unaligned access at TPC[63d47c] Kernel unaligned access at TPC[63=
d47c]=20
>  Kernel unaligned access at TPC[63d47c] aoenet_rcv+0xa4/0x190
[...]

On a Sun Blade 2000 I got this one every time I load eth1394:
Kernel unaligned access at TPC[101880c8] ether1394_reset_priv+0x2c/0xb8 [et=
h1394]

I got rid of the message with the following patch:

--- drivers/ieee1394/eth1394.c.old      2007-02-26 23:07:21.000000000 +0100
+++ drivers/ieee1394/eth1394.c  2007-02-26 23:58:57.000000000 +0100
@@ -65,6 +65,7 @@
 #include <asm/uaccess.h>
 #include <asm/delay.h>
 #include <asm/semaphore.h>
+#include <asm/unaligned.h>
 #include <net/arp.h>

 #include "csr1212.h"
@@ -491,7 +492,7 @@
        int i;
        struct eth1394_priv *priv =3D netdev_priv(dev);
        struct hpsb_host *host =3D priv->host;
-       u64 guid =3D *((u64*)&(host->csr.rom->bus_info_data[3]));
+       u64 guid =3D get_unaligned(&(host->csr.rom->bus_info_data[3]));
        u16 maxpayload =3D 1 << (host->csr.max_rec + 1);
        int max_speed =3D IEEE1394_SPEED_MAX;

ciao,
    ema

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF42npC6DuA+rxm2ARAljLAJ9W4WgMlpCPDjQJKzNpJ3jYHlnxKwCcDz7l
mo+cqqhs5gOnxtGsH1D9HAU=
=6vsW
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
