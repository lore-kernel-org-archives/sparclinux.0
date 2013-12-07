From: Aaro Koskinen <aaro.koskinen@iki.fi>
Date: Sat, 07 Dec 2013 23:26:54 +0000
Subject: [PATCH 05/10] tilo: make root image optional
Message-Id: <1386458819-6590-6-git-send-email-aaro.koskinen@iki.fi>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org

Make root image optional.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 tilo/maketilo.c | 35 ++++++++++++++++++++---------------
 tilo/tilo.sh    | 11 +++++++----
 2 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/tilo/maketilo.c b/tilo/maketilo.c
index 0a14a96149dc..30eaef4c2868 100644
--- a/tilo/maketilo.c
+++ b/tilo/maketilo.c
@@ -56,7 +56,7 @@ int root_tweak (char *s)
 int main (int argc, char **argv)
 {
 	int i,len,rootlen;
-	FILE *f, *g;
+	FILE *f, *g = NULL;
 	struct ImageInfo *ii;
 
 	char *sun4_kernel_start;
@@ -112,26 +112,26 @@ int main (int argc, char **argv)
 	
 	if (!sun4_kernel) {
 		/*fprintf (stderr, "WARNING: Kernel for Sun4 not specified\n");*/
-	} else if (!sun4_size || !sun4_root) {
+	} else if (!sun4_size || (!sun4_root && root_image)) {
 		fprintf (stderr, "WARNING: Original size and root address must be specified for Sun4\n");
 		return -1;
 	}
 	
 	if (!sun4c_kernel) {
 		fprintf (stderr, "WARNING: Kernel for Sun4c/m/d not specified\n");
-	} else if (!sun4c_size || !sun4c_root) {
+	} else if (!sun4c_size || (!sun4c_root && root_image)) {
 		fprintf (stderr, "ERROR: Original size and root address must be specified for Sun4c\n");
 		return -1;
 	}
 	
 	if (!sun4u_kernel) {
 		fprintf (stderr, "WARNING: Kernel for Sun4u not specified\n");
-	} else if (!sun4u_size || !sun4u_root) {
+	} else if (!sun4u_size || (!sun4u_root && root_image)) {
 		fprintf (stderr, "ERROR: Original size and root address must be specified for Sun4u\n");
 		return -1;
 	}
 	
-	if (!root_image) {
+	if (!root_image && (sun4_root || sun4c_root || sun4u_root)) {
 		fprintf (stderr, "ERROR: Root image not specified\n");
 		return -1;
 	}
@@ -141,16 +141,19 @@ int main (int argc, char **argv)
 		return -1;
 	}
 	
-	g = fopen (root_image, "rb");
-	if (!g) {
-		fprintf (stderr, "Can't load %s\n", root_image);
-		return -1;
+	if (root_image) {
+		g = fopen (root_image, "rb");
+		if (!g) {
+			fprintf (stderr, "Can't load %s\n", root_image);
+			return -1;
+		}
+		fseek (g, 0, SEEK_END);
+		rootlen = ftell (g);
+		fseek (g, 0, SEEK_SET);
+	} else {
+		rootlen = 0;
 	}
 	
-	fseek (g, 0, SEEK_END);
-	rootlen = ftell (g);
-	fseek (g, 0, SEEK_SET);
-	
 	if (rootlen + sun4_size + 0x4000 + 0x10000 >= 0x330000 ||
 	    rootlen + sun4c_size + 0x4000 + 0x10000 >= 0x330000 ||
 	    rootlen + sun4u_size + 0x4000 + 0x10000 >= 0x330000) {
@@ -215,8 +218,10 @@ int main (int argc, char **argv)
 
 	root_image_start = sun4u_kernel_start + len;
 	
-	fread (root_image_start, 1, rootlen, g);
-	fclose (g);
+	if (root_image) {
+		fread (root_image_start, 1, rootlen, g);
+		fclose (g);
+	}
 
 	output_end = root_image_start + rootlen;
 
diff --git a/tilo/tilo.sh b/tilo/tilo.sh
index 782a0305646b..8cf4d7674439 100755
--- a/tilo/tilo.sh
+++ b/tilo/tilo.sh
@@ -57,9 +57,11 @@ do_image () {
 	echo "  packed size  = $PSIZE"
 	echo "  root address = $ROOTA"
 	if [ -n "$sun4u" ]; then
-		tilo_args="$tilo_args sun4u=$KERNEL.gz size4u=$SIZE root4u=$ROOTA"
+		tilo_args="$tilo_args sun4u=$KERNEL.gz size4u=$SIZE"
+		root_addr="$root_addr root4u=$ROOTA"
 	else
-		tilo_args="$tilo_args sun4c=$KERNEL.gz size4c=$SIZE root4c=$ROOTA"
+		tilo_args="$tilo_args sun4c=$KERNEL.gz size4c=$SIZE"
+		root_addr="$root_addr root4c=$ROOTA"
 	fi
 }
 
@@ -80,7 +82,7 @@ do_root () {
 	fi
 	ROOT_SIZE=`ls -l $rootimg | awk '{print$5}'`
 	echo Root image packed size = $ROOT_SIZE
-	tilo_args="$tilo_args root=$rootimg"
+	root_img="root=$rootimg"
 }
 
 while [ $# != 0 ]; do
@@ -112,7 +114,8 @@ if [ -z "$sun4u" -a -z "$sun4c" ]; then
 	exit 1
 fi
 
-`echo $0 | sed 's/tilo\.sh$/maketilo/'` $tilo_args out=$output
+[ -n "$root_img" ] && root_img="$root_img $root_addr"
+`echo $0 | sed 's/tilo\.sh$/maketilo/'` $tilo_args $root_img out=$output
 
 rm -f $to_remove
 
-- 
1.8.4.4

