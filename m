From: "David S. Miller" <davem@davemloft.net>
Date: Mon, 13 Jun 2005 22:47:49 +0000
Subject: Re: Working config wanted for 2.6.11, Ultra 5, sparc64
Message-Id: <20050613.154749.27780799.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
References: <20050613195547.6BC1B42B25@bass.stat.ufl.edu>
In-Reply-To: <20050613195547.6BC1B42B25@bass.stat.ufl.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

From: Jason Wever <weeve@gentoo.org>
Date: Mon, 13 Jun 2005 16:43:15 -0600 (MDT)

> When abouts in the 2.6 series was this?  I used 2.6.6 for a long time on =

> the Blade 100 with this config (due to SCSI lockup issues with a SYMBIOS =

> card in other versions of 2.6) but I haven't tested >=C2.6.11 in a=20
> non-headless configuration.

It was the following change, which went into Linus's bitkeeper
tree on Feb. 15, 2005

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/02/15 08:23:00-08:00 davem@nuts.davemloft.net=20
#   [SPARC]: Fix video mode probing in atyfb driver.
#  =20
#   On Sparc, if the user does not specify a mode option, we
#   should use the PROM probed values in default_var always.
#  =20
#   Signed-off-by: David S. Miller <davem@davemloft.net>
#=20
# drivers/video/aty/atyfb_base.c
#   2005/02/15 08:22:09-08:00 davem@nuts.davemloft.net +9 -1
#   [SPARC]: Fix video mode probing in atyfb driver.
#=20
diff -Nru a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c	2005-06-13 15:46:56 -07:00
+++ b/drivers/video/aty/atyfb_base.c	2005-06-13 15:46:56 -07:00
@@ -2511,7 +2511,15 @@
 		}
 	} else
 #endif /* !CONFIG_PPC */
-	if (!fb_find_mode(&var, info, mode, NULL, 0, &defmode, 8))
+	if (
+#if defined(CONFIG_SPARC32) || defined(CONFIG_SPARC64)
+	   /* On Sparc, unless the user gave a specific mode
+	    * specification, use the PROM probed values in
+	    * default_var.
+	    */
+	    !mode ||
+#endif
+	    !fb_find_mode(&var, info, mode, NULL, 0, &defmode, 8))
 		var =3D default_var;
=20
 	if (noaccel)
