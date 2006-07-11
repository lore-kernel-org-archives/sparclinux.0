From: "Tom 'spot' Callaway" <tcallawa@redhat.com>
Date: Tue, 11 Jul 2006 21:27:56 +0000
Subject: [2.6 PATCH] Fix make headers_install for sparc64
Message-Id: <1152653276.12430.255.camel@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-x3Cb0R23HZpV+IKuOanM"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org


--=-x3Cb0R23HZpV+IKuOanM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

A minor typo in the include/asm-sparc64/Kbuild file prevents the make
headers_install from building a useful tree of kernel headers for
sparc64. 

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Tom "spot" Callaway <tcallawa@redhat.com>

--- a/include/asm-sparc64/Kbuild.BAD 2006-07-11 17:57:41.000000000 -0400
+++ b/include/asm-sparc64/Kbuild 2006-07-11 17:57:50.000000000 -0400
@@ -4,7 +4,7 @@
 ARCHDEF := defined __sparc__ && defined __arch64__
 ALTARCHDEF := defined __sparc__ && !defined __arch64__
 
-unifdef-y := fbio.h perfctr.h
+unifdef-y += fbio.h perfctr.h
 header-y += apb.h asi.h bbc.h bpp.h display7seg.h envctrl.h floppy.h	\
 	ipc.h kdebug.h mostek.h openprom.h openpromio.h parport.h	\
 	pconf.h psrcompat.h pstate.h reg.h uctx.h utrap.h watchdog.h

~spot
-- 
Tom "spot" Callaway: Red Hat Technical Team Lead || GPG ID: 93054260
Fedora Extras Steering Committee Member (RPM Standards and Practices)
Aurora Linux Project Leader: http://auroralinux.org
Lemurs, llamas, and sparcs, oh my!

--=-x3Cb0R23HZpV+IKuOanM
Content-Disposition: attachment; filename=linux-2.6.18-rc1-git1-sparc64headers.patch
Content-Type: text/x-patch; name=linux-2.6.18-rc1-git1-sparc64headers.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.18-rc1-git1/include/asm-sparc64/Kbuild.BAD	2006-07-11 17:57:41.000000000 -0400
+++ linux-2.6.18-rc1-git1/include/asm-sparc64/Kbuild	2006-07-11 17:57:50.000000000 -0400
@@ -4,7 +4,7 @@
 ARCHDEF := defined __sparc__ && defined __arch64__
 ALTARCHDEF := defined __sparc__ && !defined __arch64__
 
-unifdef-y := fbio.h perfctr.h
+unifdef-y += fbio.h perfctr.h
 header-y += apb.h asi.h bbc.h bpp.h display7seg.h envctrl.h floppy.h	\
 	ipc.h kdebug.h mostek.h openprom.h openpromio.h parport.h	\
 	pconf.h psrcompat.h pstate.h reg.h uctx.h utrap.h watchdog.h

--=-x3Cb0R23HZpV+IKuOanM--

