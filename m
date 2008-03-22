From: David Miller <davem@davemloft.net>
Date: Sat, 22 Mar 2008 00:12:08 +0000
Subject: [SILO PATCH]: Support larger sparc64 kernels
Message-Id: <20080321.171208.194307718.davem@davemloft.net>
List-Id: <sparclinux.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: sparclinux@vger.kernel.org


This SILO patch, coupled with a sparc64 kernel patch which
I've checked into the sparc-2.6 GIT tree and will post
as a follow-up, allows up to 64MB kernel images.

Note that this takes care of only disk and CDROM boots,
there are still limits to tftpboot image size due
to openfirmware limitations that can't be eliminated
without implementing a full two-stage netboot loader.

Signed-off-by: David S. Miller <davem@davemloft.net>

diff --git a/second/main.c b/second/main.c
index d5285bb..4f753b0 100644
--- a/second/main.c
+++ b/second/main.c
@@ -1205,12 +1205,16 @@ try_again:
 		unsigned int size;
 		unsigned char *mem;
 
-		size = 0x800000;
-		mem = (unsigned char *)image_memory_find(size);
-
-		if (!mem) {
-		    size = 0x400000;
-		    mem = (unsigned char *)image_memory_find(size);
+		/* As of 2.6.25-rc6, an "allyesconfig" kernel is around
+		 * ~42MB in size.  So we try to carve out up to 64MB of
+		 * memory for the kernel.
+		 */
+		for (size = 64 * 1024 * 1024;
+		     size >= 4 * 1024 * 1024;
+		     size -= 4 * 1024 * 1024) {
+			mem = (unsigned char *)image_memory_find(size);
+			if (mem)
+				break;
 		}
 
 		if (mem) {
