From: Jurij Smakov <jurij@wooyd.org>
Date: Sun, 03 Dec 2006 21:55:22 +0000
Subject: [PATCH] Fix for sunhme failures on x86
Message-Id: <20061203215522.GA4706@droopy.oc.cox.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Hi,

The following patch fixes the failure of sunhme drivers on x86 hosts
due to missing pci_enable_device() and pci_set_master() calls, lost 
during code refactoring. It has been filed as bugzilla bug #7502 [0] 
and Debian bug #397460 [1].

[0] http://bugzilla.kernel.org/show_bug.cgi?idu02
[1] http://bugs.debian.org/397460

Signed-off-by: Jurij Smakov <jurij@wooyd.org>

diff -aur a/drivers/net/sunhme.c b/drivers/net/sunhme.c
--- a/drivers/net/sunhme.c	2006-11-18 19:28:22.000000000 -0800
+++ b/drivers/net/sunhme.c	2006-11-23 10:36:36.000000000 -0800
@@ -3012,6 +3012,11 @@
 #endif
 
 	err = -ENODEV;
+
+	if (pci_enable_device(pdev))
+		goto err_out;
+	pci_set_master(pdev);
+
 	if (!strcmp(prom_name, "SUNW,qfe") || !strcmp(prom_name, "qfe")) {
 		qp = quattro_pci_find(pdev);
 		if (qp = NULL)

-- 
Jurij Smakov                                           jurij@wooyd.org
Key: http://www.wooyd.org/pgpkey/                      KeyID: C99E03CC
