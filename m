From: Randy Dunlap <rdunlap@infradead.org>
Date: Thu, 26 Nov 2020 00:39:57 +0000
Subject: [PATCH] fbdev: aty: SPARC64 requires FB_ATY_CT
Message-Id: <20201126003957.19604-1-rdunlap@infradead.org>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, sparclinux@vger.kernel.org, "David S. Miller" <davem@davemloft.net>

It looks like SPARC64 requires FB_ATY_CT to build without errors,
so adjust the Kconfig entry of FB_ATY_CT so that it is always 'y'
for SPARC64 && PCI by disabling the prompt for SPARC64 && PCI.

As it currently is, FB_ATY_CT can be disabled, resulting in build
errors:

ERROR: modpost: "aty_postdividers" [drivers/video/fbdev/aty/atyfb.ko] undefined!
ERROR: modpost: "aty_ld_pll_ct" [drivers/video/fbdev/aty/atyfb.ko] undefined!

Fixes: f7018c213502 ("video: move fbdev to drivers/video/fbdev")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: David Airlie <airlied@linux.ie>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20201124.orig/drivers/video/fbdev/Kconfig
+++ linux-next-20201124/drivers/video/fbdev/Kconfig
@@ -1277,7 +1277,7 @@ config FB_ATY
 	  module will be called atyfb.
 
 config FB_ATY_CT
-	bool "Mach64 CT/VT/GT/LT (incl. 3D RAGE) support"
+	bool "Mach64 CT/VT/GT/LT (incl. 3D RAGE) support" if !(SPARC64 && PCI)
 	depends on PCI && FB_ATY
 	default y if SPARC64 && PCI
 	help
