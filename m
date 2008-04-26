From: Robert Reif <reif@earthlink.net>
Date: Sat, 26 Apr 2008 03:22:28 +0000
Subject: [PATCH] sparc: fix drivers/video/tcx.c warning
Message-Id: <48129FF4.7040701@earthlink.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080500070801080403010000"
List-Id: <sparclinux.vger.kernel.org>
To: sparclinux@vger.kernel.org

This is a multi-part message in MIME format.
--------------080500070801080403010000
Content-Type: text/plain; charset="windows-1252"; format="flowed"
Content-Transfer-Encoding: quoted-printable

Fix compile warning:

CC drivers/video/tcx.o
drivers/video/tcx.c: In function =91tcx_init_one=92:
drivers/video/tcx.c:477: warning: format =91%lx=92 expects type =91long=20
unsigned int=92, but argument 4 has type =91resource_size_t=92

This was the only sparc driver to use the resource directly in the
printk so I changed it to physbase like the other drivers.
Boot tested on SS4.

Signed-off-by: Robert Reif <reif@earthlink.net>


--------------080500070801080403010000
Content-Type: text/plain;
 name="tcx.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="tcx.diff.txt"

diff --git a/drivers/video/tcx.c b/drivers/video/tcx.c
index e5a9ddb..fd94dfb 100644
--- a/drivers/video/tcx.c
+++ b/drivers/video/tcx.c
@@ -419,7 +419,7 @@ static int __devinit tcx_init_one(struct of_device *op)
 		par->mmap_map[6].size = SBUS_MMAP_EMPTY;
 	}
 
-	par->physbase = 0;
+	par->physbase = op->resource[0].start;
 	par->which_io = op->resource[0].flags & IORESOURCE_BITS;
 
 	for (i = 0; i < TCX_MMAP_ENTRIES; i++) {
@@ -473,7 +473,7 @@ static int __devinit tcx_init_one(struct of_device *op)
 	printk("%s: TCX at %lx:%lx, %s\n",
 	       dp->full_name,
 	       par->which_io,
-	       op->resource[0].start,
+	       par->physbase,
 	       par->lowdepth ? "8-bit only" : "24-bit depth");
 
 	return 0;

--------------080500070801080403010000--
