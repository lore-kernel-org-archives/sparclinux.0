From: Jiri Gaisler <jiri@gaisler.com>
Date: Tue, 04 Jan 2005 19:04:11 +0000
Subject: [3/7] LEON SPARC V8 processor support for linux-2.6.10
Message-Id: <41DAE8AB.1020002@gaisler.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------040002060508040502040601"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, wli@holomorphy.com

This is a multi-part message in MIME format.
--------------040002060508040502040601
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

linux-2.6.10: Kernel patches:

[3/7] diff2.6.10_drivers_sbus.diff:       diff for drivers/sbus

--------------040002060508040502040601
Content-Type: text/plain;
 name="diff2.6.10_drivers_sbus.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="diff2.6.10_drivers_sbus.diff"

diff -Naur ../linux-2.6.10/drivers/sbus/sbus.c linux-2.6.10/drivers/sbus/sbus.c
--- ../linux-2.6.10/drivers/sbus/sbus.c	2004-12-24 22:35:50.000000000 +0100
+++ linux-2.6.10/drivers/sbus/sbus.c	2005-01-03 11:36:33.000000000 +0100
@@ -358,6 +358,8 @@
 		   (nd = prom_searchsiblings(nd, "sbi")) == 0) {
 		   	panic("sbi not found");
 		}
+	} else if(sparc_cpu_model == sparc_leon) {
+		return 0;
 	} else if((nd = prom_searchsiblings(topnd, "sbus")) == 0) {
 		if((iommund = prom_searchsiblings(topnd, "iommu")) == 0 ||
 		   (nd = prom_getchild(iommund)) == 0 ||

--------------040002060508040502040601--
