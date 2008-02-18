From: =?ISO-8859-1?Q?BERTRAND_Jo=EBl?= <joel.bertrand@systella.fr>
Date: Mon, 18 Feb 2008 21:34:25 +0000
Subject: [PATCH] ESP driver
Message-Id: <47B9F9E1.8020007@systella.fr>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

	Hello,

	I think I have found a bug in esp_scsi.c. Without this patch, my 
SS20/SMP was not able to rebuild its internal raid1 volume due to esp0 
DMA errors. With the following patch, same workstation is building a 
kernel, doing a rsync (between two local directories) and rebuilding a 
26 GB raid1 volume without any trouble.

Signed-off-by: BERTRAND Joel <joel.bertrand@systella.fr>

Index: linux/drivers/scsi/esp_scsi.c
=================================--- linux/drivers/scsi/esp_scsi.c.orig 2008-02-18 16:50:14.000000000 +0100
+++ linux/drivers/scsi/esp_scsi.c      2008-02-18 16:52:17.000000000 +0100
@@ -961,6 +961,7 @@
         switch (esp->rev) {
         case ESP100:
         case ESP100A:
+       case FAS100A:
               /* The interrupt pending bit of the status register cannot
                * be trusted on these revisions.
                */


	Regards,

	JKB
