From: Jiri Gaisler <jiri@gaisler.com>
Date: Tue, 04 Jan 2005 19:04:27 +0000
Subject: [5/7] LEON SPARC V8 processor support for linux-2.6.10
Message-Id: <41DAE8BB.7050501@gaisler.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070905020909070305050406"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com

This is a multi-part message in MIME format.
--------------070905020909070305050406
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Leon3 serial+ethermac driver:

[5/7] diff2.6.10_arch_sparc_Kocnfig.diff  diff for arch/sparc/Kconfig

--------------070905020909070305050406
Content-Type: text/plain;
 name="diff2.6.10_arch_sparc_Kocnfig.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff2.6.10_arch_sparc_Kocnfig.diff"

--- ../linux-2.6.10-driver/arch/sparc/Kconfig	2005-01-03 18:03:49.000000000 +0100
+++ linux-2.6.10/arch/sparc/Kconfig	2005-01-03 18:01:44.000000000 +0100
@@ -239,12 +239,6 @@
 	  Say Y here if you are running on a Leon3 from grlib
 	  (download from www.gaisler.com). 
 
-if LEON_3
-
-source "drivers/amba/Kconfig"
-
-endif
-
 endif
 
           

--------------070905020909070305050406--
