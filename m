From: Dennis Gilmore <dennis@ausil.us>
Date: Wed, 05 Jan 2011 20:05:10 +0000
Subject: [patch] use __devexit not __exit in n2_unregister_algs fixes build
Message-Id: <20110105140510.3d0a8d29@athosian.ausil.us>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="MP_/3w=XQzqdlt=YVu1dUc9IVU5"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

--MP_/3w=XQzqdlt=YVu1dUc9IVU5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Kernel builds on fedora have been failing with 

`.exit.text' referenced in section `.devexit.text' of drivers/built-in.o: defined in discarded section `.exit.text' of drivers/built-in.o
+ /usr/lib/rpm/debugedit -b /builddir/build/BUILD -d /usr/src/debug -i .tmp_vmlinux1
Failed to open input file '.tmp_vmlinux1': No such file or directory

the attached patch fixes building.


Dennis
--MP_/3w=XQzqdlt=YVu1dUc9IVU5
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-use-__devexit-not-__exit-in-n2_unregister_algs-fixes.patch

From 56a2432f60ea0a0c85a93b0951ae8507e5b85270 Mon Sep 17 00:00:00 2001
From: dennis <dennis@daedalus.ausil.us>
Date: Wed, 5 Jan 2011 19:43:25 +0000
Subject: [PATCH] use __devexit not __exit in n2_unregister_algs fixes build failure on fedora

thanks to kylem for helping with debugging
---
 drivers/crypto/n2_core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
index 88ee015..3372491 100644
--- a/drivers/crypto/n2_core.c
+++ b/drivers/crypto/n2_core.c
@@ -1542,7 +1542,7 @@ out:
 	return err;
 }
 
-static void __exit n2_unregister_algs(void)
+static void __devexit n2_unregister_algs(void)
 {
 	mutex_lock(&spu_lock);
 	if (!--algs_registered)
-- 
1.6.6.1


--MP_/3w=XQzqdlt=YVu1dUc9IVU5--
