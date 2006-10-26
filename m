From: Per =?iso-8859-1?q?=D8yvind_Karlsen?= <pkarlsen@mandriva.com>
Date: Thu, 26 Oct 2006 11:36:20 +0000
Subject: bcm43xx build fix
Message-Id: <200610261336.20338.pkarlsen@mandriva.com>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: sparclinux@vger.kernel.org

This one was broken in 2.6.19-rc3, fix:
--- drivers/net/wireless/bcm43xx/bcm43xx_dma.h~ 2006-10-25 22:06:51.0000000=
00=20
+0200
+++ drivers/net/wireless/bcm43xx/bcm43xx_dma.h  2006-10-26 13:30:57.0000000=
00=20
+0200
@@ -5,6 +5,7 @@
 #include <linux/spinlock.h>
 #include <linux/workqueue.h>
 #include <linux/linkage.h>
+#include <linux/dma-mapping.h>
 #include <asm/atomic.h>

--=20
Regards,
Per =D8yvind Karlsen
Mandriva
